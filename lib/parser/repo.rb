module Parser
  class Repo
    def url_to_name(url)
      true
    end

    def name_to_url(name)
      "https://github.com/tpope/vim-fugitive"
      # true
    end
  end
end

# repo_parser = RepoParser.new
# p repo_parser.class
# repo_parser.name_to_url("url")

# p repo_parser.name_to_url("tpope/vim-fugitive")
