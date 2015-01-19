require 'csv'
module GhBbAudit
  class KeywordsList
  	def initialize(path_to_csv_file)
      @keywords_csv_file_path = path_to_csv_file
    end

    def all_keywords
      #Not rescuing here, as we should crash if we can not get keywords
      @keywords ||= ::CSV.read(@keywords_csv_file_path).flatten.uniq 
    end
  end
end