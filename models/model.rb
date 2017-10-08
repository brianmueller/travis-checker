require 'octokit'
require 'open-uri'
require 'json'

Octokit.configure do |c|
  c.login = ENV["LOGIN"]
  c.password = ENV["PASSWORD"]
end

class Pr
    attr_accessor :username, :sha, :url, :status, :timestamp
    
    @@all = []
    
    def self.all
        @@all
    end
    
    def initialize(username,sha,url)
        @username = username
        @sha = sha
        @url = "#{url}/files"
        @@all << self
    end
end


def get_repo_name(url)
    /\/([^\/]+)$/.match(url)[1..-1][0]
end

def get_prs(name_repo)
    prs = Octokit.pull_requests(name_repo,:state => 'open')
    
    prs.each do |pr_element|
        Pr.new(pr_element.user.login,pr_element.head.sha,pr_element.html_url)
    end
end

def get_info(pr,name_repo,sha)
    update = Octokit.statuses(name_repo,sha).first
    pr.status = update.state
    pr.timestamp = update.created_at
end

