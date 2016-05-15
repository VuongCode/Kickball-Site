require "sinatra"
require 'json'
require_relative "models/player"
require_relative "models/team"

file = File.read('data/roster.json')
teams = JSON.parse(file)

team_names = []
positions = []

teams.each do |team, info|
  team_names << team
  info.each do |name, place|
    positions << name
  end
end

get '/' do
  erb :home
end

get '/teams' do
  erb :teams, locals: { team_names: team_names }
end

get '/teams/:team' do
  erb :team, locals: { each_team: params["team"], players: teams[params["team"]] }
end

get '/positions' do
  erb :positions, locals: { positions: positions }
end

get '/positions/:position' do
  players_pos = []
  teams.each do |team,player|
    players_pos << [player[params[:position]], team]
  end
  erb :position, locals: { positions: positions, position_player: players_pos, position: params[:position] }
end
