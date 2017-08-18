#!/bin/bash
# vm-drainwater bin/make_default.sh 
###########################################
# BOOT the VM
###########################################
# nova boot [UUID]
read -r -d '' boot_instance <<__MARK__
+-------------------------------------+--------------------------------------------------------------------+
| Property                            | Value                                                              |
+-------------------------------------+--------------------------------------------------------------------+
| status                              | ACTIVE                                                             |
| updated                             | 2014-10-25T22:25:32Z                                               |
| OS-EXT-STS:task_state               | None                                                               |
| OS-EXT-SRV-ATTR:host                | 532371-R4-compute33                                                |
| key_name                            | ProvisionSSH                                                       |
| image                               | CentOS-6.5_x86_64.lvm.v1.00 (84af9909-60f9-49eb-882c-b13df4ad602c) |
| hostId                              | 8cf29723f1de5eef1bf8253006cac62f214b91b7105c707f7df6ef27           |
| R4-APPTEST network                  | 10.211.0.181                                                       |
| OS-EXT-STS:vm_state                 | active                                                             |
| OS-EXT-SRV-ATTR:instance_name       | instance-00001a90                                                  |
| OS-EXT-SRV-ATTR:hypervisor_hostname | 532371-R4-compute33                                                |
| flavor                              | nlp_standard (659ebf59-456c-48d0-9eb8-bab9f5ef9583)                |
| id                                  | 46623a9e-f6fe-4787-886e-38a3e50245a5                               |
| security_groups                     | [{u'name': u'default'}]                                            |
| user_id                             | 1dd8f2d77e0044289ccef45677fece17                                   |
| name                                | DFW-CT-NLP-31                                                      |
| created                             | 2014-10-25T22:23:36Z                                               |
| tenant_id                           | e5967d9ccb0b45289cd86295374ff8cf                                   |
| OS-DCF:diskConfig                   | MANUAL                                                             |
| metadata                            | {}                                                                 |
| accessIPv4                          |                                                                    |
| accessIPv6                          |                                                                    |
| progress                            | 0                                                                  |
| OS-EXT-STS:power_state              | 1                                                                  |
| OS-EXT-AZ:availability_zone         | AZ-NP-STANDARD-1                                                   |
| config_drive                        |                                                                    |
+-------------------------------------+--------------------------------------------------------------------+
__MARK__
###########################################
# Get/Store OS_UUID and BOOT the VM
###########################################
# OS_UUID=$(echo "${boot_instance}" | egrep -i "[[:space:]]id[[:space:]]" | awk -F'|' '{print $3}' | xargs echo -n)
# echo "${boot_instance}"
# echo "[INFO]: Booting Instance: Sleep 1 minute..."
echo -e "BOOT:\n${boot_instance}"
# This is how we get the UUID from the host by grepping for id
OS_UUID=$(echo "${boot_instance}" | egrep -i "[[:space:]]id[[:space:]]" | awk -F'|' '{print $3}' | xargs echo -n)
echo -e "OS_UUID (Should have ID value):${OS_UUID}"
###########################################
# CHECK INSTANCE IP ADDRESS
# Check for proper IP address (May still be building)
# Attempt to find the IP address 3 times before failing
###########################################
# Get the instance's IP by OS_UUID and store it
instance_ipaddr=$(echo "${boot_instance}" | grep -i "network" | awk -F'|' '{print $3}' | xargs echo -n)
echo -e "IPv4 (Should have IP value):${instance_ipaddr}"
