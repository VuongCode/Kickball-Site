require_relative "../lib/team_data"

class Team
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def self.all
    JSON.parse(File.read('roster.json')).map { |team, players|
      Team.new(team) }
  end

  def players
    Player.all.select { |player| player.team_name == name }
  end
end
