class UserPlugin < ActiveRecord::Base
  belongs_to :user
  belongs_to :plugin

  def plugin_url
    plugin && plugin.url
  end

  def plugin_url=(url)
    self.plugin = Plugin.find_or_create_by_url(url) unless url.blank?
  end
end
