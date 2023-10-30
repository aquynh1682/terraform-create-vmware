locals {
    ########    for create linux    ####################
    # vm_configs = jsondecode(file("./host_linux.json"))

    ########    for create windows  ####################
    vm_configs = jsondecode(file("./host_windows.json"))
}

variable "vsphere_server" { # host/domain of vmware vsphere client
    type = string
    default = ""
}

variable "esxi_host" { # vmware esxi name
    type = string
    default = ""
}

variable "vsphere_dataCenter" { # name datacenter in vsphere
    type = string
    default = ""
}

variable "vsphere_dataStore" { # name datastore in vsphere
    type = string
    default = ""
}

variable "vsphere_network" { # name network in vsphere
    type = string
    default = ""
}

variable "vsphere_template" { # name template in vsphere
    type = string
    # default = "template-centos-terraform"
    default = ""
}

variable "vsphere_user" { # user login vmware vsphere client
    type = string
    default = ""
}

variable "vsphere_password" { # password login vmware vsphere client
    type = string
    default = ""
}
