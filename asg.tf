data "aws_ami" "amzlinux-2" {
  filter {
    name   = "name"
    values = [ "amzn2-ami-hvm-*-x86_64-gp2" ]
  }
  filter {
    name   = "virtualization-type"
    values = [ "hvm" ]
  }
  filter {
    name   = "root-device-type"
    values = [ "ebs" ]
  }
  most_recent = true
  owners      = ["137112412989"]
}

resource "aws_launch_configuration" "terra1" {
  name          = "terra1"
  image_id      = data.aws_ami.amzlinux-2.id
  instance_type = "t2.micro"

  key_name = aws_key_pair.terra1.key_name

  security_groups = [ aws_security_group.terra1_common.id ]

}

resource "aws_autoscaling_group" "terra1" {
  name = "terra1"

  launch_configuration = aws_launch_configuration.terra1.id
  max_size             = var.asg_size_max
  min_size             = var.asg_size_min

  vpc_zone_identifier = [ aws_subnet.terra1_b.id ]

}
