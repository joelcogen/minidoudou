class Package < ActiveRecord::Base
  has_many :configuration_packages
  has_many :configurations, :through => :configuration_packages

  validates_presence_of :name, :version
  validates_uniqueness_of :version, :scope => :name

  def fullname
    "#{name} #{version}"
  end
end

