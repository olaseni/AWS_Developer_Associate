variable "instance_ami" {
  type        = string
  description = "AMI ID for the EC2 instance"
  default     = "ami-0e8d228ad90af673b"

  validation {
    condition     = length(var.instance_ami) > 4 && substr(var.instance_ami, 0, 4) == "ami-"
    error_message = "Please provide a valid value for variable INSTANCE_AMI."
  }
}

variable "instance_type" {
  type        = string
  description = "Instance type for the EC2 instance"
  default     = "t2.micro"
  sensitive   = true

  validation {
    condition     = var.instance_type == "t2.micro"
    error_message = "Please provide a valid value for variable INSTANCE_TYPE."
  }
}

variable "instance_region" {
  type        = string
  description = "EC2 instance region"
  default     = "eu-west-2"

    validation {
    condition     = var.instance_region == "eu-west-2"
    error_message = "Please provide a valid value for variable INSTANCE_REGION."
  }
}
