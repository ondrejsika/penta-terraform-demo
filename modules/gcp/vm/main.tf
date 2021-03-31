variable "name" {}
variable "global" {}
variable "vpc" {}
variable "image" {}
variable "size" {}

resource "google_compute_instance" "main" {
  name         = var.name
  machine_type = var.global.conf.sizes[var.size]

  boot_disk {
    initialize_params {
      image = var.global.conf.images[var.image]
    }
  }

  network_interface {
    network = var.vpc.google_compute_network.self_link
    access_config {}
  }
  metadata = {
    ssh-keys = "default:${var.global.conf.default_ssh_key}"
  }
}

resource "google_compute_firewall" "main" {
  name    = var.name
  network = var.vpc.google_compute_network.name

  allow {
    protocol = "tcp"
    // ports    = ["80", "22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

output "google_compute_instance" {
  value = google_compute_instance.main
}

output "google_compute_firewall" {
  value = google_compute_firewall.main
}

output "public_ipv4_address" {
  value = google_compute_instance.main.network_interface.0.access_config.0.nat_ip
}

output "username" {
  value = "default"
}

output "password" {
  value = null
}

