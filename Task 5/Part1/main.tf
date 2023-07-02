provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
  token      = var.session_token
}

resource "aws_instance" "Udacity_T2" {
  count         = 4
  instance_type = "t2.micro"
  ami           = "ami-06b09bfacae1453cb"
  tags = {
    Name = "Udacity T2"
  }
}

resource "aws_instance" "Udacity_M4" {
  count         = 2
  ami           = "ami-06b09bfacae1453cb"
  instance_type = "m4.large"
  tags = {
    Name = "Udacity M4"
  }
}
