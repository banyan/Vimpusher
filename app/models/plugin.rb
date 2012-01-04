class Plugin < ActiveRecord::Base
  has_many :user_plugins
  has_many :users, through: :user_plugins
  belongs_to :groups
  before_create :create_group

  def create_group
    self.group_id = Group.create.id
  end
end
