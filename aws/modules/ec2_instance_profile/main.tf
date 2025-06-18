#======EC2 instance profile for EC2 to read from S3 and ECR=============

resource "aws_iam_role" "EC2_Role" {
  name               = "EC2_Role_env_${var.env}"
  assume_role_policy = file("${path.module}/iam_policy_ec2_assume_role.json")
}

resource "aws_iam_role_policy_attachment" "EC2_launch_role_Plus_ECR" {
  role = aws_iam_role.EC2_Role.name
  #Provides read-only access to Amazon EC2 Container Registry repositories, managed by AWS
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "EC2_launch_role_Plus_S3" {
  role = aws_iam_role.EC2_Role.name
  #Provides read only access to all buckets via the AWS Management Console, managed by AWS
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

//resource "aws_iam_role_policy_attachment" "EC2_launch_role_Plus_SecretsManager" {
//  role = aws_iam_role.EC2_Role.name
//  #Provides read/write access to AWS Secrets Manager via the AWS Management Console, managed by AWS
//  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
//}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "instance_profile_env_${var.env}"
  role = aws_iam_role.EC2_Role.name
}