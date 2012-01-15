class Match < ActiveRecord::Base

  belongs_to :bot_one, :class_name => "Bot", foreign_key: :bot_1_id
  belongs_to :bot_two, class_name: "Bot", foreign_key: :bot_2_id
  belongs_to :winner, :class_name => "Bot", :foreign_key => :winner_id

  validates_presence_of :bot_1_id
  validates_presence_of :bot_2_id

  def run!
    update_attribute :status, "running"
    result = Battle.fight!(bots)
    json_data = JSON.parse(result)
    json_data["playernames"] = bots.map{|b| b.player_name }
    if json_data["rank"].uniq.length == 1
      # Draw
      winner = nil
      bots.first.drew_against!(bots.last)
    else
      winner = bots.sort{|a, b| json_data["rank"][bots.index(a)] <=> json_data["rank"][bots.index(b)] }.first
      winner.won_against!(bots.detect{|b| b != winner})
    end

    update_attributes replay: json_data.to_json, status: "finished", winner_id: winner.try(:id)
  rescue Exception => e
    puts e.to_s
    update_attributes status: "failed", replay: e.to_s
  end

  def bots
    [bot_one, bot_two].compact
  end

  def bot_names
    bots.map{|b| "#{b.player_name} (#{b.bot_name})" }.join(", ")
  end
end
