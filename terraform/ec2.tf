resource "aws_instance" "sample" {
  count                    = length(var.COMPONENTS)
  ami                      = "ami-0855cab4944392d0a"
  instance_type            = "t2.micro"
  vpc_security_group_ids   = [aws_security_group.sample_sg.id]
  tags                     = {
    Name                   = element(var.COMPONENTS,count.index )
  }
}
