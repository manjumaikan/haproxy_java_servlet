resource "aws_key_pair" "mmk_ec2_key_pair" {
  key_name = "mmk-java-servlet-key-pair"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCY515YWptwmtaJl70rGw0+I0WdM9qWFGKnTlAnPrQZFDwG+wJzqVMuYlvJe7QVHmFZxbr/qnuAdPIxzmhxlh3XCn245aoBzKBExmuLwLcuNrYuJQ4lv80jNULpgHQyMmIRvf2Q0/5rgSD8qSkxEzz2FRH4ZyAlBcb+TltSx6R5DPfzS6XKj9mvtTGtCUHYVehWX68dJnzJQYe//BzDqWwMrUvfPRYtDB4Ag1bU5WAR6pVZHg/BymdPAGmIfu2gYfYKasIbyOchGUy/7LJIxz0RCO2sXtQ1NJ4CJL95eWKpf8OtpazEXTyDqabl1gBnic9KRJpev77ugSZBi4KeoVEr"
}