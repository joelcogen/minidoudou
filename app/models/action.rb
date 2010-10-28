class Action < ActiveRecord::Base
  belongs_to :action_type
  belongs_to :base_rom
  belongs_to :option
end

