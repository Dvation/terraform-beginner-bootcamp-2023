variable "user_uuid" {
  description = "User UUID"
  type        = string

  validation {
    condition     = can(regex("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$", var.user_uuid))
    error_message = "The user_uuid must be a valid UUID format."
  }
}

variable "bucket_name" {}

variable "index_html_filepath" {
  description = "The file path for the index.html"
  type        = string

  validation {
    condition     = fileexists(var.index_html_filepath)
    error_message = "The specified index_html_filepath does not exist."
  }
}


variable "error_html_filepath" {
  description = "The file path for the error.html"
  type        = string

  validation {
    condition     = fileexists(var.error_html_filepath)
    error_message = "The specified error_html_filepath does not exist."
  }
}
