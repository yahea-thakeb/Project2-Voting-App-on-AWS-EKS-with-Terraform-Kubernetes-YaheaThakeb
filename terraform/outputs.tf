# --- Network ---
output "vpc_id" {
  value = module.network.vpc_id
}
output "public_subnet_ids" {
  value = module.network.public_subnet_ids
}
output "private_subnet_a_id" {
  value = module.network.private_subnet_a_id
}
output "private_subnet_b_id" {
  value = module.network.private_subnet_b_id
}

# --- Security groups (add only those you need) ---
output "alb_sg_id" {
  value = module.security.alb_sg_id
}
output "vote_sg_id" {
  value = module.security.vote_sg_id
}
output "result_sg_id" {
  value = module.security.result_sg_id
}


