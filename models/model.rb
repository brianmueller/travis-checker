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
    
    def initialize(username,sha,url,num)
        @username = username
        @sha = sha
        @url = "#{url}/files"
        @num = num
        @@all << self
    end
    
    def close(name_repo)
        Octokit.close_pull_request(name_repo,@num)
    end
end


def get_repo_name(url)
    /\/([^\/]+)$/.match(url)[1..-1][0]
end

def get_prs(name_repo)
    prs = Octokit.pull_requests(name_repo,:state => 'open')
    
    prs.each do |pr_element|
        Pr.new(pr_element.user.login,pr_element.head.sha,pr_element.html_url,pr_element.number)
    end
end

def close_prs(name_repo)
    Pr.all.each do |pr|
        pr.close(name_repo)
    end
end

def get_info(pr,name_repo,sha)
    update = Octokit.statuses(name_repo,sha).first
    puts "pr: #{pr}; name_repo: #{name_repo}; sha: #{sha}"
    pr.status = update.state
    pr.timestamp = update.created_at
end


class Student
  attr_accessor :username, :sha, :url, :status, :timestamp, :first, :last
  
  @@all = []
    
    def self.all
        @@all
    end
    
    def initialize(first,last,username)
        @first = first
        @last = last
        @username = username
        # @status = false
        @@all << self
    end
end

Student.new("Amr","Almaz","amra0760")
Student.new("Dakarai","Arnold","dakaraia6799")
Student.new("Leocadio","Bonilla","leocadiob7576")
Student.new("Xinyan","Chen","xinyanc3694")
Student.new("Zele","Dong","zeled3813")
Student.new("Simeon","Karakatsiotis","simiek")
Student.new("Abdelmonem Moam","Khedr","abdelk7344")
Student.new("David","Kim","davidk7680")
Student.new("Bianna","Krubitski","biannak6288")
Student.new("Zhi Yin","Lai","zhiyinl5633")
Student.new("Geoffrey","Lam","geoffreyl4412")
Student.new("Andre","Lara","andrel6392")
Student.new("Christy","Li","christy8059")
Student.new("Gabriel","Makower","gabbym321")
Student.new("Brittany","Misacango","brittanym3578")
Student.new("Cheyenne","Nicaisse","cheyennen0503")
Student.new("Alvin","Nieves","nievesalvin")
Student.new("Ricardo","Penacastro","ricardop2476")
Student.new("Shifa","Quddus","shifaq2337")
Student.new("Kathleen","Saloma","kathleens0782")
Student.new("Stephen","Wang","stephenw6888")
Student.new("Kelly","Xiong Chen","kellyx1636")
Student.new("David","Xiquevaldetano","davidx4697")