#!/usr/bin/env ruby

require_relative '../lib/gh_bb_audit'
require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: gh_bb_audit.rb -u <path_to_user_csv_file> -k <path_tpkeywords_csv_file> -o <path_to_output_file> -n <github_user> -p <github_password>"

  opts.on("-users", "-u") do |v|
    options[:user_file_path] = v
  end

  opts.on("-keywords", "-k") do |v|
    options[:keywords_file_path] = v
  end

  opts.on("-output", "-o") do |v|
    options[:output_file_path] = v
  end
  
  opts.on("-github_user", "-n") do |v|
    options[:github_user] = v
  end

  opts.on("-github_password", "-p") do |v|
    options[:github_password] = v
  end
end.parse!

::GhBbAudit::RepoScanner.new(options).start_scan
