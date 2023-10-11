provider "aws" {
  region = var.region

}

resource "aws_s3_bucket" "website" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_versioning" "bucket-version" {
  bucket = aws_s3_bucket.website.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "public" {
  bucket = aws_s3_bucket.website.id
    policy = data.aws_iam_policy_document.public.json
}

data "aws_iam_policy_document" "public" {
  statement {
    principals {
      type = "*"
      identifiers = ["*"]
    }
    effect = "Allow"

    actions = [
        "s3:GetObject","s3:PutBucketPolicy"
    ]

    resources = [ 
        aws_s3_bucket.website.arn,
        "${aws_s3_bucket.website.arn}/*"
     ]
  }
}


resource "aws_s3_bucket_website_configuration" "bucket-web" {
  bucket = aws_s3_bucket.website.id

  index_document {
    suffix = "index.html"
  }
}

# aws data hosted zone
/*data "aws_route53_zone" "hosted_zone"{
  name=var.domain_name
}*/

#resource "aws_route53_record" "site_domain" {
 # zone_id = aws_route53_zone.hosted_zone.zone_id
 # name    = var.record_name
#  type    = "A"
 # alias {
 #   name    = aws_s3_bucket.website.website_domain
 #   zone_id = aws_s3_bucket.website.hosted_zone_id
 #   evaluate_target_health = false
 # }
#}
