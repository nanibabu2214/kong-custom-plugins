local kong = kong
local AddKongVersion = {
  PRIORITY = 21,
  VERSION = "1.0.0",
}

function AddKongVersion:header_filter(conf)
  -- Only add headers when enabled in plugin config
  if not conf.add_version_header then
    return
  end

  kong.log.debug("Add-Kong-Version plugin executing in header_filter phase")
  local version = kong.version or "unknown"
  kong.response.set_header("X-#%#%#%#%#%#%#-Kong-Gateway-Version", version)
  kong.response.set_header("X-#%#%#%#%#%#%#-Custom-Header", "THIS IS ADDED BY CUSTOM PLUGIN")
  kong.log.debug("Attempting to set version header: ", version)
end

function AddKongVersion:access(conf)
  -- If enabled, add the header to the request forwarded to upstre~am
  if conf.add_version_header then
    local version = kong.version or "unknown"
    kong.service.request.set_header("X-Kong-Gateway-Version", version)
    kong.log.debug("Set request header X-Kong-Gateway-Version: ", version)
  end
end
return AddKongVersion



