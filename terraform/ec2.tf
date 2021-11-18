resource "aws_instance" "instances" {
  count                    = length(var.COMPONENTS)
  ami                      = "ami-0855cab4944392d0a"
  instance_type            = "t2.micro"
  vpc_security_group_ids   = [aws_security_group.sample_sg.id]
  tags                     = {
    Name                   = element(var.COMPONENTS,count.index )
  }
}

resource "local_file" "inventory-file" {
  content     = "[FRONTEND]\n${aws_instance.instances.*.private_ip[0]}"
#  \n[PAYMENT]\n${aws_instance.instances.*.private_ip[5]}\n[SHIPPING]\n${aws_instance.instances.*.private_ip[4]}\n[USER]\n${aws_instance.instances.*.private_ip[2]}\n[CATALOGUE]\n${aws_instance.instances.*.private_ip[1]}\n[CART]\n${aws_instance.instances.*.private_ip[3]}\n[REDIS]\n${aws_instance.instances.*.private_ip[8]}\n[RABBITMQ]\n${aws_instance.instances.*.private_ip[9]}\n[MONGODB]\n${aws_instance.instances.*.private_ip[6]}\n[MYSQL]\n${aws_instance.instances.*.private_ip[7]}\n"
  filename    = "/tmp/inv-roboshop1"
}

resource "aws_route53_record" "records" {
  depends_on         = [aws_instance.instances]
  count              = length(var.COMPONENTS)
  name               = element(var.COMPONENTS, count.index )
  type               = "A"
  zone_id            = "Z10458503LT1IRR8FV3H6"
  ttl                = 300
  records            = [element(aws_instance.instances.*.private_ip, count.index )]


}














