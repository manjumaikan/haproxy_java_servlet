# HAProxy balanced java servlet application

The HAProxy loadbalancer is exposed on 9000. The load is equally distributed on a round robin mechanism. Statistics of the HAProxy performance can be viewed on port 9500.

Note 2 docker containers are run as part of the program and run on local port 9010(docker port 9010) and 9020(docker port 9000). You can observe the switch of application by hitting the root context.

prerequisite:

ansible

assumptions:

- AWS credentials are configured on the machine running the ansible playbook.
- S3 bucket and dynamo db are created beforehand. terraform files and their state files are stored under terraform/common

run:

ansible-playbook playbooks/mmk_java_server/runall.yml -i inventory/deploy_instances --private-key secrets/mmk-java-servlet-key-pair.pem -e "TF_VAR_AWS_PROFILE=saml TF_VAR_AWS_REGION=ap-southeast-2"

usage:

Java servlet is exposed on the local port which is exposed during the run.

root context: <http://mmk-private-hosted-java-server.nbn-aws-learning.local.apps.sandpit.nbn-aws.local:9000/>

get header info: <http://mmk-private-hosted-java-server.nbn-aws-learning.local.apps.sandpit.nbn-aws.local:9000/echoHeader>

custom http get: <http://mmk-private-hosted-java-server.nbn-aws-learning.local.apps.sandpit.nbn-aws.local:9000/echoGet?name=Peter,Udayan,Manju>

reference:

<https://www.codeproject.com/Tips/1040097/Create-a-Simple-Web-Server-in-Java-HTTP-Server>