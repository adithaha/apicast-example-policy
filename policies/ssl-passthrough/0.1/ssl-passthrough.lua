local setmetatable = setmetatable

local _M = require('apicast.policy').new('SSL Passthrough', '0.1')
local mt = { __index = _M }

function _M.new()
  return setmetatable({}, mt)
end

function _M:access()
  ngx.log(ngx.INFO, 'SSL Passthrough - _M:access started')
  
  ngx.log(ngx.INFO, 'SSL Passthrough - ngx.var.ssl_client_raw_cert: ')
  ngx.log(ngx.INFO, ngx.var.ssl_client_raw_cert)
  local client_cert = ngx.var.ssl_client_raw_cert and ngx.var.ssl_client_raw_cert:gsub('\\n',' ') or nil
  
  ngx.log(ngx.INFO, 'SSL Passthrough - client_cert: ')
  ngx.log(ngx.INFO, client_cert)
  ngx.req.set_header("X-SSL-CERT", client_cert)
  
  --local header-content = ngx.req.get_headers()["X-SSL-CERT"]
  local header-content = ngx.header["X-SSL-CERT"]
  
  ngx.log(ngx.INFO, 'SSL Passthrough - header-content: ')
  ngx.log(ngx.INFO, header-content)
  
  ngx.log(ngx.INFO, 'SSL Passthrough - _M:access completed')
end


function _M:log()
  ngx.log(ngx.INFO, 'SSL Passthrough - enabled - ')
end

function _M:rewrite()
  ngx.log(ngx.INFO, 'SSL Passthrough - Passing through the rewrite phase. - ')
end

function _M:header_filter()
  ngx.log(ngx.INFO, 'SSL Passthrough - Passing through the header_filter phase - ')
end


return _M