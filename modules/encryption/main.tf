# You need to create a service account for each project that requires customer-managed encryption keys.
resource "google_project_service_identity" "gcp_sa_cloud_sql" {
  provider = google-beta
  service  = "sqladmin.googleapis.com"
}

# Grant access to the key
resource "google_kms_crypto_key_iam_binding" "crypto_key" {
  provider      = google-beta
  crypto_key_id = var.encryption_key_id == null ? google_kms_crypto_key.this[0].id : var.encryption_key_id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"

  members = [
    "serviceAccount:${google_project_service_identity.gcp_sa_cloud_sql.email}",
  ]
}

# Create key if not provided 
resource "google_kms_key_ring" "this" {
  count = var.encryption_key_id == null ? 1 : 0

  name     = var.name
  location = var.region
}

resource "google_kms_crypto_key" "this" {
  count = var.encryption_key_id == null ? 1 : 0

  name            = "${var.name}-key"
  key_ring        = google_kms_key_ring.this[0].id
  rotation_period = var.encryption_key_rotation_period
}