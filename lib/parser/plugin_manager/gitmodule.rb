module Parser
  module PluginManager
    class Gitmodule
      def self.parse(file)
        plugins = []
        files = file.readlines
        files.each_with_index do |line, i|
          if line =~ /^\s*path =(.*)bundle/
            matched = files[i + 1].match(/^\s*url\s*=\s*(https?|git):\/\/github\.com\/(.*)\.git/)
            plugin = matched[2].gsub(/^vim-scripts\//, "") # remove if repo name start with vim-scripts
            plugins << plugin
          end
        end
        plugins.uniq
      end
    end
  end
end
