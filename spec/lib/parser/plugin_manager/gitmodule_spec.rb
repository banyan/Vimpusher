require 'spec_helper'
require 'parser/plugin_manager/gitmodule'

gitmodule_sample1 = <<-EOS
[submodule ".vim/bundle/fugitive"]
  path = .vim/bundle/fugitive
  url = git://github.com/tpope/vim-fugitive.git
[submodule ".vim/bundle/neocomplcache"]
  path = .vim/bundle/neocomplcache
  url = git://github.com/Shougo/neocomplcache.git
[submodule ".vim/bundle/vim-rails"]
  path = .vim/bundle/vim-rails
  url = git://github.com/tpope/vim-rails.git
[submodule ".vim/bundle/vim-surround"]
  path = .vim/bundle/vim-surround
  url = git://github.com/tpope/vim-surround.git
[submodule ".vim/bundle/detectindent"]
  path = .vim/bundle/detectindent
  url = git://github.com/ciaranm/detectindent.git
[submodule ".vim/bundle/vim-javascript"]
  path = .vim/bundle/vim-javascript
  url = git://github.com/pangloss/vim-javascript.git
[submodule ".vim/bundle/vim-haml"]
  path = .vim/bundle/vim-haml
  url = git://github.com/tpope/vim-haml.git
[submodule ".vim/bundle/vim-quickrun"]
  path = .vim/bundle/vim-quickrun
  url = git://github.com/thinca/vim-quickrun.git
[submodule ".vim/bundle/vimproc"]
  path = .vim/bundle/vimproc
  url = git://github.com/Shougo/vimproc.git
[submodule ".vim/bundle/vimshell"]
  path = .vim/bundle/vimshell
  url = git://github.com/Shougo/vimshell.git
[submodule ".vim/bundle/vim-ruby"]
  path = .vim/bundle/vim-ruby
  url = git://github.com/vim-ruby/vim-ruby.git
EOS

gitmodule_sample2 = <<-EOS
[submodule "bundle/fugitive"]
    path = .vim/bundle/fugitive
    url = git://github.com/tpope/vim-fugitive.git
[submodule "bundle/vim-ham"]
    path = .vim/bundle/vim-ham
    url = git://github.com/tpope/vim-haml.git
[submodule "bundle/vim-haml"]
    path = .vim/bundle/vim-haml
    url = git://github.com/tpope/vim-haml.git
[submodule "bundle/sudo"]
    path = .vim/bundle/sudo
    url = git://github.com/vim-scripts/sudo.vim.git
[submodule "bundle/endwise"]
    path = .vim/bundle/endwise
    url = git://github.com/vim-scripts/endwise.vim.git
[submodule "bundle/thinca_vim-guicolorscheme"]
    path = .vim/bundle/thinca_vim-guicolorscheme
    url = git://github.com/thinca/vim-guicolorscheme.git
[submodule "bundle/yanktmp"]
    path = .vim/bundle/yanktmp
    url = git://github.com/vim-scripts/yanktmp.vim.git
[submodule "bundle/YankRing"]
    path = .vim/bundle/YankRing
    url = git://github.com/vim-scripts/YankRing.vim.git
[submodule "bundle/mru"]
    path = .vim/bundle/mru
    url = git://github.com/vim-scripts/mru.vim.git
[submodule "bundle/quickrun"]
    path = .vim/bundle/quickrun
    url = git://github.com/vim-scripts/quickrun.git
[submodule "bundle/Smooth-Scroll"]
    path = .vim/bundle/Smooth-Scroll
    url = git://github.com/vim-scripts/Smooth-Scroll.git
[submodule "bundle/JavaScript-syntax"]
    path = .vim/bundle/JavaScript-syntax
    url = git://github.com/vim-scripts/JavaScript-syntax.git
[submodule "bundle/vim-javascript"]
    path = .vim/bundle/vim-javascript
    url = git://github.com/vim-scripts/JavaScript-syntax.git
[submodule "bundle/vim-php"]
    path = .vim/bundle/vim-php
    url = git://github.com/vim-scripts/php.vim.git
