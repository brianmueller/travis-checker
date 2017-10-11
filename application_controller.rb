require 'dotenv/load'
require 'bundler'
Bundler.require

require_relative 'models/model.rb'

class ApplicationController < Sinatra::Base

  get '/' do
    
    user_repo_url = "https://github.com/bmuellerhstat/01-methods-parameters-lab"
    user_name = "bmuellerhstat"
    user_repo = get_repo_name(user_repo_url)
    user_name_repo = "#{user_name}/#{user_repo}"
    
    get_prs(user_name_repo)
    Pr.all.each do |pr|
        get_info(pr,user_name_repo,pr.sha)
    end
    
    Student.all.sort_by{|student| student.first}
    
    Student.all.each do |student|
      matching_pr = Pr.all.find{|pr| pr.username == student.username}
      unless matching_pr.nil?
        student.sha = matching_pr.sha
        student.url = matching_pr.url
        student.status = matching_pr.status
        student.timestamp = matching_pr.timestamp
      end
    end
    
    Student.all.sort_by{|student| student.last}
    
    
    
    erb :index
  end
  
  get "/:repo" do
    user_repo_url = "https://github.com/bmuellerhstat/#{params[:repo]}"
    user_name = "bmuellerhstat"
    user_repo = get_repo_name(user_repo_url)
    user_name_repo = "#{user_name}/#{user_repo}"
    
    get_prs(user_name_repo)
    Pr.all.each do |pr|
        get_info(pr,user_name_repo,pr.sha)
    end
    
    Student.all.sort_by{|student| student.first}
    
    Student.all.each do |student|
      matching_pr = Pr.all.find{|pr| pr.username == student.username}
      unless matching_pr.nil?
        student.sha = matching_pr.sha
        student.url = matching_pr.url
        student.status = matching_pr.status
        student.timestamp = matching_pr.timestamp
      end
    end
    
    Student.all.sort_by{|student| student.last}
    
    
    
    erb :index
  end
  
end
