# Get all the nodes in cluster
hdfs dfsadmin -report | grep Hostname
  Hostname: ip-172-31-2-122.ec2.internal
  Hostname: ip-172-31-9-212.ec2.internal

# Get some options of the command
$ hadoop fs -help

# List a file or dir
$ hadoop fs -ls <hdfs_path>/

# Create a new folder recursively
$ hadoop fs -mkdir -p <hdfs_path>

# Get the whole directory
$ hadoop fs -get <hdfs_path>/archive=20180810/*

# Copy a file into the HDFS (not sure the difference between put and -copyFromLocal
$ hadoop fs -put test_sum.py <hdfs_path>/
$ hadoop fs -copyFromLocal -f ./file.py <hdfs_path>/file.py

# Creation date of a file
$ hadoop fs -stat <hdfs_path>/a.py
# output: 2018-07-27 18:16:16

# Read the number of lines in a csv file
$ hadoop fs -cat <hdfs_path>/file.csv | wc -l

# Used space in the HDFS
# Space used by a folder. If replication rate is 3: Every file will be copied 3 times in the HDFS cluster

$ hadoop fs -du -s -h <hdfs_path>/* | sort -nr
924.0 K  2.7 M  <hdfs_path>
489.1 K  1.4 M  <hdfs_path>
364.0 K  1.1 M  <hdfs_path>
...

# Full report of used space
$ hdfs dfsadmin -report
Configured Capacity: 707397419335680 (643.37 TB)
Present Capacity: 707356592558541 (643.34 TB)
DFS Remaining: 480108087615379 (436.66 TB)
DFS Used: 227248504943162 (206.68 TB)
DFS Used%: 32.13%
Under replicated blocks: 0
Blocks with corrupt replicas: 0
Missing blocks: 0
Missing blocks (with replication factor 1): 0

