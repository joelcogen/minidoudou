class Apk < ActiveRecord::Base
  belongs_to :base_rom

  validates_presence_of :name
end

