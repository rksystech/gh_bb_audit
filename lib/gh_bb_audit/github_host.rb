module GhBbAudit
	class GithubHost
    def self.user(user_name)
      ::GhBbAudit::Github::GithubUser.new(user_name)
    end

    def self.repo(user_name,repo_name)
      ::GhBbAudit::Github::GithubRepo.new(user_name,repo_name)
    end

    def self.name
      "GITHUB"
    end
  end
end