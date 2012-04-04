require 'open-uri'
require 'parser/plugin_manager/vimrc'
require 'parser/plugin_manager/gitmodule'

class Crawler
  @queue = :crawler_queue

  def self.perform(user_id)
    user   = User.find(user_id)
    vimrcs = user.vimrcs.map{|vimrc| convert_2_rawurl(vimrc.url) }
    gitmodules = user.gitmodules.map{|gitmodule| convert_2_rawurl(gitmodule.url) }
    return if vimrcs.blank? && gitmodules.blank?

    current_plugins = []

    # TODO HTTP Error handling

    if vimrcs.present?
      vimrcs.each do |vimrc|
        open(vimrc) do |file|
          file.each_line do |line|
            match = Parser::PluginManager::Vimrc.parse(line)
            current_plugins << match unless match.blank?
          end
        end
      end
    end

    if gitmodules.present?
      gitmodules.each do |gitmodule|
        open(gitmodule) do |file|
          matches = Parser::PluginManager::Gitmodule.parse(file)
          current_plugins << matches unless matches.blank?
        end
      end
    end

    return if current_plugins.blank?

    current_plugins.flatten!
    current_plugins.uniq!

    db_plugins      = user.plugin_urls.map(&:url)
    new_plugins     = current_plugins - db_plugins
    deleted_plugins = db_plugins - current_plugins

    new_plugins.each do |plugin|
      if row = UserPlugin.find_by_user_id_and_plugin_id(user.id, Plugin.find_by_url(plugin).try(:id))
        row.update_attribute(:deleted_at, nil)
      else
        UserPlugin.create(user_id: user.id, plugin_url: plugin)
      end
    end

    if deleted_plugins.present?
      plugin_ids = Plugin.where(url: deleted_plugins).map(&:id)
      UserPlugin.where(user_id: user.id, plugin_id: plugin_ids).update_all(deleted_at: Time.now)
    end
  end

  # convert url
  # TODO: move somewhere
  # from: https://github.com/banyan/config/blob/master/.vimrc
  # to:   https://raw.github.com/banyan/config/master/.vimrc
  def self.convert_2_rawurl(url)
    if url =~ /^https:\/\/github.com\//
      url.sub!(/^https:\/\/github.com\//, "https://raw.github.com/").sub!(/\/blob\//, "/")
    end
    url
  end
end
