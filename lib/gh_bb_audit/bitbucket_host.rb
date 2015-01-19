module GhBbAudit
	class BitbucketHost
		def self.user(user_name)
			::GhBbAudit::Bitbucket::BitbucketUser.new(user_name)
		end

		def self.repo(user_name,repo_name)
			::GhBbAudit::Bitbucket::BitbucketRepo.new(user_name,repo_name)
		end

		def self.name
      "BITBUCKET"
    end
  end
end