FriendlyId.defaults do |config|
  config.use :reserved
  config.reserved_words = %w(
    new
    edit
    index
    admin
    users
    login
    logout
    signup
    settings
    plugins
    resque
  )
end
