# See Spark processes
$ yarn application -list
# Another way
$ yarn top
# Kill an Spark process
$ yarn application -kill <application_id>

#------------------ Example ------------------
$ yarn application -list
  Total number of applications (application-types: [] and states: [SUBMITTED, ACCEPTED, RUNNING]):1
  Application-Id         Application-Name         Application-Type
  User Queue
  State Final-State Progress
  1524270479010_12398 Hive on Spark
  RUNNING UNDEFINED 10%
  Tracking-URL
     http://10.1.0.20:35502
  hive root.users.fxr47

$ yarn application -kill application_1524270479010_12398
  Killing application application_1524270479010_12398
  18/07/23 12:25:15 INFO impl.YarnClientImpl: Killed application application_1524270479010_12398

$ yarn node -list -showDetails
20/05/30 18:07:40 INFO client.RMProxy: Connecting to ResourceManager at ip-172-31-0-131.ec2.internal/172.31.0.131:8032
Total Nodes:3
         Node-Id	     Node-State	Node-Http-Address	Number-of-Running-Containers
ip-172-31-11-102.ec2.internal:8041	        RUNNING	ip-172-31-11-102.ec2.internal:8042	                           7
Detailed Node Information :
	Configured Resources : <memory:385024, vCores:48>
	Allocated Resources : <memory:340480, vCores:7>
	Resource Utilization by Node : PMem:137290 MB, VMem:137290 MB, VCores:46.906666
	Resource Utilization by Containers : PMem:131500 MB, VMem:443037 MB, VCores:46.991
	Node-Labels : CORE
ip-172-31-5-19.ec2.internal:8041	        RUNNING	ip-172-31-5-19.ec2.internal:8042	                           7
Detailed Node Information :
	Configured Resources : <memory:385024, vCores:48>
	Allocated Resources : <memory:340480, vCores:7>
	Resource Utilization by Node : PMem:135857 MB, VMem:135857 MB, VCores:46.793335
	Resource Utilization by Containers : PMem:130015 MB, VMem:424662 MB, VCores:46.827
	Node-Labels : CORE
ip-172-31-4-191.ec2.internal:8041	        RUNNING	ip-172-31-4-191.ec2.internal:8042	                           8
Detailed Node Information :
	Configured Resources : <memory:385024, vCores:48>
	Allocated Resources : <memory:341376, vCores:8>
	Resource Utilization by Node : PMem:137296 MB, VMem:137296 MB, VCores:45.278244
	Resource Utilization by Containers : PMem:131790 MB, VMem:427172 MB, VCores:45.454
	Node-Labels : CORE


$ yarn node -list -states RUNNING
20/05/30 18:09:49 INFO client.RMProxy: Connecting to ResourceManager at ip-172-31-0-131.ec2.internal/172.31.0.131:8032
Total Nodes:3
         Node-Id	     Node-State	Node-Http-Address	Number-of-Running-Containers
ip-172-31-11-102.ec2.internal:8041	        RUNNING	ip-172-31-11-102.ec2.internal:8042	                           7
ip-172-31-5-19.ec2.internal:8041	        RUNNING	ip-172-31-5-19.ec2.internal:8042	                           7
ip-172-31-4-191.ec2.internal:8041	        RUNNING	ip-172-31-4-191.ec2.internal:8042	                           8
#------------------ \Example ------------------


# See Hive processes
mapred job -list

# Kill a Hive process
mapred job -kill <job_id>
hadoop job -kill <job_id> (deprecated)

$  mapred job -list 2>/dev/null
Total jobs:1
                  JobId      State
UsedContainers  RsvdContainers UsedMem
 job_1536281672260_1339    RUNNING
NORMAL                    2
http://arhdpmgtprka002.eis.equifax.com:8088/proxy/application_1536281672260_1339/

