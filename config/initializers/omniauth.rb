Rails.application.config.middleware.use OmniAuth::Builder do
  config = YAML.load_file(Rails.root.join('config', 'oauth.yml')).recursive_symbolize_keys!

  env = Rails.env.to_sym
  provider :twitter,  config[env][:twitter][:api_key],  config[env][:twitter][:api_secret]
  provider :facebook, config[env][:facebook][:api_key], config[env][:facebook][:api_secret]
  provider :github,   config[env][:github][:api_key],   config[env][:github][:api_secret]
end
