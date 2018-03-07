provider "google" {
  credentials = "${file("/root/gcp/gcp-managemant-key.json")}"
  project     = "strong-return-191602"
  region      = "asia-northeast1"
}

resource "google_compute_instance" "www1" {
  name         = "www1"
  machine_type = "f1-micro"
  zone         = "asia-northeast1-b"
  tags         = ["http-server"]
 
  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
      size = "10"
    }
  }

  metadata_startup_script = <<EOT
yum install -y httpd
echo "<html><body><h1>Hello World! running on `hostname`</h1></body></html>" > /var/www/html/
index.html
apachectl start
EOT

  network_interface {
    access_config {
      // Ephemeral IP
    }
    subnetwork = "default"
  }
}
