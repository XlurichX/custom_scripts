variable "ami_id" {
    default = "ami-064519b8c76274859" # debian12
}
variable "instance_type" {
    default = "t2.micro"
}
variable "server_http_port" {
    type = number
    default = 80
}
variable "server_https_port" {
    type = number
    default = 443
}
variable "server_ssh_port" {
    type = number
    default = 22
}
variable "out_port" {
    type = number
    default = 0
}
