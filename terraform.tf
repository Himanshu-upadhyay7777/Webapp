terraform { 
  backend "s3" { 
    encrypt        = true 
    bucket         = "jously-aws-terraform-remote-state-centralized" 
    dynamodb_table = "jously-aws-terraform-locks-centralized" 
    region         = "us-east-1" 
    key            = "jously-app-infra/{{ENV}}/terraform.tfstate" 
    kms_key_id     = "arn:aws:kms:us-east-1:332082860531:key/eb0aee17-c313-4a3f-a863-73fc853921f4" 
  }
}
