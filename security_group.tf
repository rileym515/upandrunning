resource "aws_security_group" "terra1_common" {
  name        = "terra1_common"
  vpc_id      = aws_vpc.terra1.id
  tags = {
    Name = "terra1"
    Owner = "yournamehere"
  }
}

resource "aws_security_group_rule" "terra1_common_ssh_inbound" {
  type              = "ingress"
  protocol          = "tcp"
  from_port         = "22"
  to_port           = "22"
  security_group_id = aws_security_group.terra1_common.id

  cidr_blocks = [
    # Insert your public IP here
    "1.1.1.1/32",
  ]
}

resource "aws_security_group_rule" "terra1_common_http_out" {
  type              = "egress"
  protocol          = "tcp"
  from_port         = "80"
  to_port           = "80"
  security_group_id = aws_security_group.terra1_common.id

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

resource "aws_security_group_rule" "terra1_common_https_out" {
  type              = "egress"
  protocol          = "tcp"
  from_port         = "443"
  to_port           = "443"
  security_group_id = aws_security_group.terra1_common.id

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}
