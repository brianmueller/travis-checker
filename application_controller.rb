require 'dotenv/load'
require 'bundler'
Bundler.require

require_relative 'models/model.rb'

class ApplicationController < Sinatra::Base

  get '/' do
    Octokit.auto_paginate = true
    user_repos = Octokit.repositories("bmuellerhstat")
    @user_repos_array = []
    user_repos.each do |repo|
      @user_repos_array << get_repo_name(repo[:html_url])
    end

    erb :index
  end
  
  get "/:repo" do
    @repo = params[:repo]
    @user_repo_url = "https://github.com/bmuellerhstat/#{@repo}"
    user_name = "bmuellerhstat"
    user_repo = get_repo_name(@user_repo_url)
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
    
    erb :grades
  end
  
  get "/:repo/close" do
    @repo = params[:repo]
    @user_repo_url = "https://github.com/bmuellerhstat/#{@repo}"
    user_name = "bmuellerhstat"
    user_repo = get_repo_name(@user_repo_url)
    user_name_repo = "#{user_name}/#{user_repo}"
    get_prs(user_name_repo)
    close_prs(user_name_repo)
    
    redirect '/'
  end
  
  get "/binding/pry" do
    binding.pry
  end
  
end
