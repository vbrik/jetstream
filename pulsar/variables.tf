variable "zookeeper_count" {
  description = "Number of zookeeper instances"
  default = 1
}

variable "bookie_count" {
  description = "Number of bookie instances"
  default = 1
}

variable "broker_count" {
  description = "Number of broker instances"
  default = 1
}

variable "proxy_count" {
  description = "Number of proxy instances"
  default = 1
}

variable "instance_types" {
  type = map(string)
  default = {
    "zookeeper" = "m1.tiny"
    "bookie"    = "m1.tiny"
    "broker"    = "m1.tiny"
    "proxy"     = "m1.tiny"
  }
}

variable "cidr" {
  description = "CIDR of the internal subnet"
  default = "10.0.0.0/24"
}

variable "public_network_id" {
  description = "OpenStack ID of the public network. The default is Jetstream's network 'public'"
  default = "865ff018-8894-40c2-99b7-d9f8701ddb0b"
}
