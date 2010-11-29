class BaseRom < ActiveRecord::Base
  belongs_to :device
  has_many :apks, :dependent => :destroy
  has_many :base_rom_packages
  has_many :packages, :through => :base_rom_packages
  has_many :configurations

  validates_presence_of :name

  def find_apks
    # Unzip
    Dir.mkdir "files/tmp_#{id}"
    system "unzip -qo #{file_path} -d files/tmp_#{id}/"

    # Find APKs
    Dir.entries("files/tmp_#{id}/system/app/").each do |apkname|
      next unless apkname.end_with? '.apk'
      apk = Apk.new(:base_rom_id => id,
                    :name        => apkname.gsub('.apk', ''),
                    :location    => 'system',
                    :expert      => true)
      apk.save
    end
    if File.exist? "files/tmp_#{id}/data/app/"
      Dir.entries("files/tmp_#{id}/data/app/").each do |apkname|
        next unless apkname.end_with? '.apk'
        apk = Apk.new(:base_rom_id => id,
                      :name        => apkname.gsub('.apk', ''),
                      :location    => 'data',
                      :expert      => true)
        apk.save
      end
    end

    # Cleanup
    system "rm -rf files/tmp_#{id}"
  end
end

