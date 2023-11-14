##### Terraform create vmware with vcenter #####
# create by: QuynhNM
# Latest update: 11:33AM 10/30/2023

provider "vsphere" {
	user                 = var.vsphere_user
	password             = var.vsphere_password
	vsphere_server       = var.vsphere_server
	allow_unverified_ssl = true
}

data "vsphere_datacenter" "dataCenter" {
	name = var.vsphere_dataCenter
}

data "vsphere_datastore" "dataStore" {
	name = var.vsphere_dataStore
	datacenter_id = data.vsphere_datacenter.dataCenter.id
}

data "vsphere_host" "host" {
	name = var.esxi_host
	datacenter_id = data.vsphere_datacenter.dataCenter.id
}

data "vsphere_network" "network" {
	name = var.vsphere_network
	datacenter_id = data.vsphere_datacenter.dataCenter.id
}

data "vsphere_virtual_machine" "template" {
	name = var.vsphere_template
	datacenter_id = data.vsphere_datacenter.dataCenter.id
}

#############################################################################
# 				$$\       $$\                               				#
# 				$$ |      \__|                              				#
# 				$$ |      $$\ $$$$$$$\  $$\   $$\ $$\   $$\ 				#
# 				$$ |      $$ |$$  __$$\ $$ |  $$ |\$$\ $$  |				#
# 				$$ |      $$ |$$ |  $$ |$$ |  $$ | \$$$$  / 				#
# 				$$ |      $$ |$$ |  $$ |$$ |  $$ | $$  $$<  				#
# 				$$$$$$$$\ $$ |$$ |  $$ |\$$$$$$  |$$  /\$$\ 				#
# 				\________|\__|\__|  \__| \______/ \__/  \__|				#
#############################################################################

# resource "vsphere_virtual_machine" "vm" { # create vm with template
# 	count = length(local.vm_configs)
# 	name = local.vm_configs[count.index].name_vm
# 	resource_pool_id = data.vsphere_host.host.resource_pool_id
# 	datastore_id = data.vsphere_datastore.dataStore.id
# 	firmware = data.vsphere_virtual_machine.template.firmware
# 	efi_secure_boot_enabled = data.vsphere_virtual_machine.template.efi_secure_boot_enabled
# 	num_cpus = local.vm_configs[count.index].cpu
# 	memory = local.vm_configs[count.index].memory
# 	guest_id = data.vsphere_virtual_machine.template.guest_id
# 	network_interface {
# 		network_id = data.vsphere_network.network.id
# 	}
# 	disk {
# 		label = "${local.vm_configs[count.index].name_vm}-disk"
# 		size = data.vsphere_virtual_machine.template.disks[0].size
# 		thin_provisioned = data.vsphere_virtual_machine.template.disks[0].thin_provisioned
# 	}
# 	clone {
# 		template_uuid = data.vsphere_virtual_machine.template.id
# 		customize {
# 			linux_options {
# 				host_name = local.vm_configs[count.index].host_name
# 				domain = local.vm_configs[count.index].domain
# 			}
# 			network_interface {
# 				ipv4_address = local.vm_configs[count.index].ip_address
# 				ipv4_netmask = local.vm_configs[count.index].subnet
# 			}
#			dns_server_list = [local.vm_configs[count.index].dns]
# 			ipv4_gateway = local.vm_configs[count.index].gateway
# 		}
# 	}
# }

#############################################################################
# 	$$\      $$\ $$\                 $$\                                    #
# 	$$ | $\  $$ |\__|                $$ |                                   #
# 	$$ |$$$\ $$ |$$\ $$$$$$$\   $$$$$$$ | $$$$$$\  $$\  $$\  $$\  $$$$$$$\  #
# 	$$ $$ $$\$$ |$$ |$$  __$$\ $$  __$$ |$$  __$$\ $$ | $$ | $$ |$$  _____| #
# 	$$$$  _$$$$ |$$ |$$ |  $$ |$$ /  $$ |$$ /  $$ |$$ | $$ | $$ |\$$$$$$\   # 
# 	$$$  / \$$$ |$$ |$$ |  $$ |$$ |  $$ |$$ |  $$ |$$ | $$ | $$ | \____$$\  #
# 	$$  /   \$$ |$$ |$$ |  $$ |\$$$$$$$ |\$$$$$$  |\$$$$$\$$$$  |$$$$$$$  | #
# 	\__/     \__|\__|\__|  \__| \_______| \______/  \_____\____/ \_______/  #
#############################################################################
resource "vsphere_virtual_machine" "vm" { # create vm with template
	count = length(local.vm_configs)
	name = local.vm_configs[count.index].name_vm
	resource_pool_id = data.vsphere_host.host.resource_pool_id
	datastore_id = data.vsphere_datastore.dataStore.id
	firmware = data.vsphere_virtual_machine.template.firmware
	efi_secure_boot_enabled = data.vsphere_virtual_machine.template.efi_secure_boot_enabled
	num_cpus = local.vm_configs[count.index].cpu
	memory = local.vm_configs[count.index].memory
	guest_id = data.vsphere_virtual_machine.template.guest_id
	scsi_type = data.vsphere_virtual_machine.template.scsi_type
	wait_for_guest_net_timeout = -1
	network_interface {
		network_id = data.vsphere_network.network.id
		adapter_type = "vmxnet3"
	}
	disk {
		label = "${local.vm_configs[count.index].name_vm}-disk"
		size = data.vsphere_virtual_machine.template.disks[0].size
		thin_provisioned = data.vsphere_virtual_machine.template.disks[0].thin_provisioned
	}
	clone {
		template_uuid = data.vsphere_virtual_machine.template.id
		customize {
			windows_options {
				computer_name = local.vm_configs[count.index].host_name
				admin_password = local.vm_configs[count.index].admin_pass
				organization_name = "Managed by VDI"
				time_zone = 205
			}
			network_interface {
				ipv4_address = local.vm_configs[count.index].ip_address
				ipv4_netmask = local.vm_configs[count.index].subnet
				dns_server_list = [local.vm_configs[count.index].dns1, local.vm_configs[count.index].dns2]
			}
			ipv4_gateway = local.vm_configs[count.index].gateway
			timeout = 30
		}
	}
}
