output "created_iam_users_all" {
  value = aws_iam_user.users
}

output "created_iam_user_id" {
  value = aws_iam_user.users[*].id
}

output "created_iam_user_custom" {
  value = [
  for user in aws_iam_user.users :
  "Username: ${user.name} has ARN: ${user.arn}"]
}

output "created_iam_users_map" {
  value = {
    for user in aws_iam_user.users :
        user.unique_id => user.id

  }
}

output "custom_if_length" {
  value = [
  for x in aws_iam_user.users:
  x.name
  if length(x.name) < 7]
}

output "server_all" {
  value = {
    for server in aws_instance.servers:
        server.id => server.public_ip
  }
}