variable "instance_name" {
        type = string
        description = "Name of the instance to be created"
        default = "var.name"
        }
variable "access_key" {
        type = string
        description = "Access key to AWS console"
}
variable "secret_key" {
        type = string
        description = "Secret key to AWS console"
}
variable "instance_type" {
        type = string
        default = "t2.micro"
}