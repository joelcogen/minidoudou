class Package < ActiveRecord::Base
  validates_presence_of :name, :version
  validates_uniqueness_of :version, :scope => :name

  def fullname
    "#{name} #{version}"
  end
end

