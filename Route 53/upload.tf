resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.website.id
  key    = "index.html"
  source = "D:/Documents/GitHub/AWS-Project/Route 53/html/index.html"
}

resource "aws_s3_object" "file" {
for_each = fileset(path.module, "html/**")
  bucket = aws_s3_bucket.website.id
  key    = basename (each.value)
  source = each.value
}

# Add more resource blocks for additional objects as needed
