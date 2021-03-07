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


output "IP-Address" {

  value = [for i in docker_container.nodered_container[*]:join(":",[i.ip_address,i.ports[0].internal])]
  description = "IP:Port"
}


output "Container-Image" {

  value       = docker_image.nodered_image.name
  description = "Image Name"

}
