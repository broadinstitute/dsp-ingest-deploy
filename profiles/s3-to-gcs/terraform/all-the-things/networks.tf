resource "google_compute_network" "network" {
  name                    = "${var.app_name}-network"
  project                 = var.google_project
  provider                = "google"
  auto_create_subnetworks = "true"
  depends_on              = [module.enable-services]
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = "${var.app_name}-subnetwork"
  project       = var.google_project
  provider      = "google"
  region        = var.google_region
  network       = google_compute_network.network.self_link
  depends_on    = [module.enable-services, google_compute_network.network]

  ip_cidr_range = "10.0.0.0/22"
}
