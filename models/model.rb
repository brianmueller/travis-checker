require 'octokit'
require 'open-uri'
require 'json'

# Provide authentication credentials
Octokit.configure do |c|
  c.login = 'bmuellerhstat'
  c.password = ''
end

# Fetch the current user
# user = Octokit.user
# puts user[:public_repos]




# repo = open('https://api.github.com/repos/bmuellerhstat/01-methods-parameters-lab/pulls').read
# puts repo

# https://github.com/bmuellerhstat/01-methods-parameters-lab
# https://api.github.com/repos/bmuellerhstat/01-methods-parameters-lab/pulls

class Pr
    attr_accessor :username, :sha, :status
    
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

def get_status(name_repo,sha)
    Octokit.statuses(name_repo,sha).first.state
end

user_repo_url = "https://github.com/bmuellerhstat/01-methods-parameters-lab"
user_name = "bmuellerhstat"
user_repo = get_repo_name(user_repo_url)
user_name_repo = "#{user_name}/#{user_repo}"
# puts Octokit.pull_requests("#{user_name}/#{user_repo}",:state => 'open')

get_prs(user_name_repo)
Pr.all.each do |pr|
    # puts "#{user_repo_url_api}/statuses/#{pr.sha}"
    pr.status = get_status(user_name_repo,pr.sha)
    # puts pr.status
    puts "#{pr.username}: #{pr.status}"
end
