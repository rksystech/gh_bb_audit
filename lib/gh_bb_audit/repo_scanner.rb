require 'semantic_logger'
module GhBbAudit
	class RepoScanner
    include SemanticLogger::Loggable

    def initialize(options)
      @user_csv_path = options[:user_file_path]
      @keyword_csv_path = options[:keywords_file_path]
      @output_file_path = options[:output_file_path]
      ::GhBbAudit::Github::GithubApi.set_user_name_pwd(options[:github_user], options[:github_password]) if options.include?(:github_user) && options.include?(:github_password)

      @matcher = ::GhBbAudit::KeywordMatcher.new(::GhBbAudit::KeywordsList.new(@keyword_csv_path).all_keywords)
      @users = ::GhBbAudit::UsersList.new(@user_csv_path).all_users
      @output_writer = ::GhBbAudit::OutputWriter.new(@output_file_path)
    end

    def start_scan
      begin
        [::GhBbAudit::GithubHost, ::GhBbAudit::BitbucketHost].each do |repo_source|
          @users.each do |user|
            logger.info("#{repo_source.name}:: Scanning for User: #{user}")
            repo_source.user(user).public_repos.each do |public_repo|
              logger.info("#{repo_source.name}:: Scanning Repo: #{public_repo} for User: #{user}")
              if @matcher.repo_contains_keyword?([public_repo])
                @output_writer.repo_name_matched(public_repo,user, repo_source.name)
              end
              
              file_paths = repo_source.repo(user,public_repo).get_all_file_paths

              if @matcher.repo_contains_keyword?(file_paths)
                @output_writer.file_paths_matched_in_repo(@matcher.matched_file_paths(file_paths),public_repo, user, repo_source.name)
              end
            end
          end
        end
        
      rescue StandardError => e
        logger.error "Error in scanning", error: e.inspect
      ensure
        @output_writer.close
      end
    end

	end

end
