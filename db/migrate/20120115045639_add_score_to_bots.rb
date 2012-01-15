class AddScoreToBots < ActiveRecord::Migration
  def change
    add_column :bots, :wins, :integer, :default => 0
    add_column :bots, :losses, :integer, :default => 0
    add_column :bots, :draws, :integer, :default => 0
    add_column :bots, :score, :decimal, :default => 1000.0
  end
end