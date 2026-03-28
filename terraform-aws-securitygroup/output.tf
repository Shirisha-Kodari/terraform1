output "sg_id" {
    value = aws_security_group.main.id
}
# first module devolers exposed output so we can get ids from output above like 
#so we can store output in ssm parameter and we can query   exixting information by using data sources 