require 'semantic_logger'

module GhBbAudit
  module Github
    class GithubRepo
      include SemanticLogger::Loggable
      def initialize(user_name,repo_name)
        @user_name = user_name
        @repo_name = repo_name
      end

      def get_all_file_paths
        return [] if ( !@user_name || !@repo_name )
        @paths ||= begin
          get_tree.each.inject([]) do |result, file|
            result << file.path
            result
          end
        rescue StandardError => e
          []
        end 
        @paths
      end

      private
      def get_tree
        all_commits = begin 
          GithubApi.get_api_accesor.repos.commits.all  @user_name, @repo_name
          rescue StandardError => e
            logger.error "GITHUB:: Error in fetching Commits for Repo::#{@repo_name} for User:: #{@user_name} ", error: e.inspect
            return nil
          end
        last_commit_sha = all_commits[0].sha rescue nil
        if !last_commit_sha
          logger.info("GITHUB:: Could not find any commit for Github Repo:: #{@repo_name} for User:: #{@user_name}")
          return nil
        end
        @github_tree ||= GithubApi.get_api_accesor.git_data.trees.get @user_name, @repo_name, last_commit_sha , 'recursive' => true rescue nil
        if !@github_tree
          logger.error("GITHUB:: Could not fetch tree for Repo:: #{@repo_name} for User:: #{@user_name}")
          return 
        end
        @github_tree.tree
      end

    end
  end
end