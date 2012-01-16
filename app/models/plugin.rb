class Plugin < ActiveRecord::Base
  has_many :user_plugins
  has_many :users, through: :user_plugins
  belongs_to :groups
  before_create :create_group

  def create_group
    self.group_id = Group.create.id
  end

  def using_users
      self.class.select("users.id, users.username, user_plugins.updated_at")
        .joins(:users)
        .where("plugins.id = ?", self.id)
        .where("user_plugins.deleted_at IS NULL")
        .order("user_plugins.updated_at DESC")
  end
end
