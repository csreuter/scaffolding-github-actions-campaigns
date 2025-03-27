provider "aws" {
  region = "us-west-2"

}

provider "google" {
  project = google_project.test.project_id
  region  = "us-central1"
}

resource "google_project" "test" {
  name       = "Test Logging Project"
  project_id = "test-logging-project-123"
  org_id     = "test" # Replace with your org or folder id
  billing_account = "test" # Must be linked
}
