require_relative "../lib/team_data"

class Player
  attr_reader :name, :position, :team_name

  def initialize(name, position, team_name)
    @name = name
    @position = position
    @team_name = team_name
  end

  def self.all
    JSON.parse(File.read('roster.json')).map { |team, players|
      players.map { |position, name| Player.new(name, position, team) }
    }.flatten
  end
end
