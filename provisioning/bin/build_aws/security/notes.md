## Find all SecGroups with name '*Jenkins*' in prod account, execute add mcafee
```
aws --profile pr ec2 describe-security-groups --filters Name=tag:Name,Values=*Jenkins* --query 'SecurityGroups[*].{ID:GroupId}' | while read line; do ./allow_mcafee.sh pr $line ; done
```
