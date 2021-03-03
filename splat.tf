#splat expression works as for loop
#Allows u to reference all resource by count
#Dont use it or avoid it

#Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

#Outputs:

#Container-Image = "nodered/node-red:latest"
#Container-Name = [
#  "nodered-45kt",
#  "nodered-bvft",
#]
#IP-Address1 = "172.17.0.2:32770"
#IP-Address2 = "172.17.0.3:32771"
#Terraform

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




output "IP-Address1" {

  value       = join(":", [docker_container.nodered_container[0].ip_address,docker_container.nodered_container[0].ports[0].external])
  description = "IP:Port"
}

output "IP-Address2" {

  value       = join(":", [docker_container.nodered_container[1].ip_address,docker_container.nodered_container[1].ports[0].external])
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
