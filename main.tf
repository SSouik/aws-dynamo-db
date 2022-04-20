locals {
  module_version = jsondecode(file("${path.module}/version.json")).version
  isProvisioned  = var.billing_mode == "PROVISIONED"
}

resource "aws_dynamodb_table" "db" {
  name         = "${var.env}.${var.table_name}"
  billing_mode = var.billing_mode
  hash_key     = var.partition_key
  range_key    = var.sort_key

  read_capacity  = local.isProvisioned ? var.read_capacity : null
  write_capacity = local.isProvisioned ? var.write_capacity : null

  dynamic "attribute" {
    for_each = var.attributes
    iterator = attribute

    content {
      name = attribute.value["name"]
      type = attribute.value["type"]
    }
  }

  dynamic "ttl" {
    for_each = var.ttl_attribute != null ? [1] : []

    content {
      attribute_name = var.ttl_attribute
      enabled        = true
    }
  }

  dynamic "replica" {
    for_each = var.replicas
    iterator = region

    content {
      region_name = region.value
    }
  }

  tags = {
    Name          = var.table_name
    Environment   = var.env
    ManagedBy     = "Terraform"
    Created       = timestamp()
    CreatedBy     = data.aws_caller_identity.current.arn
    Module        = "aws-dynamo-db"
    ModuleVersion = local.module_version
  }

  lifecycle {
    ignore_changes = [
      tags["Created"]
    ]
  }
}
