variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "vpc_id" {
  description = "VPC to deploy into"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets for the ALB and fleet (min 2, across AZs)"
  type        = list(string)
}

variable "instance_type" {
  description = "EC2 instance type for fleet nodes"
  type        = string
  default     = "t3.micro"
}

variable "min_size" {
  description = "Minimum fleet size"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum fleet size"
  type        = number
  default     = 4
}
