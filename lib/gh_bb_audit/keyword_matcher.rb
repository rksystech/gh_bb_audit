module GhBbAudit
  class KeywordMatcher

    def initialize(keywords)
      @keyword_regex = Regexp.union(keywords)
    end

    def repo_contains_keyword?(repo_file_paths)
      !(matched_file_paths(repo_file_paths).empty?)
    end

    def matched_file_paths(repo_file_paths)
    	repo_file_paths.select { |files|  @keyword_regex.match(files) }
    end
  end
end
