local setmetatable = setmetatable

local _M = require('apicast.policy').new('SSL Passthrough', '0.1')
local mt = { __index = _M }

function _M.new()
  return setmetatable({}, mt)
end

function _M:access()
  ngx.log(ngx.INFO, 'SSL Passthrough _M:access started')
  local client_cert = ngx.var.ssl_client_raw_cert and ngx.var.ssl_client_raw_cert:gsub('\\n',' ') or nil
  ngx.req.set_header("X-SSL-CERT", client_cert)
  ngx.log(ngx.INFO, 'SSL Passthrough _M:access' & ngx.req.get_header("X-SSL-CERT")
  ngx.log(ngx.INFO, 'SSL Passthrough _M:access completed')
end


return _M
