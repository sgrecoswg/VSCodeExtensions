resource "" "" {
  count = var.should-deploy ? 1 : 0
  tags = {
    environment = "${var.app-env}"
  }
}