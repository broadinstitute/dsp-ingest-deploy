resource "google_sql_database" "transporter-db" {
    name = "${var.app_name}-transporter-db"
    project = var.google_project
    instance = google_sql_database_instance.postgres-100.name
    charset = "UTF8"
    collation = "en_US.UTF8"
}

resource "random_id" "transporter-db-password" {
    byte_length = 16
}

resource "google_sql_user" "transporter-db-user" {
    name = "transporter-manager"
    password = random_id.transporter-db-password.hex
    project = var.google_project
    instance = google_sql_database_instance.postgres-100.name
}

resource "vault_generic_secret" "transporter-db-login-secret" {
    path = "secret/dsde/monster/${var.env}/${var.app_name}/${var.ingest_project}/cloudsql/logins/transporter-manager"
    data_json = <<EOT
{
    "db_name": "${google_sql_database.transporter-db.name}",
    "username": "${google_sql_user.transporter-db-user.name}",
    "password": "${google_sql_user.transporter-db-user.password}"
}
EOT
}
