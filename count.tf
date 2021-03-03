#Terraform
#count object i.e count.index is only used in resource,module and data blocks
#cannot be used in output,so 1 way is to check terrafor state list(not a good way)
terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

resource "random_string" "random" {

length = 4
count = 2
special = false
upper = false

}



resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
}
resource "docker_container" "nodered_container" {
  count = 2  
  name  = join("-",["nodered",random_string.random[count.index].result])
  image = docker_image.nodered_image.latest
  ports {
    internal = 1880
    #external = 1880
  }
}

/*
#Get state list to check the indexes,but this is not a good way.
#[root@localhost terraform-docker]# terraform state list
#docker_container.nodered_container[0]
#docker_container.nodered_container[1]
#docker_image.nodered_image
#random_string.random[0]
#random_string.random[1]


*/

output "IP-Address1" {

  value       = join(":", [docker_container.nodered_container[0].ip_address,docker_container.nodered_container[0].ports[0].external])
  description = "IP:Port"
}

output "IP-Address2" {

  value       = join(":", [docker_container.nodered_container[1].ip_address,docker_container.nodered_container[1].ports[0].external])
  description = "IP:Port"
}

output "Container-Image" {

  value       = docker_image.nodered_image.name
  description = "Image Name"

}
