module Parser
  module PluginManager
    class Vimrc
      # vundle and vim-pathogen, and neobundle are special.
      # they might not be in .vimrc.
      def self.parse(line)
        # for non github repo git://git.wincent.com/command-t.git
        if matches = line.match(/^\s*(Neo)?Bundle\s*["'](https?|git):\/\/(.*?)["']/)
          matches[3].sub(/\/$/, '') # remove trailing slash for svn repos
        elsif matches = line.match(/^\s*(Neo)?Bundle\s*["'](.*?)(\.git)?["']/)
          matches[2]
        elsif line.match(/^\s*call\s+vundle#rc()/)
          "gmarik/vundle"
        elsif line.match(/^\s*call\s+pathogen#infect()/)
          "tpope/vim-pathogen"
        elsif line.match(/^\s*call\s+neobundle#rc/)
          "Shougo/neobundle.vim"
        else
          nil
        end
      end
    end
  end
end
