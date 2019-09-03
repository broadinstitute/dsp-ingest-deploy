resource "google_dns_managed_zone" "dns-zone" {
  provider = "google"
  project = var.google_project
  name = var.dns_zone_name
  dns_name = "${var.dns_zone}."
}
