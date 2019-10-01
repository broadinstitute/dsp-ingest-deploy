# NOTE: This is needed because CloudSQL doesn't allow DB names to be reused
# within the week that they're deleted, so whenever we want to tear down and
# recreate the instance we need to generate a new name (vs waiting a week).
resource "random_id" "postgres-100-randomid" {
    byte_length = 8
    depends_on = [module.enable-services]
}

resource "google_sql_database_instance" "postgres-100" {
    provider = "google"
    region = var.google_region
    database_version = "POSTGRES_9_6"
    name = "${var.profile_name}-postgres-101-${random_id.postgres-100-randomid.hex}"
    depends_on = [module.enable-services]

    settings {
        activation_policy = "ALWAYS"
        pricing_plan = "PER_USE"
        replication_type = "SYNCHRONOUS"
        tier = "db-g1-small"

        backup_configuration {
            binary_log_enabled = false
            enabled = true
            start_time = "06:00"
        }

        ip_configuration {
            ipv4_enabled = true
            require_ssl = true
            authorized_networks {
                name = "Broad"
                value = local.broad_routeable_net
            }
            authorized_networks {
                name = "Kubernetes"
                value = google_compute_global_address.k8s-ip.address
            }
        }

        user_labels = {
            app = var.profile_name
            role = "database"
            state = "active"
        }
    }
}

resource "vault_generic_secret" "postgres-100-instance-secret" {
    path = "${var.vault_prefix}/cloudsql/instance"
    data_json = <<EOT
{
    "name": "${google_sql_database_instance.postgres-100.name}",
    "connection_name": "${google_sql_database_instance.postgres-100.connection_name}"
}
EOT
}
