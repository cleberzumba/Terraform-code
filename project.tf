# Provisionando na Google Cloud uma instancia Compute Engine, um Firewall e instalando Nginx web-server. 
# Na camada de Banco de Dados provisionando Cloud SQL e Cloud Spanner multi-regional. 
# Tudo 100% Infraestructure as Code (IaC) com Terraform.

# Configura o projeto GCP
provider "google" {  
  project     = ""
  region      = "us-central1"
}

# Cria a VM com o Google Compute Engine
resource "google_compute_instance" "webserver" {
  name          = "vm-webserver"
  machine_type  = "f1-micro"
  zone          = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

 # Habilita rede para a VM bem como um IP público
  network_interface {
    network = "default"
    access_config {
         // Ephemeral IP
    }
  }

  # Instala o servidor web Nginx
  metadata_startup_script = "apt update; apt install -y nginx; systemctl enable nginx; systemctl restart nginx; echo Welcome to Google Compute VM Instance deployed using Terraform!!! > /var/www/html/index.html" 
}

# Cria o Firewall para a VM
resource "google_compute_firewall" "webfirewall" {
  name        = "webserver-firewall"
  network     = "default"

  allow {
    protocol  = "tcp"
    ports     = ["80"]
  }

  source_tags = ["web"]
}

# Cria Cloud SQL Database Instance Postgre
resource "google_sql_database_instance" "sql-database" {
  name             = "sql-database"
  database_version = "POSTGRES_11"
  region           = "us-central1"

  settings {
    tier = "db-f1-micro"
  }
}

# Cria Cloud Spanner Instance Multi-Regional
resource "google_spanner_instance" "cloud-spanner" {
  config       = "nam-eur-asia1"
  display_name = "Multi Regional Instance"
  num_nodes    = 2
  labels = {
    "foo" = "bar"
  }
}

# Retorna o IP da VM criada
output "ip" {
  value = "${google_compute_instance.webserver.network_interface.0.access_config.0.nat_ip}"
}
