require 'semantic_logger'

module GhBbAudit
  module Github
    class GithubUser
      include SemanticLogger::Loggable

    	def initialize(user_name)
    	  @user_name = user_name
      end

      def public_repos
        @public_repos ||= begin 
        	(GithubApi.get_api_accesor.repos.list user: @user_name).collect(&:name)
  		rescue StandardError => e
  		  logger.error "GITHUB:: Error in fetching repos for User:: #{@user_name} ", error: e.inspect
  		  []
  		end
      end
    end
  end
end