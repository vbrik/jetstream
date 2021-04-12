variable "num_instances" {
  description = "Number of instances"
  type = number
  default = 2
}

variable "cidr" {
  description = "CIDR of the internal subnet"
  default = "10.0.0.0/24"
}

variable "public_network_id" {
  description = "OpenStack ID of the public network. The default is Jetstream's network 'public'"
  default = "865ff018-8894-40c2-99b7-d9f8701ddb0b"
}
