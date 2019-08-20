resource "google_service_account" "cloudsql-proxy-sa" {
    account_id = "${var.app_name}-cloudsql-proxy-sa"
    display_name = "CloudSQL proxy account"
    depends_on = [module.enable-services]
}

resource "google_service_account_key" "cloudsql-proxy-sa-key" {
    service_account_id = google_service_account.cloudsql-proxy-sa.name
}

resource "vault_generic_secret" "cloudsql-proxy-sa-key-secret" {
    path = "secret/dsde/monster/${var.env}/${var.app_name}/${var.ingest_project}/cloudsql/proxy-sa-key"
    data_json = base64decode(google_service_account_key.cloudsql-proxy-sa-key.private_key)
}

# NOTE: SAs created through Terraform are eventually-consistent, so we need to inject
# an arbitrary delay between creating the account and applying IAM rules.
# See: https://www.terraform.io/docs/providers/google/r/google_service_account.html
# And: https://github.com/hashicorp/terraform/issues/17726#issuecomment-377357866
resource "null_resource" "cloudsql-proxy-delay" {
    provisioner "local-exec" {
        command = "sleep 10"
    }
    triggers = {
        "before" = google_service_account.cloudsql-proxy-sa.unique_id
    }
}

resource "google_project_iam_member" "cloudsql-proxy-sa-iam" {
    project = var.google_project
    role = "roles/cloudsql.client"
    member = "serviceAccount:${google_service_account.cloudsql-proxy-sa.email}"
    depends_on = [null_resource.cloudsql-proxy-delay]
}
