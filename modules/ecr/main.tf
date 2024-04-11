resource "aws_ecr_repository" "app_ecr" {
  name         = "${var.app_name}-${var.app_env}"
  force_delete = var.repository_force_delete

}

resource "aws_ecr_lifecycle_policy" "app_ecr_lifecycle" {
  repository = aws_ecr_repository.app_ecr.name

  policy = <<EOF
{
  "rules": [
     {
      "rulePriority": 1,
      "description": "Remove untagged images",
      "selection": {
        "tagStatus": "untagged",
        "countType": "imageCountMoreThan",
        "countNumber": ${var.max_untagged_image_count}
      },
      "action": {
        "type": "expire"
      }
    },
    {
      "rulePriority": 2,
      "description": "Keep only ${var.max_image_count} most recent images",
      "selection": {
        "tagStatus": "tagged",
        "tagPrefixList": ["v"],
        "countType": "imageCountMoreThan",
        "countNumber": ${var.max_image_count}
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF
}
