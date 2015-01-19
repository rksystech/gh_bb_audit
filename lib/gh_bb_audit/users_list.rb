require 'csv'
module GhBbAudit
  class UsersList
  	def initialize(path_to_csv_file)
      @user_csv_file_path = path_to_csv_file
    end

    def all_users
      #Not rescuing here, as we should crash if we can not get userlist
      @users ||= ::CSV.read(@user_csv_file_path).flatten.uniq 
    end
  end
end