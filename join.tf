#String Functions Join
#https://www.terraform.io/docs/language/functions/
terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
}
resource "docker_container" "nodered_container" {
  name  = "nodered"
  image = docker_image.nodered_image.latest
  ports {
    internal = 1880
    external = 1880
  }
}

output "IP-Address" {

  value       = join(":", [docker_container.nodered_container.ip_address,docker_container.nodered_container.ports[0].external])
  description = "IP:Port"
}

output "Container-Name" {

  value       = docker_image.nodered_image.name
  description = "Image Name"

}
