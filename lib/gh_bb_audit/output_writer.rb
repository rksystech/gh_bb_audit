module GhBbAudit
  class OutputWriter
    def initialize(path_to_file)
    	@fhandle = File.open(path_to_file, 'w+') 
    end

    def repo_name_matched(repo_name,user_name,repo_source)
      @fhandle.puts("")
      @fhandle.puts("#{repo_source}:: The name of REPO:#{repo_name} for USER:#{user_name} matches keywords")
      @fhandle.puts("")
    end

    def file_paths_matched_in_repo(file_path_array,repo_name,user_name,repo_source)
      @fhandle.puts("")
      @fhandle.puts("#{repo_source}:: For the REPO:#{repo_name} for USER:#{user_name}, the following file paths matched")
      file_path_array.each do |file_path|
        @fhandle.puts("---- #{file_path}")
      end
      @fhandle.puts("")
    end

    def close
      @fhandle.close
    end
  end
end
