Mover data entre cuentas de AWS

La data source es accesible desde una cuenta y no desde la otra.
Fueron provistos los datos de 'awsaccesskey' y 'awssecrectkey' de la cuenta destion fueron provistos.

Con EMR se puede copiar la data al cluster y luego copiarla al destino.

1) Copiar la data de s3 al HDFS - En este caso la data es accesible desde EMR
	* s3-dist-cp --src s3://client-hpe-hpeidiom-us-9979/model-data/brand-awareness/features/2020-08-21_2054/ --dest /tmp/data/

2) Copiar la data desde HDFS al bucket destion
De https://d0.awsstatic.com/whitepapers/aws-amazon-emr-best-practices.pdf

Se puede usar estos comandos (no se se podría usar s3-dist-cp:
	- hadoop distcp hdfs:///data/ s3n://awsaccesskey:awssecrectkey@somebucket/mydata/
	- hadoop s3n://awsaccesskey:awssecrectkey@somebucket/mydata/ distcp hdfs:///data/

Comandos a probar:
	* hadoop distcp hdfs:///tmp/data/ s3n://XXXX:YYY@digitas-client-work/clients/hpe/clean/model-data/brand-awareness/deciled/2020-08-21/2054/
	* s3-dist-cp --src hdfs:///tmp/data/ --dest s3n://XXXX:YYY@digitas-client-work/clients/hpe/clean/model-data/brand-awareness/

------
Lo que hice y funcionó:
	El paso 1)
	Paso 1.2) copiar la data del HDFS a local (crear un root con espacio para la data): hadoop fs -get /tmp/data/part-001[1-3]* .
	Paso 2) con AWS CLI con el profile que tenia acceso (chait):
		aws s3 cp --recursive . s3://digitas-client-work/clients/hpe/clean/model-data/brand-awareness/deciled/2020-08-21/2054/ --profile chait

------
Otros links:
  https://medium.com/tensult/copy-s3-bucket-objects-across-aws-accounts-e46c15c4b9e1
  https://aws.amazon.com/premiumsupport/knowledge-center/copy-s3-objects-account/
  https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html
  https://stackoverflow.com/questions/22263369/is-it-possible-to-copy-between-aws-accounts-using-aws-cli