variable "estagiarios" {
  type = list(string)
}

resource "aws_iam_policy" "estagiario_policies" {
  count       = length(var.estagiarios)
  name        = "${var.estagiarios[count.index]}-ec2-policy"
  description = "Permite acesso apenas à instância EC2 da(o) ${var.estagiarios[count.index]}"
  policy      = file("${path.module}/../policies/${var.estagiarios[count.index]}.json")
}