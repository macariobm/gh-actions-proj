variable "instance_name" {
  description = "nametag for the instances"
  default     = ["1", "2", "3"]
  type        = list(any)
}

variable "aws_region" {
  description = "AWS region"
  default     = "sa-east-1"
}

variable "instance_num" {
  description = "number os ECs per subnet"
  type        = number
  default     = 3
}
