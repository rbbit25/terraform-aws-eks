/* 
    EKS Policy for External DNS
    Develop By: William MR
*/

resource "aws_iam_policy" "policy" {
    name        = "eks-external-dns-policy"
    path        = "/"
    description = "EKS External DNS Policy"

    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "route53:ChangeResourceRecordSets"
      ],
      "Resource": [
        "arn:aws:route53:::hostedzone/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "route53:ListHostedZones",
        "route53:ListResourceRecordSets"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}