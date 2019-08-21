resource "random_id" "transporter-group-id-suffix" {
    byte_length = 16
    depends_on = [module.enable-services]
}

resource "vault_generic_secret" "transporter-group-id-secret" {
    path = "secret/dsde/monster/${var.env}/${var.app_name}/${var.ingest_project}/kafka/group-ids/transporter"
    data_json = <<EOT
{
    "manager_group": "transporter-managers-${random_id.transporter-group-id-suffix.hex}",
    "agent_group": "transporter-agents-${random_id.transporter-group-id-suffix.hex}"
}
EOT
}
