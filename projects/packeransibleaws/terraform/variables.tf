variable "tags" {
        type = map(string)
        default = {
         "Name" = "terraform-elb-tomcat-app"
         
}
}
variable "region" {
        default = "us-east-1"
}