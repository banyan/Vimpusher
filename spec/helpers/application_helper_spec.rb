require 'spec_helper'

describe ApplicationHelper do
  describe '#complement_plugin_url' do

    specify { helper.complement_plugin_url("hoge").should == "https://github.com/vim-scripts/hoge" }
    specify { helper.complement_plugin_url("foo/bar").should == "https://github.com/foo/bar" }
    specify { helper.complement_plugin_url("git.wincent.com/command-t.git").should == "http://git.wincent.com/command-t.git" }
    specify { helper.complement_plugin_url("svn.macports.org/repository/macports/contrib/mpvim").should == "http://svn.macports.org/repository/macports/contrib/mpvim" }
    specify { helper.complement_plugin_url("bitbucket.org/ns9tks/vim-fuzzyfinder").should == "http://bitbucket.org/ns9tks/vim-fuzzyfinder" } # butbucket redirect to https

  end
end
