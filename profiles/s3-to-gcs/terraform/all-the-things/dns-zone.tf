resource "google_dns_managed_zone" "dns-zone" {
  count = var.google_project == var.core_google_project ? 1 : 0
  provider = "google"
  project = var.google_project
  name = var.dns_zone_name
  dns_name = "${var.dns_zone}."
}
