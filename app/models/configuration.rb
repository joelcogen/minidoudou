class Configuration < ActiveRecord::Base
  belongs_to :base_rom
  has_many :configuration_packages
  has_many :packages, :through => :configuration_packages

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :base_rom_id
end

