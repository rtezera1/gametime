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

 def add_all(array)
  array.inject { |subtotal, price| subtotal + price}
end

 @scoreboard={}
 scores.each do |score|
    @scoreboard["#{score[:home_team]}"]=[[0],[0]]
    @scoreboard["#{score[:away_team]}"]=[[0],[0]]
 end
scores.each do |score|
  if score[:home_score]>score[:away_score]
      @scoreboard["#{score[:home_team]}"][0]<<1
      @scoreboard["#{score[:away_team]}"][1]<<1
  else
      @scoreboard["#{score[:home_team]}"][1]<<1
      @scoreboard["#{score[:away_team]}"][0]<<1
  end
end
  i=1
  @scoreboard.each do |key, value|
    @ranking<<"#{i} #{key} wins:#{add_all(value[0])} loses:#{add_all(value[1])}"
   i+=1
  end
    @ranking
erb :teams
end
@team=[]
get '/leaderboard/:teams' do
  @scoreboard.each do |key, value|
    if key==params[:team]
      @teams<<"#{key} #{value}"
    end
  end
  @teams=params[:team]



erb :teams
end






