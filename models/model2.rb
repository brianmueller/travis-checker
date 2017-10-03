require 'github_api'

github = Github.new client_id: '9fe2428835eeb0376123', client_secret: 'dee6fe537a52f735f91115cce91f2a811de81dcc'
github.authorize_url redirect_uri: 'http://localhost', scope: 'repo'

puts github.repos.list user: 'bmuellerhstat'
# puts github.repos.list {user: 'bmuellerhstat', repo: '01-methods-parameters-lab'}