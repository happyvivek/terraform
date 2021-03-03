
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

output "ipAddress" {

  value       = docker_container.nodered_container.ip_address
  description = "IP Address of the container"
}

output "container-name" {

  value       = docker_image.nodered_image.name
  description = "Image Name"

}
