require 'semantic_logger'

module GhBbAudit
  module Bitbucket
    class BitbucketUser
      include SemanticLogger::Loggable

    	def initialize(user_name)
    	  @user_name = user_name
      end

      def public_repos
        @public_repos ||= begin 
            response = ::BitBucket.new {|config| config.endpoint   = 'https://bitbucket.org/api/2.0'}.repos.public @user_name 
            response["values"].collect(&:name)
    		rescue StandardError => e
    		  logger.error "BITBUCKET:: Error in fetching repos for Bitbucket User:: #{@user_name} ", error: e.inspect
    		  []
    		end
      end
    end
  end
end