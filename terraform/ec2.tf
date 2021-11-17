resource "aws_instance" "sample" {
  count                    = length(var.COMPONENTS)
  ami                      = "ami-0855cab4944392d0a"
  instance_type            = "t2.micro"
  vpc_security_group_ids   = [aws_security_group.sample_sg.id]
  tags                     = {
    Name                   = element(var.COMPONENTS,count.index )
  }
}
resource "local_file" "inventory-file" {
  content     = "[FRONTEND]\n${var.COMPONENTS[0]}\n[PAYMENT]\n${var.COMPONENTS[5]}\n[SHIPPING]\n${var.COMPONENTS[4]}\n[USER]\n${var.COMPONENTS[2]}\n[CATALOGUE]\n${var.COMPONENTS[1]}\n[CART]\n${var.COMPONENTS[3]}\n[REDIS]\n${var.COMPONENTS[8]}\n[RABBITMQ]\n${var.COMPONENTS[9]}\n[MONGODB]\n${var.COMPONENTS[6]}\n[MYSQL]\n${var.COMPONENTS[5]}\n"
  filename    = "/tmp/inv-roboshop"
}

resource "aws_route53_record" "records" {
  depends_on         = [aws_instance.sample]
  count              = length(var.COMPONENTS)
  name               = element(var.COMPONENTS, count.index )
  type               = "A"
  zone_id            = "Z10458503LT1IRR8FV3H6"
  ttl                = 300
  records            = [element(aws_instance.sample.*.private_ip, count.index )]

}


