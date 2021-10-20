# Lv.629.DevOps
Lv.629.DevOps SoftServe Intership Projects

## Demo №1
Created High Availability GitBucket cluster using Ansible roles, which consisted of:
- Tomcat cluster that work with Session Replication, connected  NFS server and MySQL Server;
- Apache Load Balancer cluster with configured pacemaker cluster, proxy_module and sticky sessions;
- Virtual IP as a pacemaker cluster resource;
- Grafana server for monitoring and logs collection from all nodes using:
    - Prometheus
    - Node Exporter
    - Loki
    - Promtail

## Demo №2
#### Task - 1
Created a Jenkins PipeLine that automatically deploy and install dockerized application which consist of:
- Two nodes with dockerized GitBucket  tomcat application;
- Node with dockerized Apache load balancer;
- Node with dockerized MySQL Server for storing GitBucket data;
- Dockerized NFS server to share GitBucket app data between two nodes.

Jenkins master and jenkins worker which are set up to work as follows:
Jenkins use Poll SCM trigger to monitor changes in GitHub repository, when such a change occurs, jenkins begins downloading source files to its local repository, after that, using the publish over ssh jenkins plugin files are transferred to the appropriate servers and the `docker-compose up -d` command is run using a script.



#### Task - 2
Build a pipeline for the GitBucket tomcat application, using Amazon Web services. 
To do this, I used the following amazon resources: 
- CodePipeline;
- CodeBuild;
- S3 Bucket;
- Elastic Beanstalk;
- Amazon RDS;
- Systems Manager Parameter Store.

Also used Terraform to set up AWS Infrastructures.
Configure Terraform Cloud to work with 
GitHub Actions to automate deployments.
