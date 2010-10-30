class BaseRomPackage < ActiveRecord::Base
  belongs_to :base_rom
  belongs_to :package
end

