require 'sinatra'
require 'shotgun'
require 'pry'



scores=[
  {
    home_team: "Patriots",
    away_team: "Broncos",
    home_score: 7,
    away_score: 3
  },
  {
    home_team: "Broncos",
    away_team: "Colts",
    home_score: 3,
    away_score: 0
  },
  {
    home_team: "Patriots",
    away_team: "Colts",
    home_score: 11,
    away_score: 7
  },
  {
    home_team: "Steelers",
    away_team: "Patriots",
    home_score: 7,
    away_score: 21
  }
]


get '/leaderboard' do

   @scoreboard={}
   scores.each do |score|
      @scoreboard["#{score[:home_team]}"]=[0,0]
      @scoreboard["#{score[:away_team]}"]=[0,0]
   end
  scores.each do |score|
    if score[:home_score]>score[:away_score]
        @scoreboard["#{score[:home_team]}"][0]+=1
        @scoreboard["#{score[:away_team]}"][1]+=1
    else
        @scoreboard["#{score[:home_team]}"][1]+=1
        @scoreboard["#{score[:away_team]}"][0]+=1
    end
  end

    @x=@scoreboard.sort_by{|k, v| v[0]} #rank based on wins
    @y=@scoreboard.sort_by{|k, v| v[1]} #rank based on loses
erb :teams
end






