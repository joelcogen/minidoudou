class BaseRom < ActiveRecord::Base
  belongs_to :device
  has_many :base_rom_packages
  has_many :packages, :through => :base_rom_package
end

