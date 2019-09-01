resource "google_compute_network" "network" {
  name                    = "${var.profile_name}-network"
  provider                = google-beta
  project                 = var.google_project

  auto_create_subnetworks = false
  depends_on              = [module.enable-services]
}

resource "google_compute_subnetwork" "subnetwork-with-logging" {
  name = "${var.profile_name}-subnetwork"
  provider = google-beta
  project = var.google_project
  region = var.google_region

  network = google_compute_network.network.self_link
  ip_cidr_range = "10.0.0.0/22"
  private_ip_google_access = true
  enable_flow_logs = true
  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }
}
