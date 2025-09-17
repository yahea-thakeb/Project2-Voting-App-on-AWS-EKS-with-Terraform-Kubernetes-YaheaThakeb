output "alb_sg_id" { value = aws_security_group.alb_sg.id }
output "vote_sg_id" { value = aws_security_group.vote_sg.id }
output "result_sg_id" { value = aws_security_group.result_sg.id }
output "bastion_sg_id" { value = aws_security_group.bastion_sg.id }
output "backend_sg_id" { value = aws_security_group.backend_sg.id }
output "postgres_sg_id" { value = aws_security_group.postgres_sg.id }
output "frontend_sg_id" { value = aws_security_group.frontend_sg.id }
