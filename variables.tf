# General Variables
variable "region" {
  type        = string
  description = "Qualifying AWS region (Example: us-east-2)"
  default     = "us-east-1"
}

variable "env" {
  type        = string
  description = "Environment of the Infrastructure"
  default     = "dev"
}

# DynamoDB Variables
variable "table_name" {
  type        = string
  description = "Name of the DynamoDB table"
}

variable "billing_mode" {
  type        = string
  description = "Billing mode of the table. Either PROVISIONED or PAY_PER_REQUEST"
  default     = "PROVISIONED"
}

variable "partition_key" {
  type        = string
  description = "Partition key (Hash key) of the table"
}

variable "sort_key" {
  type        = string
  description = "Sort key (Range key) of the table"
  default     = null
}

variable "attributes" {
  type = list(object({
    name = string
    type = string # Either S, N, or B
  }))
  description = "List of attributes to include in the table. Partition key is required. Sort key is required if specified."
}

variable "ttl_attribute" {
  type        = string
  description = "The name of the attribute to treat as the time to live key"
  default     = null
}

variable "read_capacity" {
  type        = number
  description = "Number of read units. Only needed when billing_mode is PROVISIONED"
  default     = 10
}

variable "write_capacity" {
  type        = number
  description = "Number of write units. Only needed when billing_mode is PROVISIONED"
  default     = 10
}

variable "replicas" {
  type        = list(string)
  description = "List of qualifying AWS regions"
  default     = []
}
