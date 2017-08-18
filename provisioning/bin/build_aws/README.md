# Build AWS Scripts

## Requirements
  - Installed AWS-CLI (https://aws.amazon.com/cli/)
  - Configured Profiles
    - DI
    - QA
    - CT
    - PR

## Getting Started

### Install AWS-CLI according to the documentation
(http://docs.aws.amazon.com/cli/latest/userguide/installing.html#install-bundle-other-os)

Install the aws-cli
```
curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
unzip awscli-bundle.zip
sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
```

Verify the install
```aws help```

### Configuring your profiles
(http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html#cli-config-files)

#### Get your Access and Secret Key
Follow the procesure to get your API access Setup

  * Login to the AWS Management Console
  * Click your account name in the upper left-hand corner -> **Security Credentials**
  * Click **Users** on the left-hand side
  * Find your User (Double-click)
  * Select **Security Credentials** tab
  * Select **Create Access Key**
  * Note the **Access** and **Secret Keys**

#### Create the credentials file
*Note:* Never _ever_ check-in your API Keys into a source-control repo!!

You should create a file `~/aws/credentials` with the following format
```
[di]
output = text
region = us-east-1
aws_access_key_id = {API Access Key}
aws_secret_access_key = {API Secret Key}

[qa]
output = text
region = us-east-1
aws_access_key_id = {API Access Key}
aws_secret_access_key = {API Secret Key}

[ct]
output = text
region = us-east-1
aws_access_key_id = {API Access Key}
aws_secret_access_key = {API Secret Key}

[pr]
output = text
region = us-east-1
aws_access_key_id = {API Access Key}
aws_secret_access_key = {API Secret Key}
```
Note: Your CT and PR Access and Secret Key's may be the same
since they are using the same Account

#### Test your credentials work
For each profile, run the following command to verify that
the profile you created works.  (You must have permission to
describe regions)

```aws --profile={profile} ec2 describe-regions```

### The Script
#### Folder layout
  * Base: Where the primary Scripts reside
    * _apps_: Where the app definitions are created. Contains
      additional variables and the initial boot script
    * _aws-params_: Where the AWS Environment variables are kept

#### Running

```
./build_app_aws.sh {number of nodes} {starting Serial} {environment} {app}
```

Parameters
  * _number of nodes_: How many nodes do you want to build
  * _starting serial_: What number to begin building at
  * _environment_: [di,qa,ct,pr] must match a valid  \*-app.conf in the
    **aws-params** dir.  Error Checked, will fail if no match.
  * _app_: Which app to deploy, must match a valid \*.app in the **apps** dir
    Error Checked, will fail if no match.
