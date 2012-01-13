class Bot < ActiveRecord::Base
  has_attached_file :source
  validates_presence_of :source
  validates_presence_of :player_name
end
