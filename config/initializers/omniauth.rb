# Change this omniauth configuration to point to your registered provider
# Since this is a registered application, add the app id and secret here
# APP_ID = 'key'
# APP_SECRET = 'secret'
#
# CUSTOM_PROVIDER_URL = 'http://localhost:3000'
require 'sso'

Rails.application.config.middleware.use ::OmniAuth::Builder do
  provider :sso, 'pGQDv6QqImXQTuQru7nyUg', '06b92951-0031-4579-b313-9b2098f76831'
end
