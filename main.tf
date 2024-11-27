#criação bucket s3
resource "aws_s3_bucket" "meubucket" {
  bucket = var.bucketname

}


resource "aws_s3_bucket_ownership_controls" "meubucket_ownership_controls" {
  bucket = aws_s3_bucket.meubucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"

  }

}

resource "aws_s3_bucket_public_access_block" "meu_bucket_public_access_block" {
  bucket = aws_s3_bucket.meubucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "meu_bucket_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.meubucket_ownership_controls,
    aws_s3_bucket_public_access_block.meu_bucket_public_access_block,
  ]

  bucket = aws_s3_bucket.meubucket.id
  acl    = "public-read" #leitura  publica
}

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.meubucket.id       # Referência ao ID do bucket
  key    = "index.html"                     # O nome do arquivo no S3
  source = "${path.module}/form/index.html" # Caminho para o arquivo no seu diretório local
  acl    = "public-read"                    # Definindo a permissão do arquivo no S3
  content_type = "text/html"
}

resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.meubucket.id       # Referência ao ID do bucket
  key    = "error.html"                     # O nome do arquivo no S3
  source = "${path.module}/form/error.html" # Caminho para o arquivo no seu diretório local
  acl    = "public-read"                    # Definindo a permissão do arquivo no S3
  content_type = "text/html"
}
