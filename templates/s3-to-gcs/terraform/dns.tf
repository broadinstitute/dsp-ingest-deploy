data "google_dns_managed_zone" "core-dns-zone" {
    count = var.enable_dns ? 1 : 0
    provider = "google"
    project = var.dns_google_project
    name = var.dns_zone_name
}

resource "google_compute_global_address" "transporter-manager-ip" {
    count = var.enable_dns ? 1 : 0
    provider = "google"
    name = "${var.profile_name}-transporter-ip"
    project = var.google_project
    depends_on = [module.enable-services]
}

resource "google_dns_record_set" "transporter-manager-a-dns" {
    count = var.enable_dns ? 1 : 0
    provider = "google"
    project = var.dns_google_project
    type = "A"
    ttl = "300"

    managed_zone = data.google_dns_managed_zone.core-dns-zone[0].name
    name = "${var.transporter_dns_name}-global.${data.google_dns_managed_zone.core-dns-zone[0].dns_name}"
    rrdatas = [google_compute_global_address.transporter-manager-ip[0].address]
    depends_on = [module.enable-services]
}

resource "google_dns_record_set" "transporter-manager-cname-dns" {
    count = var.enable_dns ? 1 : 0
    provider = "google"
    project = var.dns_google_project
    type = "CNAME"
    ttl = "300"

    managed_zone = data.google_dns_managed_zone.core-dns-zone[0].name
    name = "${var.transporter_dns_name}.${data.google_dns_managed_zone.core-dns-zone[0].dns_name}"
    rrdatas = [google_dns_record_set.transporter-manager-a-dns[0].name]
    depends_on = [module.enable-services]
}
