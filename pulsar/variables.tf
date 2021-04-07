variable "instance_counts" {
  description = "Number of instances"
  type = map(string)
  default = {
    "zookeeper" = 1
    "bookie" = 1
    "broker" = 1
    "proxy" = 1
    "client" = 1
  }
}

variable "instance_types" {
  description = "Number of instances"
  type = map(string)
  default = {
    "zookeeper" = "m1.tiny"
    "bookie" = "m1.tiny"
    "broker" = "m1.tiny"
    "proxy" = "m1.tiny"
    "client" = "m1.tiny"
  }
}

variable "internal_cidr" {
  description = "CIDR of the internal subnet"
  default = "10.0.0.0/24"
}

variable "public_network_id" {
  description = "OpenStack ID of the public network. The default is Jetstream's network 'public'"
  default = "865ff018-8894-40c2-99b7-d9f8701ddb0b"
}
