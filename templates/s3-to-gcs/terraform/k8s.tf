
module "k8s" {
  # terraform-shared repo
  source = "github.com/broadinstitute/terraform-shared.git//terraform-modules/k8s?ref=k8s-0.2.0-tf-0.12"
  dependencies = [module.enable-services]
  providers = {
    google = "google-beta"
  }
  location = var.google_zone

  cluster_name = var.k8s_cluster_name
  k8s_version = var.k8s_version

  cluster_network = google_compute_network.network.name
  cluster_subnetwork = google_compute_subnetwork.subnetwork-with-logging.name

  node_pool_count = var.k8s_node_count
  node_pool_machine_type = var.k8s_machine_type
  node_pool_disk_size_gb = 10

  # CIDRs of networks allowed to talk to the k8s master
  master_authorized_network_cidrs = local.broad_range_cidrs

  enable_private_nodes   = true
  enable_private_endpoint = false
  private_master_ipv4_cidr_block = local.k8s_master_private_ipv4_cidr
}

resource "google_compute_global_address" "k8s-ip" {
  provider = "google-beta"
  name = "k8s-100"
  depends_on = [module.enable-services]
}
