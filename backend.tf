terraform {
 backend "gcs" {
   bucket  = "52c007a371f19d80-terraform-state-bucket"
   prefix  = "terraform/state"
 }
}
