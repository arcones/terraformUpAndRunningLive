resource "aws_s3_bucket" "terraform_state" {
  bucket = "teraform-up-and-running-arcones-state"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_iam_user" "users" {
  count = "${length(var.user_names)}"
  name  = "${element(var.user_names,count.index)}"
}

data "aws_iam_policy_document" "ec2_read_only" {
  statement {
    effect    = "Allow"
    actions   = ["ec2:Read*, ec2:List*"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "ec2_read_only" {
  name   = "ec2-read-only"
  policy = "${data.aws_iam_policy_document.ec2_read_only.json}"
}

resource "aws_iam_policy_attachment" "ec2_access_for_users" {
  name       = "EC2 read only access for users"
  users      = ["${aws_iam_user.users.*.name}"]
  policy_arn = "${aws_iam_policy.ec2_read_only.arn}"
}
