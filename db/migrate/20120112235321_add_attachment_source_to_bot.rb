class AddAttachmentSourceToBot < ActiveRecord::Migration
  def self.up
    add_column :bots, :source_file_name, :string
    add_column :bots, :source_content_type, :string
    add_column :bots, :source_file_size, :integer
    add_column :bots, :source_updated_at, :datetime
  end

  def self.down
    remove_column :bots, :source_file_name
    remove_column :bots, :source_content_type
    remove_column :bots, :source_file_size
    remove_column :bots, :source_updated_at
  end
end
