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

# 2019
Student.new("Donia","Abdelhalim","doniaa3710")
Student.new("Mohammed","Amin","mohammeda6429")
Student.new("Sebastian","Andrade","sebastiana7420")
Student.new("Anabel","Arbeeny","anabela0701")
Student.new("Yu Hang","Chen","yuhangc9321")
Student.new("Victoria","Feng","victoriaf6656")
Student.new("Kasper","Gacek","kasperg3971")
Student.new("Jeffrey","Guan","jeffreyg2240")
Student.new("Arieta","Haskaj","arietah8545")
Student.new("Xavier","Jiang","xavierj2216")
Student.new("Raquel","Joseph","raquelj6437")
Student.new("Yat Cho","Lau","yatchol6214")
Student.new("Jennifer","Liu","jenniferl4209")
Student.new("Hector","Marin","hectorm6066")
Student.new("Travis","Matos","travism7618")
Student.new("Sherzod","Mirsharipov","sherzodm8441")
Student.new("Eva","Noertoft","evan2304")
Student.new("Ahmad","Rabah","ahmadr9279")
Student.new("Amanda","Rivera","amandar8529")
Student.new("Danny","Wu","dannyw3292")
Student.new("Johnson","Wu","johnsonw6558")
Student.new("Xiurong","Yu","xiurongy3506")
Student.new("Shi","Zheng","dive0")
Student.new("Wei","Zheng","weiz9762")

# 2018
# Student.new("Amr","Almaz","amra0760")
# Student.new("Dakarai","Arnold","Dakaraia6799")
# Student.new("Leocadio","Bonilla","leocadiob7576")
# Student.new("Xinyan","Chen","xinyanc3694")
# Student.new("Zele","Dong","zeled3813")
# Student.new("Simeon","Karakatsiotis","simiek")
# Student.new("Abdelmonem Moam","Khedr","abdelk7344")
# Student.new("David","Kim","davidk7680")
# Student.new("Bianna","Krubitski","biannak6288")
# Student.new("Zhi Yin","Lai","zhiyinl5633")
# Student.new("Geoffrey","Lam","geoffreyl4412")
# Student.new("Andre","Lara","andrel6392")
# Student.new("Christy","Li","christy8059")
# Student.new("Gabriel","Makower","gabbym321")
# Student.new("Brittany","Misacango","brittanym3578")
# Student.new("Cheyenne","Nicaisse","cheyennen0503")
# Student.new("Alvin","Nieves","nievesalvin")
# Student.new("Ricardo","Penacastro","ricardop2476")
# Student.new("Shifa","Quddus","shifaq2337")
# Student.new("Kathleen","Saloma","kathleens0782")
# Student.new("Stephen","Wang","stephenw6888")
# Student.new("Kelly","Xiong Chen","kellyx1636")
# Student.new("David","Xiquevaldetano","davidx4697")