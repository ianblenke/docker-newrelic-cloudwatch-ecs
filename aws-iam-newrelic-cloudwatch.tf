resource "aws_iam_role" "newrelic_cloudwatch_role" {
    name = "newrelic_cloudwatch_role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "newrelic_cloudwatch_policy" {
    name = "newrelic_cloudwatch_policy"
    path = "/"
    description = "Platform IAM Policy"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "autoscaling:Describe*",
        "cloudwatch:Describe*",
        "cloudwatch:List*",
        "cloudwatch:Get*",
        "ec2:Describe*",
        "ec2:Get*",
        "ec2:ReportInstanceStatus",
        "elasticache:DescribeCacheClusters",
        "elasticloadbalancing:Describe*",
        "sqs:GetQueueAttributes",
        "sqs:ListQueues",
        "rds:DescribeDBInstances",
        "SNS:ListTopics"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "newrelic_cloudwatch_policy_attach" {
    name = "newrelic_cloudwatch_policy_attach"
    roles = ["${aws_iam_role.newrelic_cloudwatch_role.name}"]
    policy_arn = "${aws_iam_policy.newrelic_cloudwatch_policy.arn}"
}

resource "aws_iam_instance_profile" "newrelic_cloudwatch_instance_profile" {
    name = "newrelic_cloudwatch_instance_profile"
    roles = ["${aws_iam_role.newrelic_cloudwatch_role.name}"]
}

