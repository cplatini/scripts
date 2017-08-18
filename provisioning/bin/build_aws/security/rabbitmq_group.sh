#!/bin/bash

AWS_CONFIG_FILE=$HOME/.aws/credentials

## DI
aws_vpc="vpc-5e4ba939"
aws_cli_base="aws --profile di --output text"
aws_elb_group="${aws_cli_base} ec2 describe-security-groups --query "SecurityGroups[*].GroupId""
aws_group_create="${aws_cli_base} ec2 create-security-group --vpc-id "${aws_vpc}""
aws_group_allow="${aws_cli_base} ec2 authorize-security-group-ingress"
SDLC="DI-INT"
t_group_name="${SDLC}-HSARABBITMQ-App"
t_elb_group=$(${aws_elb_group} --filter Name=group-name,Values="ELB-di-HSARABBITMQ*")
t_group_id=$(${aws_group_create} --group-name "${t_group_name}" --description "Security Group for ${t_group_name} Instances")
${aws_cli_base} ec2 create-tags --resource ${t_group_id} --tags Key=Name,Value="${t_group_name}"
${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 5671 --source-group "${t_elb_group}"
${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 5671 --source-group "${t_group_id}"
${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 4369 --source-group "${t_group_id}"
${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 25672 --source-group "${t_group_id}"
${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 22 --source-group "sg-866c74fe"
echo "[INFO]  Created Group '${t_group_name}' with ID: ${t_group_id}"


### QA
#aws_vpc="vpc-724dbf15"
#aws_cli_base="aws --profile qa --output text"
#aws_elb_group="${aws_cli_base} ec2 describe-security-groups --query "SecurityGroups[*].GroupId""
#aws_group_create="${aws_cli_base} ec2 create-security-group --vpc-id "${aws_vpc}""
#aws_group_allow="${aws_cli_base} ec2 authorize-security-group-ingress"
#SDLC="QA"
#t_group_name="${SDLC}-HSARABBITMQ-App"
#t_elb_group=$(${aws_elb_group} --filter Name=group-name,Values="ELB-qa-HSARABBITMQ*")
#t_group_id=$(${aws_group_create} --group-name "${t_group_name}" --description "Security Group for ${t_group_name} Instances")
#${aws_cli_base} ec2 create-tags --resource ${t_group_id} --tags Key=Name,Value="${t_group_name}"
#${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 5671 --source-group "${t_elb_group}"
#${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 5671 --source-group "${t_group_id}"
#${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 4369 --source-group "${t_group_id}"
#${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 25672 --source-group "${t_group_id}"
#${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 22 --source-group "sg-9ce844e7"
#echo "[INFO]  Created Group '${t_group_name}' with ID: ${t_group_id}"

### VO
#aws_vpc="vpc-724dbf15"
#aws_cli_base="aws --profile qa --output text"
#aws_elb_group="${aws_cli_base} ec2 describe-security-groups --query "SecurityGroups[*].GroupId""
#aws_group_create="${aws_cli_base} ec2 create-security-group --vpc-id "${aws_vpc}""
#aws_group_allow="${aws_cli_base} ec2 authorize-security-group-ingress"
#SDLC="VO"
#t_group_name="${SDLC}-HSARABBITMQ-App"
#t_elb_group=$(${aws_elb_group} --filter Name=group-name,Values="ELB-vo-HSARABBITMQ*")
#t_group_id=$(${aws_group_create} --group-name "${t_group_name}" --description "Security Group for ${t_group_name} Instances")
#${aws_cli_base} ec2 create-tags --resource ${t_group_id} --tags Key=Name,Value="${t_group_name}"
#${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 5671 --source-group "${t_elb_group}"
#${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 5671 --source-group "${t_group_id}"
#${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 4369 --source-group "${t_group_id}"
#${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 25672 --source-group "${t_group_id}"
#${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 22 --source-group "sg-9ce844e7"
#echo "[INFO]  Created Group '${t_group_name}' with ID: ${t_group_id}"

### CT
#aws_vpc="vpc-af6c9cc8"
#aws_cli_base="aws --profile pr --output text"
#aws_elb_group="${aws_cli_base} ec2 describe-security-groups --query "SecurityGroups[*].GroupId""
#aws_group_create="${aws_cli_base} ec2 create-security-group --vpc-id "${aws_vpc}""
#aws_group_allow="${aws_cli_base} ec2 authorize-security-group-ingress"
#SDLC="CT"
#t_group_name="${SDLC}-HSARABBITMQ-App"
#t_elb_group=$(${aws_elb_group} --filter Name=group-name,Values="ELB-ct-HSARABBITMQ*")
#t_group_id=$(${aws_group_create} --group-name "${t_group_name}" --description "Security Group for ${t_group_name} Instances")
#${aws_cli_base} ec2 create-tags --resource ${t_group_id} --tags Key=Name,Value="${t_group_name}"
#${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 5671 --source-group "${t_elb_group}"
#${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 5671 --source-group "${t_group_id}"
#${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 4369 --source-group "${t_group_id}"
#${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 25672 --source-group "${t_group_id}"
#${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 22 --source-group "sg-9ce844e7"
#echo "[INFO]  Created Group '${t_group_name}' with ID: ${t_group_id}"

### PR
#aws_vpc="vpc-706e9e17"
#aws_cli_base="aws --profile pr --output text"
#aws_elb_group="${aws_cli_base} ec2 describe-security-groups --query "SecurityGroups[*].GroupId""
#aws_group_create="${aws_cli_base} ec2 create-security-group --vpc-id "${aws_vpc}""
#aws_group_allow="${aws_cli_base} ec2 authorize-security-group-ingress"
#SDLC="PR"
#t_group_name="${SDLC}-HSARABBITMQ-App"
#t_elb_group=$(${aws_elb_group} --filter Name=group-name,Values="ELB-pr-HSARABBITMQ*")
#t_group_id=$(${aws_group_create} --group-name "${t_group_name}" --description "Security Group for ${t_group_name} Instances")
#${aws_cli_base} ec2 create-tags --resource ${t_group_id} --tags Key=Name,Value="${t_group_name}"
#${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 5671 --source-group "${t_elb_group}"
#${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 5671 --source-group "${t_group_id}"
#${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 4369 --source-group "${t_group_id}"
#${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 25672 --source-group "${t_group_id}"
#${aws_group_allow} --group-id "${t_group_id}" --protocol tcp --port 22 --source-group "sg-9ce844e7"
#echo "[INFO]  Created Group '${t_group_name}' with ID: ${t_group_id}"
