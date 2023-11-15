# Specify the AWS provider and the region where the DynamoDB table will be created
provider "aws" {
  region = "us-east-1"
}

# Define the AWS DynamoDB table resource
resource "aws_dynamodb_table" "basic-dynamodb-table" {
  # Name of the DynamoDB table
  name           = "chatbot"
  
  # Billing mode for the table (PROVISIONED or PAY_PER_REQUEST)
  billing_mode   = "PROVISIONED"
  
  # Provisioned read and write capacity units
  read_capacity  = 20
  write_capacity = 20
  
  # Primary key definition
  hash_key       = "user_input"


  # Define attributes for the primary key
  attribute {
    name = "user_input"
    type = "S"  # String type
  }

  attribute {
    name = "assistant_reply"
    type = "S"  # String type
  }

  # Time to Live (TTL) settings (optional)
  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }

  # Define a global secondary index 
  global_secondary_index {
    name               = "UserTitleIndex"
    hash_key           = "user_input"
    range_key          = "assistant_reply"
    write_capacity     = 10
    read_capacity      = 10
    projection_type    = "ALL"  # Use KEYS_ONLY to exclude attribute values
    #non_key_attributes = ["user_input"]

  }

  # Tags for the DynamoDB table (optional but recommended for resource management)
  tags = {
    Name        = "dynamodb-table"
    Environment = "Training"
  }
}