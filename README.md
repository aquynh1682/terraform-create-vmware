# Using terraform create vm on vsphere

<br/>

This provider gives Terraform the ability to work with VMware vSphere, notably vCenter Server and ESXi. This provider can be used to manage many aspects of a vSphere environment, including virtual machines, standard and distributed switches, datastores, content libraries, and more. And this docs of the ([terraform vmware vsphere](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs)).

<br/>

## Setup Terraform and proceed with the execution.

<br/>

### Step 1: Install Terraform.
Install Terraform according to ([document of hashicorp](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)).

<br/>

### Step 2: Update info for terraform.
After finishing the Terraform download, please pull the source code to your machine, and make some edits afterward.

<br/>

- If you want to install a Linux OS, you should uncomment the Linux section and comment out the windows section in file `main.tf`. Additionally, you should update the json file name in the `locals` block in the `variables.tf` file.
- Next, you need insert the information variable in the `variables.tf` file.
- Finally, if you want install more OS on vmware. You can add information about the OS to the json file.

<br/>

### Step 3: Run Terraform.
The first thing you need to do is run the command `terraform init`. This command initializes a working directory containing Terraform configuration files. After that, you can run the command `terraform plan` to review information about of the OS. Finally, you can run command `terraform apply` and enter `yes` to complete the OS setup. Below are the images after installing the OS with terraform.

<br/>

<img src="https://github.com/aquynh1682/terraform-create-vmware/blob/main/terraform-running.png">

<br/>

<img src="https://github.com/aquynh1682/terraform-create-vmware/blob/main/terraform-complete.png">
