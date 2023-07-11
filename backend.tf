terraform {
 backend "gcs" {
   bucket  = "bb3442737ef54402-terraform-state-bucket"
   prefix  = "terraform/state"
 }
}
