class BaseRom < ActiveRecord::Base
  belongs_to :device
  has_many :choices
  has_many :actions
end

