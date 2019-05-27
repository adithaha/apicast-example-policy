local setmetatable = setmetatable

local _M = require('apicast.policy').new('SSL Passthrough', '0.1')
local mt = { __index = _M }

function _M.new()
  return setmetatable({}, mt)
end

function _M:access()
  local client_cert = ngx.var.ssl_client_raw_cert and ngx.var.ssl_client_raw_cert:gsub('\\n',' ') or nil
  ngx.req.set_header("X-SSL-CERT", new_value)
end


function _M:log()
  ngx.log(ngx.INFO, 'SSL Passthrough enabled')
  ngx.log(ngx.WARN, 'SSL Passthrough enabled but with WARN')
end


return _M
