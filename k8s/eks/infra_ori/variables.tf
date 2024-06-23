variable "region" { }
variable "profile" { }
variable "vpcid" { }
variable "all_subnet_ids" { 
    type    = list(string)
    default = [ "value" ]
}
variable "iamuser" { }
variable "iamuseradmin" { }
variable "accountid" { }