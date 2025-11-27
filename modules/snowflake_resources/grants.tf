# 1. Replaces snowflake_database_grant.database_ro_grant
resource "snowflake_grant_privileges_to_account_role" "database_ro_grant" {
  # Role receiving the grants
  account_role_name = "TF_DEMO_READER"

  # The privilege to grant
  privileges = ["USAGE"]

  # Specifies the target object (a Database)
  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.tf_demo_database.name
  }

  # Optional: Allows the recipient role to re-grant the privileges
  with_grant_option = false
}

# ---

# 2. Replaces snowflake_schema_grant.schema_ro_grant
resource "snowflake_grant_privileges_to_account_role" "schema_ro_grant" {
  account_role_name = "TF_DEMO_READER"
  privileges        = ["USAGE"]

  # Specifies the target object (a Schema)
  on_schema {
    # Note: The object_name must be the fully qualified name (Database.Schema)
    schema_name = "${snowflake_database.tf_demo_database.name}.${snowflake_schema.tf_demo_schema.name}"
  }
}

# ---

# 3. Replaces snowflake_table_grant.table_ro_grant (ON FUTURE TABLES)
resource "snowflake_grant_privileges_to_account_role" "future_table_ro_grant" {
  account_role_name = "TF_DEMO_READER"
  privileges        = ["SELECT"]

  # Specifies the target for FUTURE objects within a Schema
  on_schema_object {
    future {
      object_type_plural = "TABLES" # Plural form
      in_schema          = "${snowflake_database.tf_demo_database.name}.${snowflake_schema.tf_demo_schema.name}"
    }
  }

  # `on_future` often requires this flag in the new resource
  # It ensures the grant is re-applied whenever the configuration runs.
  always_apply      = true
  with_grant_option = false
}

# ---

# 4. Replaces snowflake_view_grant.view_ro_grant (ON FUTURE VIEWS)
resource "snowflake_grant_privileges_to_account_role" "future_view_ro_grant" {
  account_role_name = "TF_DEMO_READER"
  privileges        = ["SELECT"]

  # Specifies the target for FUTURE objects within a Schema
  on_schema_object {
    future {
      object_type_plural = "VIEWS" # Plural form
      in_schema          = "${snowflake_database.tf_demo_database.name}.${snowflake_schema.tf_demo_schema.name}"
    }
  }

  always_apply      = true
  with_grant_option = false
}

# ---

# 5. Replaces snowflake_warehouse_grant.warehouse_grant
resource "snowflake_grant_privileges_to_account_role" "warehouse_grant" {
  account_role_name = "TF_DEMO_READER"
  privileges        = ["USAGE"]

  # Specifies the target object (a Warehouse, which is an Account Object)
  on_account_object {
    object_type = "WAREHOUSE"
    object_name = snowflake_warehouse.task_warehouse.name
  }
}