[submodule ".vim/bundle/pathogen"]
    path = .vim/bundle/pathogen
    url = git://github.com/tpope/vim-pathogen.git
[submodule ".vim/bundle/The-NERD-Commenter"]
    path = .vim/bundle/The-NERD-Commenter
    url = https://github.com/vim-scripts/The-NERD-Commenter.git
[submodule ".vim/bundle/autocomplpop"]
    path = .vim/bundle/autocomplpop
    url = https://github.com/vim-scripts/AutoComplPop.git
[submodule ".vim/bundle/eregex"]
    path = .vim/bundle/eregex
    url = https://github.com/vim-scripts/eregex.vim.git
[submodule ".vim/bundle/unite"]
    path = .vim/bundle/unite
    url = https://github.com/Shougo/unite.vim.git
[submodule ".vim/bundle/vim-ref"]
    path = .vim/bundle/vim-ref
    url = https://github.com/thinca/vim-ref.git
EOS

gitmodule_sample3 = <<-EOS
[submodule "bundle/tabular"]
  path = bundle/tabular
  url = git://github.com/godlygeek/tabular.git
[submodule "bundle/solarized"]
  path = bundle/solarized
  url = git://github.com/altercation/vim-colors-solarized.git
[submodule "bundle/rooter"]
  path = bundle/rooter
  url = git://github.com/airblade/vim-rooter.git
[submodule "bundle/syntastic"]
  path = bundle/syntastic
  url = git://github.com/scrooloose/syntastic.git
[submodule "bundle/vimwiki"]
  path = bundle/vimwiki
  url = git://github.com/vim-scripts/vimwiki.git
EOS

gitmodule_sample4 = <<-EOS
[submodule "bin/gittools"]
    path = bin/gittools
    url = https://github.com/tyru/gittools.git
[submodule ".vim/vundle"]
    path = .vim/vundle
    url = git://github.com/gmarik/vundle.git
[submodule ".zsh.d/oh-my-zsh"]
    path = .zsh.d/oh-my-zsh
    url = https://github.com/robbyrussell/oh-my-zsh.git
EOS

gitmodule_sample5 = <<-EOS
aaaaaa
bbbbb
cccccc
dddddd
EOS


describe Parser::PluginManager::Gitmodule do
  describe '#parse' do
    subject { Parser::PluginManager::Gitmodule }

    context "For Pathogen" do
      it { subject.parse(StringIO.new(gitmodule_sample1)).should ==
        ["tpope/vim-fugitive", "Shougo/neocomplcache", "tpope/vim-rails", "tpope/vim-surround", "ciaranm/detectindent", "pangloss/vim-javascript", "tpope/vim-haml", "thinca/vim-quickrun", "Shougo/vimproc", "Shougo/vimshell", "vim-ruby/vim-ruby"]
      }
      it { subject.parse(StringIO.new(gitmodule_sample2)).should ==
        ["tpope/vim-fugitive", "tpope/vim-haml", "sudo.vim", "endwise.vim", "thinca/vim-guicolorscheme", "yanktmp.vim", "YankRing.vim", "mru.vim", "quickrun", "Smooth-Scroll", "JavaScript-syntax", "php.vim", "tpope/vim-pathogen", "The-NERD-Commenter", "AutoComplPop", "eregex.vim", "Shougo/unite.vim", "thinca/vim-ref"]
      }
      context "when path doesn't start .vim directory" do
        it { subject.parse(StringIO.new(gitmodule_sample3)).should ==
          ["godlygeek/tabular", "altercation/vim-colors-solarized", "airblade/vim-rooter", "scrooloose/syntastic", "vimwiki"]
        }
      end
    end

    context ".gitmodule consists another submodule (it is irrelevant with vim)" do
      it { subject.parse(StringIO.new(gitmodule_sample4)).should == [] }
    end

    context "totally irrelevant with vim)" do
      it { subject.parse(StringIO.new(gitmodule_sample5)).should == [] }
    end
  end
end
