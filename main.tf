# This code is compatible with Terraform 4.25.0 and versions that are backwards compatible to 4.25.0.
# For information about validating this Terraform code, see https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/google-cloud-platform-build#format-and-validate-the-configuration

resource "google_compute_instance" "bg3" {
  boot_disk {
    auto_delete = true
    device_name = "bg3"

    initialize_params {
      image = "projects/windows-cloud/global/images/windows-server-2022-dc-v20230712"
      size  = 200
      type  = "pd-ssd"
    }

    mode = "READ_WRITE"
  }

  can_ip_forward      = false
  deletion_protection = false
  enable_display      = true

  guest_accelerator {
    count = 1
    type  = "projects/${var.PROJID}/zones/us-central1-${var.ZONE}/acceleratorTypes/${var.GPU}"
  }

  labels = {
    goog-ec-src = "vm_add-tf"
  }

  machine_type     = "n1-standard-8"
  name             = "bg3"

  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }

    subnetwork = "projects/${var.PROJID}/regions/us-central1/subnetworks/default"
  }

  scheduling {
    automatic_restart   = false
    on_host_maintenance = "TERMINATE"
    preemptible         = false
    provisioning_model  = "STANDARD"
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }

  zone = "us-central1-${var.ZONE}"
}


