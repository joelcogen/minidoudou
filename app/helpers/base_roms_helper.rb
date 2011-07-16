module BaseRomsHelper
  def uploader_name_for base_rom
    base_rom.uploader.present? ? base_rom.uploader.name : "Unknown"
  end
end
