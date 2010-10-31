class Device < ActiveRecord::Base
  has_many :base_roms

  validates_presence_of :name
end

