class Group < ActiveRecord::Base
  has_many :plugins

  scope :popular, select("plugins.id, plugins.url, count(user_plugins.plugin_id) AS count_plugins")
                    .joins(:plugins => :user_plugins)
                    .group("groups.id")
                    .where("user_plugins.deleted_at is NULL")
                    .order("count_plugins DESC")
                    .limit(100)

  scope :recent, select("plugins.id, plugins.url")
                    .joins(:plugins)
                    .order("plugins.id DESC")
                    .limit(100)
end
