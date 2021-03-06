variable "bookie_volume_size" {
  description = "Bookie storage volume size in MB"
  default = 100
}

variable "instance_counts" {
  description = "Number of instances"
  type = map(string)
  default = {
    "bookie" = 1
    "broker" = 1
    "client" = 1
    "proxy" = 1
    "zookeeper" = 1
  }
}

variable "instance_types" {
  description = "Number of instances"
  type = map(string)
  default = {
    "bookie" = "m1.small"
    "broker" = "m1.small"
    "client" = "m1.small"
    "proxy" = "m1.small"
    "zookeeper" = "m1.small"
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
