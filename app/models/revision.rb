class Revision < ActiveRecord::Base
  belongs_to :project

  def self.from_hash(hash)
    self.where("hash_code like ?", "#{hash}%").order(:updated_at).first
  end
end
