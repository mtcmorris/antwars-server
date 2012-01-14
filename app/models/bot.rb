class Bot < ActiveRecord::Base
  has_attached_file :source
  validates_presence_of :source
  validates_presence_of :player_name

  validates_attachment_content_type :source, content_type: ['application/zip', 'application/x-zip', 'application/x-zip-compressed']

  def self.active
    where(status: "active")
  end
end
