variable "name" {}
variable "global" {}

resource "google_compute_network" "main" {
  name                    = var.name
  auto_create_subnetworks = "true"
}

output "google_compute_network" {
  value = google_compute_network.main
}

