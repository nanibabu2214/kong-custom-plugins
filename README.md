# Kong Custom Plugins

This repository contains custom plugins for Kong API Gateway. Currently, it includes:

## 1. Add Kong Version Plugin (`add-kong-version`)

A simple plugin that adds Kong version information to requests and responses. This is useful for debugging and tracking which Kong gateway instance handled a request.

### Features

- Adds `X-Kong-Gateway-Version` header to both:
  - Requests forwarded to upstream services
  - Responses sent back to clients
- Adds a custom header `X-Custom-Header` with a static message
- Can be enabled/disabled via configuration
- Works on both HTTP and HTTPS traffic

### Installation

1. Clone this repository:
```bash
git clone https://github.com/nanibabu2214/kong-custom-plugins.git
cd kong-custom-plugins
```

2. Copy the plugin folder to Kong's plugins directory:
```bash
# Option 1: Copy to local Lua path
cp -r kong/plugins/add-kong-version /usr/local/share/lua/5.1/kong/plugins/

# Option 2: Use LuaRocks (if you have a .rockspec file)
luarocks make
```

3. Add the plugin name to the `plugins` list in your Kong configuration:
```bash
# In kong.conf
plugins = bundled,add-kong-version

# Or via environment variable
export KONG_PLUGINS="bundled,add-kong-version"
```

4. Restart Kong:
```bash
kong restart
```

### Configuration

The plugin accepts the following configuration parameters:

| Parameter | Default | Description |
|-----------|---------|-------------|
| add_version_header | true | When true, adds Kong version headers to requests/responses |

### Usage Example

1. Create a Service:
```bash
curl -X POST "http://localhost:8001/services" \
     --json '{
       "name": "example_service",
       "url": "https://httpbin.konghq.com/anything"
     }'
```

2. Create a Route:
```bash
curl -X POST "http://localhost:8001/services/example_service/routes" \
     --json '{
       "name": "example_route",
       "paths": ["/mock"]
     }'
```

3. Enable the plugin:
```bash
curl -X POST "http://localhost:8001/services/example_service/plugins" \
     --json '{
       "name": "add-kong-version",
       "config": {
         "add_version_header": true
       }
     }'
```

4. Test the plugin:
```bash
# Make a request through Kong
curl -i http://localhost:8000/mock

# You should see headers in the response like:
# X-Kong-Gateway-Version: 3.x.x
# X-Custom-Header: THIS IS ADDED BY CUSTOM PLUGIN
```

### Testing

The plugin can be tested using the Kong Pongo test framework:

```bash
# Start Pongo environment
pongo up

# Run tests (once implemented)
pongo run
```

### Debugging

If headers are not appearing as expected:

1. Enable debug logging in Kong:
```bash
# In kong.conf
log_level = debug

# Or via environment variable
export KONG_LOG_LEVEL=debug
```

2. Check Kong's error log:
```bash
tail -f /usr/local/kong/logs/error.log
```

3. Verify the plugin is properly configured:
```bash
# List all plugins on a service
curl -s http://localhost:8001/services/example_service/plugins | jq .
```

### Common Issues

1. **Headers not appearing**: Make sure the plugin is enabled with `add_version_header: true` (not `add_header`).
2. **Plugin not loading**: Verify the plugin name is included in Kong's `plugins` configuration.
3. **Wrong route**: Ensure you're accessing the correct route path (/mock in the example).

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
