terraform {
 backend "gcs" {
   bucket  = "30565b9cf340c7fd-terraform-state-bucket"
   prefix  = "terraform/state"
 }
}
