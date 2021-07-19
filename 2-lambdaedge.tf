data "archive_file" "cloudfront_response_lambda" { 
  type        = "zip"
  source_file = "${path.root}/common/set_http_headers.js" 
  output_path = "${path.root}/common/set_http_headers.zip" 
}

resource "aws_iam_role" "cloudfront_lambda_exec_role" {
  name        = "jously-webapp-lambda-edge-exec-role" 
  description = "Lambda service role used to set hardened jously parent App HTTP rsponse headers" 
 
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17", 
  "Statement": [ 
    { 
      "Sid": "", 
      "Effect": "Allow", 
      "Principal": { 
        "Service": [ 
          "lambda.amazonaws.com", 
          "edgelambda.amazonaws.com" 
        ] 
      }, 
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
  
  tags = "${merge( 
    local.common_tags, 
    map( 
      "Purpose", "Used by Lambda Edge function which sets hardened HTTP headers on response", 
      "Name", "jously-lambda-edge-exec-role" 
    ) 
  )}"
}
 
resource "aws_lambda_function" "cloudfront_response_lambda" {  
  filename = "${path.root}/common/set_http_headers.zip" 
  description = "Sets secure response headers on CloudFront origin response" 
  function_name = "jously-webapp-http-response-headers" 
  role = "${aws_iam_role.cloudfront_lambda_exec_role.arn}" 
  handler = "set_http_headers.handler" 
  source_code_hash = "${data.archive_file.cloudfront_response_lambda.output_base64sha256}" 
  runtime = "nodejs12.x" 
  publish = "true" 
 
  tags = "${merge( 
    local.common_tags, 
    map( 
      "Purpose", "Sets hardened HTTP response headers for Cloudfront response", 
      "Name", "set-jously-webapp-http-response-headers" 
    ) 
  )}" 
}


Feedback
English (US)
