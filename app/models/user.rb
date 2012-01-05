class User < ActiveRecord::Base
  has_many :vimrcs,       dependent: :destroy
  has_many :gitmodules,   dependent: :destroy
  has_many :user_plugins, dependent: :destroy
  has_many :plugins,      through: :user_plugins
  accepts_nested_attributes_for :vimrcs, allow_destroy: true, :reject_if => proc { |attributes| attributes['url'].blank? }
  accepts_nested_attributes_for :gitmodules, allow_destroy: true, :reject_if => proc { |attributes| attributes['url'].blank? }

  include Gravtastic
  gravtastic secure: true, size: 24

  extend FriendlyId
  friendly_id :username
  after_validation :validate_reserved

  validates_uniqueness_of :username, :case_sensitive => false
  validates_format_of     :username, :with => /^[a-zA-Z0-9_-]+$/
  validates_exclusion_of  :username, :in => %w(new edit)

  def self.new_with_omniauth(auth)
    new do |user|
      user.provider = auth['provider']
      user.uid      = auth['uid']
      user.username = auth['info']['nickname']
      user.email    = auth['info']['email']
    end
  end

  def self.create_with_omniauth(auth)
    new_with_omniauth(auth).save!
  end

  def plugin_urls
      self.class.select("plugins.id, plugins.url")
        .joins(:plugins)
        .where("users.id = ?", self.id)
        .where("user_plugins.deleted_at IS NULL")
  end

  private
  def validate_reserved
    if @errors[:friendly_id].present?
      @errors[:username] = "is reserved. Please choose something else"
      @errors.messages.delete(:friendly_id)
    end
  end
end
