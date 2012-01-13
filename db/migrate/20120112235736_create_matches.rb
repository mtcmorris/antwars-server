class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :bot_1_id
      t.integer :bot_2_id
      t.string :status, default: "pending"
      t.integer :winner_id
      t.text :replay

      t.timestamps
    end
  end
end
