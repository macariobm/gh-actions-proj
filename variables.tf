variable "instance_name" {
  description = "nametag for the instances"
  default     = ["1", "2"]
  type        = list(any)
}

variable "aws_region" {
  description = "AWS region"
  default     = "sa-east-1"
}

variable "aws_profile" {
  description = "aws profile name"
  type        = string
}

variable "instance_num" {
  description = "number os ECs per subnet"
  type        = number
}
