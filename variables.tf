variable "asg_size_max" {
  type        = string
  default     = "3"
  description = "The maximum size of the autoscaling group"
}

variable "asg_size_min" {
  type        = string
  default     = "0"
  description = "The minimum size of the autoscaling group"
}
