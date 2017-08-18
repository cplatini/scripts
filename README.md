# CHO Internal Scripts

-------

## Installing the python NOVA client

### Fedora, CentOS, and RHEL

#### `REQUIREMENT`: python-setuptools

The setuptools python package is required to run the installer for the nova client. If you're running Mac OS X the setuptools package should already be installed.

Depending on your Linux distribution you can install setuptools through your package manager.

```
sudo yum install gcc python-setuptools python-devel python-tools
```

#### `REQUIREMENT`: pip

Now that setuptools is installed we can use one of its programs to install the python package manager "pip".

```
sudo easy_install pip
```

#### `REQUIREMENT`: python-devel
```
sudo yum install python-devel
```

#### Python novaclient shuffle
```
sudo pip install python-novaclient==2.23.2
```

then revert back to:

```
sudo pip install python-novaclient==2.20.0
```

```
sudo pip install python-novaclient==2.18.1
```

-------

## AWS API: using the aws cli

#### `REQUIRMENT`: awscli

```
# { YUM }
sudo dnf install awscli-1.10.6-2.fc23.noarch 
```

### HTTP Docs
[installing](http://docs.aws.amazon.com/cli/latest/userguide/installing.html)  
[cli-multiple-profiles](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html#cli-multiple-profiles)  


### HELP: http://docs.aws.amazon.com/cli/latest/userguide/cli-using-param.html
```
aws ec2 describe-instances help
```

### Profile:
```
aws configure --profile user2
```

### API:
```
aws ec2 describe-instances --output table --region us-east-1
```

```
aws --profile user2 ec2 describe-instances --filters "Name=tag:Name,Values=yum*"
```