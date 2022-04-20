output "arn" {
  value       = aws_dynamodb_table.db.arn
  description = "The ARN of the table"
}
