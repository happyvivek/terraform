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
special = false
upper = false

}

resource "random_string" "random1" {

length = 4
special = false
upper = false

}



resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
}
resource "docker_container" "nodered_container1" {
  name  = join("-",["nodered",random_string.random.result])
  image = docker_image.nodered_image.latest
  ports {
    internal = 1880
    #external = 1880
  }
}

resource "docker_container" "nodered_container2" {
  name  = join("-",["nodered",random_string.random1.result])
  image = docker_image.nodered_image.latest
  ports {
    internal = 1880
    #external = 1880
  }
}



output "IP-Address1" {

  value       = join(":", [docker_container.nodered_container1.ip_address,docker_container.nodered_container1.ports[0].external])
  description = "IP:Port"
}

output "IP-Address2" {

  value       = join(":", [docker_container.nodered_container2.ip_address,docker_container.nodered_container2.ports[0].external])
  description = "IP:Port"
}

output "Container-Image" {

  value       = docker_image.nodered_image.name
  description = "Image Name"

}
