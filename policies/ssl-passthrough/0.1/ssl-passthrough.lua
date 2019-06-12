local setmetatable = setmetatable

local _M = require('apicast.policy').new('SSL Passthrough', '0.1')
local mt = { __index = _M }

local Upstream = require('apicast.upstream')

function _M.new()
  ngx.log(ngx.INFO, 'SSL Passthrough - _M:new started')
  ngx.log(ngx.INFO, ngx.var.scheme .. '://' .. ngx.var.host)
  
  
  local backend = 'https://sample-ssl-api-anugraha-ssl.apps.rhpds311.openshift.opentlc.com:443'
  local upstream, err = Upstream.new('https://sample-ssl-api-anugraha-ssl.apps.rhpds311.openshift.opentlc.com:443')
  upstream:proxy_pass('https://sample-ssl-api-anugraha-ssl.apps.rhpds311.openshift.opentlc.com:443')
  
  ngx.log(ngx.INFO, 'SSL Passthrough - _M:new completed')
  
  
  return setmetatable({}, mt)
end

function _M:access()
  ngx.log(ngx.INFO, 'SSL Passthrough - _M:access started')
  
  
  ngx.log(ngx.INFO, 'SSL Passthrough - _M:access completed')
end


function _M:log()
  ngx.log(ngx.INFO, 'SSL Passthrough - enabled - ')
end

function _M:rewrite()
  ngx.log(ngx.INFO, 'SSL Passthrough - _M:rewrite started ')
  
  
  ngx.log(ngx.INFO, 'SSL Passthrough - ngx.var.ssl_client_raw_cert: ')
  ngx.log(ngx.INFO, ngx.var.ssl_client_raw_cert)
  local client_cert = ngx.var.ssl_client_raw_cert and ngx.var.ssl_client_raw_cert:gsub('\\n',' ') or nil
  
  ngx.log(ngx.INFO, 'SSL Passthrough - client_cert: ')
  ngx.log(ngx.INFO, client_cert)
  ngx.req.set_header("X-SSL-CERT", client_cert)
  
  local headerCert = ngx.req.get_headers()["X-SSL-CERT"]
  ngx.log(ngx.INFO, 'SSL Passthrough - headerCert: ')
  ngx.log(ngx.INFO, headerCert)
  
  ngx.log(ngx.INFO, 'SSL Passthrough - _M:rewrite completed ')
  
  
end

function _M:header_filter()
  ngx.log(ngx.INFO, 'SSL Passthrough - Passing through the header_filter phase - ')
end


return _M