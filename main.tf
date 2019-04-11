# Environment variables are composed into the container definition at output generation time. See outputs.tf for more information.
data "null_data_source" "environment" {
  count = "${length(keys(var.environment))}"

  inputs = {
    name = "${element(keys(var.environment), count.index)}"
    value = "${lookup(var.environment, element(keys(var.environment), count.index))}"
  }
}

locals {
  container_definition = {
    name                   = "${var.container_name}"
    image                  = "${var.container_image}"
    memory                 = "${var.container_memory}"
    memoryReservation      = "${var.container_memory_reservation}"
    cpu                    = "${var.container_cpu}"
    essential              = "${var.essential}"
    entryPoint             = "${var.entrypoint}"
    command                = "${var.command}"
    workingDirectory       = "${var.working_directory}"
    readonlyRootFilesystem = "${var.readonly_root_filesystem}"
    mountPoints            = "${var.mount_points}"
    dnsServers             = "${var.dns_servers}"

    portMappings = "${var.port_mappings}"

    healthCheck = "${var.healthcheck}"

    logConfiguration = {
      logDriver = "${var.log_driver}"
      options   = "${var.log_options}"
    }

    dockerLabels = "labels_sentinel_value"

    environment = "environment_sentinel_value"
    secrets     = "secrets_sentinel_value"
  }

  labels      = "${var.labels}"
  environment = "${data.null_data_source.environment.*.outputs}"
  secrets     = "${var.secrets}"
}
