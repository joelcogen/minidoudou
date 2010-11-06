class ConfigurationPackage < ActiveRecord::Base
  belongs_to :configuration
  belongs_to :package
end

