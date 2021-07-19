data "aws_route53_zone" "jously" {
  name         = "${var.ROUTE53_HOSTED_ZONE_NAME}"
  private_zone = false
}


resource "aws_route53_record" "jously" {
  zone_id = "${data.aws_route53_zone.jously.zone_id}"
  name    = "${data.aws_route53_zone.jously.name}"
  type    = "A"
  
  alias {
    name                   = "${aws_cloudfront_distribution.webapp_s3_distribution.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.webapp_s3_distribution.hosted_zone_id}"
    evaluate_target_health = true
  }
}
