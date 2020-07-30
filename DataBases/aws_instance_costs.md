# AWS instance type costs
Link: https://www.ec2instances.info/


| Instance Type | Linux On Demand  | Linux Reserved   |
|---------------|------------------|------------------|
| m5.large      | $0.096000        | $0.060000        |
| r5.12xlarge   | $3.024000        | $1.905000        |
| m4.4xlarge    | $0.800000        | $0.495600        |
| m5.24xlarge   | $4.608000        | $2.903000        |

Prices are per hour

m4.4xlarge has these features:
* 64 Gib
* 16 vCPUs
* EBS only
* High (network)

__Problem__: Sometimes AWS ran out of EC2 availability 

These are some candidates to use instead:
* m5.4xlarge: cheaper but network is slower (10 Gbps)
* m5n.4xlarge: $0.952000 hourly, network of 25 Gbps
* r5.4xlarge: $1.008000 hourly, 128 GiB of memory
