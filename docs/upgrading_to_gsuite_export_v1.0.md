# Upgrading to GSuite Export v1.0.0 (from v0.1.0)

The v1.0.0 release of GSuite Export is a backwards incompatible release. The type of `applications` argument was changed from string to list of strings

## Migration Instructions

### Application Argument Change

Version 0.1.0 of GSuite Export used the optional `applications` string variable to set the Admin SDK applications to sync data from

```hcl
module "gsuite-export" {
  source  = "terraform-google-modules/gsuite-export/google"
  version = "~> 0.1.0"

  admin_user          = "superadmin@domain.com"
  service_account     = "svc@domain.com"
  project_id          = "my-project"
  api                 = "reports_v1"
  applications        = "login drive"
  frequency           = "*/10 * * * *"
}
```

Version 1.0.0 of GSuite Export uses the updated list of strings `applications` parameter:

```hcl
module "gsuite-export" {
  source  = "terraform-google-modules/gsuite-export/google"
  version = "~> 1.0.0"

  admin_user          = "superadmin@domain.com"
  service_account     = "svc@domain.com"
  project_id          = "my-project"
  api                 = "reports_v1"
  applications        = ["login", "drive"]
  frequency           = "*/10 * * * *"
}
```

