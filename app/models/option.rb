class Option < ActiveRecord::Base
  belongs_to :choice
  has_many :actions
end

