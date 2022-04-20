# aws-dynamo-db
Terraform module for creating a DynamoDB resource.

<br/>

## Table of Contents
* [How to Use](#how-to-use)
* [Module Inputs](#module-inputs)
* [Module Outputs](#module-outputs)

<br/>

### How to Use
Module `source`
```
git::https://github.com/SSouik/aws-dynamo-db.git?ref=v1.0.0
```

Setup and configuration sample
```
# main.tf
module "dynamo_db" {
    source        = "git::https://github.com/SSouik/aws-dynamo-db.git?ref=v1.0.0"
    region        = "us-east-2"
    env           = "test"
    table_name    = "my-table"
    billing_mode  = "PAY_PER_REQUEST"
    partition_key = "SOME_KEY"
    attributes    = [
        {
            name = "SOME_KEY"
            type = "S"
        }
    ]
}
```
</br>

### Module Inputs
|Name|Required|Type|Default|Description|
:--|:--:|:--:|:--:|:--|
|`region`|No|string|`us-east-1`|Qualifying AWS region (Example: us-east-2)|
|`env`|No|string|`dev`|Environment of the Infrastructure|
|`table_name`|Yes|string||Name of the DynamoDB table|
|`billing_mode`|No|string|`PROVISIONED`|Billing mode of the table. Either PROVISIONED or PAY_PER_REQUEST|
|`partition_key`|Yes|string||Partition key (Hash key) of the table|
|`sort_key`|No|string|`null`|Sort key (Range key) of the table|
|`attributes`|Yes|list(object([attribute](#attribute)))||List of attributes to include in the table. Partition key is required. Sort key is required if specified.|
|`ttl_attribute`|No|string|`null`|The name of the attribute to treat as the time to live key|
|`read_capacity`|No|number|`10`|Number of read units. Only needed when billing_mode is PROVISIONED|
|`write_capacity`|No|number|`10`|Number of write units. Only needed when billing_mode is PROVISIONED|
|`replicas`|No|list(string)|`[]`|List of qualifying AWS regions|

#### attribute
```
{
    name = string
    type = string # Either S, N, or B
}
```

</br>

### Module Outputs
|Name|Description|
|:--|:--|
|`arn`|The ARN of the table|
