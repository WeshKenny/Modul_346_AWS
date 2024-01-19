terraform {
    required_providers {
        aws = {
          source = "hashicorp/aws"
          version = "~> 5.0"
        }
    }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "M346_Public" {
  key_name = "M346_Public"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCX44s1O4dFwPmPuXre/GDF9CWcbW5PBn9PgF0f+SC9uhIJiSzXGx6sOQ9MAJSBzXdGKPM/YKOh9GYtq4fHKlwA2Rw3LXqxrgEv4pvh+j4wy7eA8ZhsvCfUv8RpRsqalGnQZ2j1aYs+F/LvFGlmOUh07xtTHPB888XL59EaHsDWGudUOQJiFhi3uxMPwp4C4djKqf1IVSEm/9CMYQBiOGJjFOJ2N3TTDQvTo4ez5BwOv5G5qgL380K3V1APcYYMXqWTZJr2+sv5+bF1Mp0+oKvuEOr76LbwV922OK0TmpRRYQ2kaX34foyskuHZ3put7WUrRlorAMTNL03K5QeaMDaR rsa-key-20240115"
}   # Public Key per Putty Generiert

# Neues VPC erstellen
resource "aws_vpc" "Terrafrom_m346_vpc" {
  cidr_block = "10.0.0.0/16"  #grösse des VPC's
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "Terra_M346"
  }
}

# Neues Gateway erstellen

resource "aws_internet_gateway" "Terrafrom_Internet_Gateway_m346" {
  vpc_id = aws_vpc.Terrafrom_m346_vpc.id
}

# Subnetze für Servernetz

resource "aws_subnet" "Terraform_Subnet_m346" {
  vpc_id = aws_vpc.Terrafrom_m346_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "M346 Datenbank Subnetz"
  }
}

# Routing konfigurieren

resource "aws_route_table" "m346_route_table" {
  vpc_id = aws_vpc.Terrafrom_m346_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Terrafrom_Internet_Gateway_m346.id
  }
}

# Routing Table Subnetze zuweisen

resource "aws_route_table_association" "m346_srv_subnet_association" {
  subnet_id = aws_subnet.Terraform_Subnet_m346.id
  route_table_id = aws_route_table.m346_route_table.id
}

# Sicherheitsgruppe SSH
resource "aws_security_group" "allow_ssh" {
  vpc_id = aws_vpc.Terrafrom_m346_vpc.id

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port = 22    # Damit öffnen wir den SSH Port
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_instance" "m346_Terraform_Instanz" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.Terraform_Subnet_m346.id         # Hier geben wir die Konfiguration von der Instanz an( Welcher Typ, OS usw.)
  vpc_security_group_ids = [ aws_security_group.allow_ssh.id ]
  key_name = aws_key_pair.M346_Public.key_name

  tags = {
    Name = "m346_Terraform_Instanz"
  }
  # Hier erstellen wir ein Cloud init File mit dem Wir ein Benutzer erstellen und apache installieren
  user_data = <<-EOT
  #cloud-config
  users:
    - name: smltest   
      password: sml12345
      chpasswd: {expire: False}
      groups:
        - sudo
      sudo:
        - ALL=(ALL:ALL) ALL

  packages:
    - apache2
  EOT
}