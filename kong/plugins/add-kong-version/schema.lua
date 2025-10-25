return {
  name = "add-kong-version",
  fields = {
    { config = {
        type = "record",
        fields = {
          { add_version_header  = {
              type = "boolean",
              required = false,
              default = true,
              description = "If true, add Kong version and custom header to response."
            }
          }
        }
      }
    }
  }
}