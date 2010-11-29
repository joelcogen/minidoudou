class Change < ActiveRecord::Base
  belongs_to :configuration
  belongs_to :apk

  def explain
    verb = destination=='remove' ? 'Remove' : 'Move'
    verb = 'Add' if apk.base_rom.nil?

    dest = destination=='remove' ? '' : 'to ' + destination

    "#{verb} <strong>#{apk.name}</strong> #{dest}"
  end
end

