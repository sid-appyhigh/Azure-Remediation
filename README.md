# Azure-Remediation

## Remediation use case problem statement
Ensure that no network security groups allow unrestricted inbound access on TCP port 3389 (Remote Desktop Protocol – RDP).

 1. Remediation resource: Network Security Group.
 2. Resource parameter: Unsecure port open.

## Why remediation?
RDP port 3389 is exposed to the Internet. Therefore, we recommend that you use this port only for recommended for testing. For production environments, we recommend that you use a VPN or private connection.
<a href="https://docs.microsoft.com/en-us/troubleshoot/azure/virtual-machines/troubleshoot-rdp-nsg-problem">Reference</a>

## Remediation or solution steps

 1. <a href="https://docs.microsoft.com/en-us/azure/developer/ansible/create-ansible-service-principal?tabs=azure-cli">Create an Azure service principal for Ansible</a>
 2. <a href="https://docs.microsoft.com/en-us/azure/developer/ansible/install-on-linux-vm?tabs=azure-cli">Configure Ansible on an Azure VM</a>


## Reference to the backlog / use-case id in spreadsheet
Remediation use cases - Microsoft Azure - #2

## How to setup the infrastructure for testing?

 1. An Azure subscription.
 2. Terraform 0.14.9 or later
 3. The Azure CLI Tool installed
 4. In your terminal, use the Azure CLI tool to setup your account permissions locally. ``` az login ```.
 5. In the ```Infra``` folder, run the following commands:
        ```
            terraform init
            terraform plan
            terraform apply
        ```

## How to run the script? or How to execute the command?

 1. In the ``` Remediation``` folder, edit the variables.yml add the name of the resource group to check for NSG.
 2. Run the Identify-nsg.yml to find the NSGs with the port 3389 open.
   ``` ansible-playbook Identify-nsg.yml ```
 3. Once the NSGs with 3389 port open are identified it will create a file named ```nsg``` with the name of the NSGs and the name of the rule which has the port 3389 open.
 4. Now, run the remediate-nsg.yml to Deny the rules which has the 3389 port.
   ```ansible-playbook  remediate-nsg.yml -i nsg```
 5. [Optional] Can run the Identify-nsg.yml script again to check if any NSGs are remaining with the port 3389 open.
   
## Details about the variables/parameters used

 1. Variables used in the Infra terraform code.
   * nsg_names - a list of the names of the NSGs to be created.

 2. Variables used in Remediate Ansible script.
   * resourceGroup - name of the resource in which to check for NSGs with port 3389.
  
## Add file/folder details - names and purpose.

1. Infra:
   1.  locals.tf : Consists the set of rules to be applied to the NSGs.
   2.  main.tf : Main terraform code which creates the NSGs.
   3.  terraform.tfvars: Used to assign values to the variable.
   4.  variables.tf : Used to define the variable used in the code.
2. Remediation:
   1. find_nsg.py: a python script created to handle the logic of finding the NSGs with a perticular open port.
   2. Identify-nsg.yaml: playbook to identify the NSGs in a Resource Group with a perticular open port.
   3. remediate-nsg.yml: playbook to remediate the NSGs and Deny a perticular open port.
   4.  variables.yml: YAML file for define and assigning the variables used in the playbooks.
   
