# Handle big compressed files in Hadoop/Spark

## Problem: have one .gz big file (~100GB) in S3

* If we use s3-distcp to copy the file to EMR it will take a long time to upload.
* If we try to read directly with "spark.read.csv('file.csv.gz', sep='\t')",
  then it will exhaust one executor and the others will remain free. This will probably end with an strange error.

The thing is that .gz files are not splittable !!
    * https://aws.amazon.com/blogs/big-data/top-10-performance-tuning-tips-for-amazon-athena/
    * https://docs.cloudera.com/documentation/enterprise/5-3-x/topics/admin_data_compression_performance.html
For MapReduce, if you need your compressed data to be splittable, BZip2, LZO, and Snappy formats are splittable,
but GZip is not.
    * https://stackoverflow.com/questions/49490640/ho-to-read-gz-compressed-file-using-spark-df-or-ds
the only extra consideration to take into account is that the gz file is not splittable, therefore Spark needs to read 
the whole file using a single core which will slow things down..

## Possible solutions

### 1) EC2 > copy the file > transfor to a splittable formaat > copy back to S3
https://stackoverflow.com/questions/43829601/efficient-way-to-work-in-s3-gzip-file-from-emr-spark

### 1.1) Transform gz to bz2
https://superuser.com/questions/23533/converting-gzip-files-to-bzip2-efficiently
AFTER DOWNLOADING parallel & pbzip2 THIS WORKED !: 
    $ time ls *.gz | parallel "gunzip -c {} | pbzip2 -c > {.}.bz2"   

### 1.2.1) Divide the file in parts
https://linoxide.com/how-tos/howto-split-a-gzip-file-in-linux/
https://www.systutorials.com/how-to-split-a-gzip-file-to-several-small-ones-on-linux/

This is very fast !!:
    $ time split -b 128m b.csv dest/b.csv.part-
    
Possible problem: divide the file this way will be generate further issues to Spark since the file could be splitted 
without taking account for the whole line -> this could not be a solution !

Just in case, put all the parts back to one file: $ cat b.csv.gz.part-a* > bb.csv.gz

### 1.2.2) Uncompress, divide the file, compress back 
Two ways (not tested, but sure it will take some time for the uncompress/compress bakc):
    $ time zcat bb.csv.gz | split -l 3000000 – bb.csv.gz.part
    $ time gunzip –c bb.csv.gz | split -l 2000000 – bb.csv.gz.part

### 1.3) Use multipart upload
https://aws.amazon.com/blogs/big-data/seven-tips-for-using-s3distcp-on-amazon-emr-to-move-data-efficiently-between-hdfs-and-amazon-s3/#6

I think this is not a solution, upload is just to S3, not HDFS
time s3-dist-cp --src /data/gb200 --dest s3://my-tables/data/S3DistCp/gb200_2 --multipartUploadChunkSize=1000

### 1.4) Use python gzip
https://docs.python.org/3/library/gzip.html


### 1.5) Use this code in lambda
Haven't been tested ..
https://forums.aws.amazon.com/thread.jspa?messageID=895338

### 1.6) Use boto3
Some alternatives I din't try ..
https://stackoverflow.com/questions/41161006/reading-contents-of-a-gzip-file-from-a-aws-s3-in-python 

1)
	import boto3
	import gzip

	s3 = boto3.resource("s3")
	obj = s3.Object("YOUR_BUCKET_NAME", "path/to/your_key.gz")
	with gzip.GzipFile(fileobj=obj.get()["Body"]) as gzipfile:
	    content = gzipfile.read()
	print(content)

2)
	import pandas as pd
	role = 'role name'
	bucket = 'bucket name'
	data_key = 'data key'
	data_location = 's3://{}/{}'.format(bucket, data_key)
	data = pd.read_csv(data_location,compression='gzip', header=0, sep=',', quotechar='"') 


3) 
	s3 = boto3.resource('s3')
	obj = s3.Object('my-bucket-name','path/to/file.gz')
	buf = io.BytesIO(obj.get()["Body"].read()) # reads whole gz file into memory
	for line in gzip.GzipFile(fileobj=buf):
	    # do something with line	
