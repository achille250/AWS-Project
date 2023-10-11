variable "region" {
    default = "us-east-1"
    type= string
}

variable "bucket_name" {
    default="ebuy-s3"
    description = "bucket name"
    type= string
}
variable "acl" {
    default="public-read"
    type= string
}

variable "versioning" {
    description = " A state of versioning."
    default     = true
     type        = bool
}

#Route 53 variables
variable "domain_name"{
    default="https://e-buy250.000webhostapp.com"
    description = "Domain name"
    type=string
}

variable "record_name"{
    default="www"
    description = "subdomain"
    type=string
}



