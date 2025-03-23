resource "aws_iam_role" "eks" {
  name = "${local.env}-${local.eks_cluster_name}-eks-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "eks" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks.name
}


resource "aws_eks_cluster" "cluster" {
  name     = "${local.env}-${local.eks_cluster_name}"
  role_arn = aws_iam_role.eks.arn
  version  = local.eks_version

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access  = true


    subnet_ids = [
      aws_subnet.public_zone1.id,
      aws_subnet.public_zone2.id
    ]
  }

  access_config {
    authentication_mode = "API"
    bootstrap_cluster_creator_admin_permissions = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks
  ]
}