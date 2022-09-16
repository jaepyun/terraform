variable "region" {
  default = "us-east-1"
}

variable "terminate_volume" {
  default = "true"
  #If you would like to keep your server on termination, set to false
}

variable "mojang_server" {
  default = "https://piston-data.mojang.com/v1/objects/f69c284232d7c7580bd89a5a4931c3581eae1378/server.jar"
  #Put server download file here if you would like to run a different version
}

variable "instance_type" {
  default = "t2.micro"
}

variable "my_ip" {
  type = string
  default = "98.212.214.0"
}