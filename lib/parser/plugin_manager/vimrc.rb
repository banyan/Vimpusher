module Parser
  module PluginManager
    class Vimrc
      # vundle and vim-pathogen, and neobundle are special.
      # they might not be in .vimrc.
      def self.parse(line)
        if line.match(/^\s*call\s+vundle#rc()/)
          "gmarik/vundle"
        elsif line.match(/^\s*call\s+pathogen#infect()/)
          "tpope/vim-pathogen"
        elsif line.match(/^\s*call\s+neobundle#rc/)
          "Shougo/neobundle.vim"
        # for github repo: git://github.com/vim-scripts/neocomplcache.git
        elsif matches = line.match(/^\s*(Neo)?Bundle\s*["']git:\/\/github\.com\/(vim-scripts\/)?(.*?)(\.git)?["']/)
          matches[3]
        # for non github repo: git://git.wincent.com/command-t.git
        elsif matches = line.match(/^\s*(Neo)?Bundle\s*["'](https?|git):\/\/(.*?)["']/)
          matches[3].sub(/\/$/, '') # remove trailing slash for svn repos
        # for ordinary vundle or neobundle url: Lokaltog/vim-easymotion
        elsif matches = line.match(/^\s*(Neo)?Bundle\s*["'](.*?)(\.git)?["']/)
          matches[2]
        else
          nil
        end
      end
    end
  end
end
