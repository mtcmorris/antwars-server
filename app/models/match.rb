class Match < ActiveRecord::Base

  belongs_to :bot_one, :class_name => "Bot", foreign_key: :bot_1_id
  belongs_to :bot_two, class_name: "Bot", foreign_key: :bot_2_id
  belongs_to :winner, :class_name => "Bot", :foreign_key => "winner"

  validates_presence_of :bot_1_id
  validates_presence_of :bot_2_id

  def run!
    update_attribute :status, "running"
    result = Battle.fight!(bots)
    json_data = JSON.parse(result)
    json_data["playernames"] = bots.map{|b| b.player_name }
    update_attributes replay: json_data.to_json, status: "finished"
  end

  def bots
    [bot_one, bot_two].compact
  end
end
