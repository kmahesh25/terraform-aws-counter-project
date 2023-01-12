module "key_pair" {
  source     = "./modules/key_pair"
  key_name   = "ssh_key"
  public_key = file("${path.root}/ssh_keys/private.key.pub")
}
