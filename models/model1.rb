require 'open-uri'
require 'json'

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


def get_repo_url_api(url)
    url.insert(8,"api.").insert(23,"repos/")
end

def get_prs(url)
    prs_json = open("#{url}/pulls").read
    prs_hash = JSON.parse(prs_json)
    
    prs_hash.each do |pr_element|
        Pr.new(pr_element["user"]["login"],pr_element["head"]["sha"],pr_element["html_url"])
    end
end

def get_status(url,sha)
    statuses_json = open("#{url}/statuses/#{sha}").read
    statuses_hash = JSON.parse(statuses_json)
    statuses_hash[0]["state"]
end

user_repo_url = "https://github.com/bmuellerhstat/01-methods-parameters-lab"
user_repo_url_api = get_repo_url_api(user_repo_url)
# puts user_repo_url_api

get_prs(user_repo_url_api)
Pr.all.each do |pr|
    # puts "#{user_repo_url_api}/statuses/#{pr.sha}"
    pr.status = get_status(user_repo_url_api,pr.sha)
    # puts pr.status
    puts "#{pr.username}: #{pr.status}"
end
