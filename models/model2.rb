require 'github_api'

github = Github.new
github.repos.list user: 'bmuellerhstat'