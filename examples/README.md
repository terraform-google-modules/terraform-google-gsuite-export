GSuite export examples
======================

Examples to create GSuite exports on Google Cloud Platform using the `gsuite-export` module.

Variables
---------
The base Terraform variables for all the examples are defined in the `example.auto.tfvars` in the [examples](./examples)
directory.

The example-specific variables are defined under the corresponding example directory at `terraform.tfvars`.
Replace the variables by your own before running the examples.

Examples
--------
Examples are structured as follows:

* ***stackdriver/*** creates a GSuite export to Stackdriver Logging with no log export

* ***bigquery/*** creates a GSuite export to Stackdriver Logging with a log export to BigQuery

* ***pubsub/*** creates a GSuite export to Stackdriver Logging with a log export to PubSub

* ***storage/*** creates a GSuite export to Stackdriver Logging with a log export to Storage

You will need to grant extra permissions on your service account to run any of the bigquery | pubsub | storage examples.
Those extra permissions are documented in the [terraform-google-log-export README file](https://github.com/terraform-google-modules/terraform-google-log-export/tree/master/README.md).

Each example can be run individually by going to each folder and running:

```
terraform init
terraform apply
```

Scripts
-------

Scripts have been written to automate running all the examples on an organization:

* `./apply_all.sh` will run all the examples.

* `./destroy_all.sh` will destroy all the resources previously created.

* `./cleanup.sh` will clean up all the `terraform.tfstate*` files and the `.terraform` folders in each directory.
