require 'semantic_logger'

module GhBbAudit
  module Bitbucket
    class BitbucketRepo
      include SemanticLogger::Loggable

      def initialize(user_name,repo_name)
        @user_name = user_name
        @repo_name = repo_name
      end

      def get_all_file_paths
        return [] if ( !@user_name || !@repo_name )
        begin
          bb_client = ::BitBucket.new {|config| config.endpoint = 'https://bitbucket.org/api/1.0'} 
          @paths ||= get_files_in_dir('',bb_client)
        rescue StandardError => e
          logger.error "BITBUCKET:: Error in geting files for Bitbucket Repo:: #{@repo_name} for User:: #{@user_name}", error: e.inspect
        end
        @paths
      end

      private

      def get_files_in_dir(path,bb_client)
        bb_response = bb_client.repos.sources.get @user_name, @repo_name, 'master', path
        files = bb_response["files"].collect(&:path) rescue []
        files_in_directory = begin
          bb_response["directories"].each.inject([]) do |result,dir_name|
            result << get_files_in_dir(path + '/' + dir_name, bb_client)
          end
        rescue StandardError => e
          logger.error "BITBUCKET:: Error in geting files for Bitbucket Repo:: #{@repo_name} for User:: #{@user_name} and path:: #{path}", error: e.inspect
          []
        end
        return (files + files_in_directory).flatten
      end

    end
  end
end