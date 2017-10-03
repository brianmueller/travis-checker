require 'octokit'
require 'open-uri'
require 'json'

Octokit.configure do |c|
  c.login = 'bmuellerhstat'
  c.password = ''
end

class Pr
    attr_accessor :username, :sha, :status, :timestamp
    
    @@all = []
    
    def self.all
        @@all
    end
    
    def initialize(username,sha)
        @username = username
        @sha = sha
        @@all << self
    end
end


def get_repo_name(url)
    /\/([^\/]+)$/.match(url)[1..-1][0]
end

def get_prs(name_repo)
    prs = Octokit.pull_requests(name_repo,:state => 'open')
    
    prs.each do |pr_element|
        Pr.new(pr_element.user.login,pr_element.head.sha)
    end
end

def get_info(pr,name_repo,sha)
    # Octokit.statuses(name_repo,sha).first.state
    update = Octokit.statuses(name_repo,sha).first
    pr.status = update.state
    pr.timestamp = update.created_at
end

# def get_timestamp(name_repo,sha)
    # Octokit.statuses(name_repo,sha).first.created_at
# end

user_repo_url = "https://github.com/bmuellerhstat/01-methods-parameters-lab"
user_name = "bmuellerhstat"
user_repo = get_repo_name(user_repo_url)
user_name_repo = "#{user_name}/#{user_repo}"

get_prs(user_name_repo)
Pr.all.each do |pr|
    get_info(pr,user_name_repo,pr.sha)
    puts "#{pr.username}: #{pr.status}: #{pr.timestamp}"
end