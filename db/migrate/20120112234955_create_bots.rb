class CreateBots < ActiveRecord::Migration
  def change
    create_table :bots do |t|
      t.string :player_name
      t.string :bot_name

      t.timestamps
    end
  end
end
