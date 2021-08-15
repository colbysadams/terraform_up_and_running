output "address" {
  value = module.stage_db.address
  description = "Connect to the database at this endpoint"
}

output "port" {
  value = module.stage_db.port
  description = "The port the db is listening on"
}