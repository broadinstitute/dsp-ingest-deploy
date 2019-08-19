{{with $env := env "ENVIRONMENT"}}{{with $app := env "APPLICATION_NAME"}}{{with $project := env "INGEST_PROJECT"}}
{{with $instance_secret := secret (printf "secret/dsde/monster/%s/%s/%s/cloudsql/instance" $env $app $project)}}
resource "google_sql_database" "{{env "OWNER"}}-{{$app}}-db" {
    name = "{{env "OWNER"}}-{{$app}}-db"
    project = "{{env "GOOGLE_PROJECT"}}"
    instance = "{{$instance_secret.Data.name}}"
    charset = "UTF8"
    collation = "en_US.UTF8"
}

resource "random_id" "{{env "OWNER"}}-{{$app}}-db-password" {
    byte_length = 16
}

resource "google_sql_user" "{{env "OWNER"}}-{{$app}}-db-user" {
    name = "{{env "OWNER"}}"
    password = "${random_id.{{env "OWNER"}}-{{$app}}-db-password.hex}"
    project = "{{env "GOOGLE_PROJECT"}}"
    instance = "{{$instance_secret.Data.name}}"
}

resource "vault_generic_secret" "{{env "OWNER"}}-{{$app}}-db-login-secret" {
    path = "secret/dsde/monster/{{$env}}/{{$app}}/{{$project}}/cloudsql/logins/{{env "OWNER"}}"
    data_json = <<EOT
{
    "db_name": "${google_sql_database.{{env "OWNER"}}-{{$app}}-db.name}",
    "username": "${google_sql_user.{{env "OWNER"}}-{{$app}}-db-user.name}",
    "password": "${google_sql_user.{{env "OWNER"}}-{{$app}}-db-user.password}"
}
EOT
}
{{end}}{{end}}{{end}}{{end}}
