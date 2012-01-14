class AddActiveStateToBot < ActiveRecord::Migration
  def change
    add_column :bots, :status, :string, default: "active"
  end
end