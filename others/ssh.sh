ssh - BORRA

sudo vi /etc/ssh/ssh_config and 'StrictHostKeyChecking no'

echo "antes"; grep StrictHostKeyChecking /etc/ssh/ssh_config; sudo sed -i /'#   StrictHostKeyChecking ask'/'StrictHostKeyChecking no'/ /etc/ssh/ssh_config; echo "despues"; grep StrictHostKeyChecking /etc/ssh/ssh_config


ssh -A -t ruapehu.example.com ssh -A -t aoraki

ssh -i pk.pem hadoop@172.31.4.84 -t "free -h";ssh -i pk.pem hadoop@172.31.7.73 -t "free -h";ssh -i pk.pem hadoop@172.31.9.168 -t "free -h"


ssh -i ~/.ssh/kp-private-key.pem -A -t hadoop@ec2-3-235-88-115.compute-1.amazonaws.com ssh -A 172.31.11.102 -t "echo Slave_102; free -h"

ssh -i ~/.ssh/kp-private-key.pem -A -t hadoop@ec2-3-235-88-115.compute-1.amazonaws.com ssh -A 172.31.11.102 -t "hostname"

https://stackoverflow.com/questions/40897671/run-command-on-emr-slaves
#Copy ssh key(like ssh_key.pem) of the cluster to master node.
aws s3 cp s3://bucket/ssh_key.pem ~/

# change permissions to read
chmod 400 ssh_key.pem

# Run a PIP command
yarn node -list|sed -n "s/^\(ip[^:]*\):.*/\1/p" | xargs -t -I{} -P10 ssh -o StrictHostKeyChecking=no -i ~/ssh_key.pem hadoop@{} "pip install package"



Slaves:
$ sudo -u hdfs hdfs dfsadmin -report|grep Name
Name: 172.31.11.102:50010 (ip-172-31-11-102.ec2.internal)
Name: 172.31.4.191:50010 (ip-172-31-4-191.ec2.internal)
Name: 172.31.5.19:50010 (ip-172-31-5-19.ec2.internal)


