return {
  name = "host-replacer",
  fields = {
    { config = {
        type = "record",
        fields = {
          { custom_host = {
              type = "string",
              required = true,
              match = "^%w[%w%.-]*%w$",
              description = "The custom host to forward to upstream"
            }
          }
        }
      }
    }
  }
}
``