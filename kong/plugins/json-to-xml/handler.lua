local kong = kong
local HostReplacer = {
  PRIORITY = 21,
  VERSION = "1.0.0",
}

function HostReplacer:access(conf)
  local custom_host = conf.custom_host

  if not custom_host or custom_host == "" then
    kong.log.err("Missing or empty custom_host in plugin config")
    return kong.response.exit(500, { message = "Plugin misconfigured" })
  end

  -- Replace Host header for upstream
  kong.service.request.set_header("Host", custom_host)

  -- Optionally, update SNI if using TLS
  kong.service.request.set_sni(custom_host)

  kong.log.debug("Host header replaced with: ", custom_host)
end
return HostReplacer