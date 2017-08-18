#!/bin/bash

AWS_CONFIG_FILE=$HOME/.aws/credentials
aws_vpc="vpc-724dbf15"
aws_cli_base="aws --profile qa --output text"
aws_group_create="${aws_cli_base} ec2 create-security-group --vpc-id "${aws_vpc}""
aws_group_allow="${aws_cli_base} ec2 authorize-security-group-ingress"
deployment="VO"

##HDD
t_group_name="${deployment}-HDD-App"
t_elb_group='sg-019cb97a'
t_group_id=$(${aws_group_create} --group-name "${t_group_name}" --description "Security Group for ${t_group_name} Instances")
${aws_cli_base} ec2 create-tags --resource ${t_group_id} --tags Key=Name,Value="${t_group_name}" Key=Deployment,Value="${deployment}"
${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 443 --source-group "${t_elb_group}"
${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 22 --source-group "sg-9ce844e7" --group-owner "259701781532"
echo "[INFO]  Created Group '${t_group_name}' with ID: ${t_group_id}"


##NLPQ
t_group_name="${deployment}-NLPQ-App"
t_elb_group='sg-f09cb98b'
t_group_id=$(${aws_group_create} --group-name "${t_group_name}" --description "Security Group for ${t_group_name} Instances")
${aws_cli_base} ec2 create-tags --resource ${t_group_id} --tags Key=Name,Value="${t_group_name}" Key=Deployment,Value="${deployment}"
${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 443 --source-group "${t_elb_group}"
${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 22 --source-group "sg-9ce844e7" --group-owner "259701781532"
echo "[INFO]  Created Group '${t_group_name}' with ID: ${t_group_id}"


##NLPKWB
#t_group_name="${deployment}-NLPKWB-App"
#t_elb_group=''
#t_group_id=$(${aws_group_create} --group-name "${t_group_name}" --description "Security Group for ${t_group_name} Instances")
#${aws_cli_base} ec2 create-tags --resource ${t_group_id} --tags Key=Name,Value="${t_group_name}" Key=Deployment,Value="${deployment}"
#${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 443 --source-group "${t_elb_group}"
#${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 22 --source-group "sg-9ce844e7" --group-owner "259701781532"
#echo "[INFO]  Created Group '${t_group_name}' with ID: ${t_group_id}"


##ELSearch
#t_group_name="${deployment}-ELSEARCH-LOG"
#t_elb_group=''
#t_group_id=$(${aws_group_create} --group-name "${t_group_name}" --description "Security Group for ${t_group_name} Instances")
#${aws_cli_base} ec2 create-tags --resource ${t_group_id} --tags Key=Name,Value="${t_group_name}" Key=Deployment,Value="${deployment}"
#${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 9200 --source-group "${t_elb_group}"
#${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 22 --source-group "sg-9ce844e7" --group-owner "259701781532"
#echo "[INFO]  Created Group '${t_group_name}' with ID: ${t_group_id}"
