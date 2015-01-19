require 'semantic_logger' unless defined?(logger)
require 'github_api'
require 'bitbucket_rest_api'
require 'pry'

SemanticLogger.default_level = :info
SemanticLogger.add_appender('gh_bb_audit.log')

module GhBbAudit
  GEM_ROOT = File.join(File.dirname(__FILE__), '..')
end

require_relative './gh_bb_audit/github_host'
require_relative './gh_bb_audit/bitbucket_host'
require_relative './gh_bb_audit/github/github_user'
require_relative './gh_bb_audit/github/github_repo'
require_relative './gh_bb_audit/github/github_api'
require_relative './gh_bb_audit/bitbucket/bitbucket_user'
require_relative './gh_bb_audit/bitbucket/bitbucket_repo'
require_relative './gh_bb_audit/repo_scanner'
require_relative './gh_bb_audit/users_list'
require_relative './gh_bb_audit/keywords_list'
require_relative './gh_bb_audit/keyword_matcher'
require_relative './gh_bb_audit/output_writer'
require_relative './gh_bb_audit/version'
