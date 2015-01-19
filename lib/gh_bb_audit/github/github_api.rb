require 'semantic_logger'

module GhBbAudit
  module Github
  	class GithubApi
      include SemanticLogger::Loggable

      def self.set_user_name_pwd(user_name, password)
        @user_name = user_name
        @password = password
      end

      def self.get_api_accesor
        if !!@user_name && !!@password
          logger.info("Using Authentication for Github with Username:: #{@user_name}")
          ::Github.new login: @user_name, password: @password
        else
          ::Github.new
        end
      end
      
  	end
  end
end