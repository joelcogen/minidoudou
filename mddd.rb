#!/usr/bin/ruby
# MDDd : Minidoudou daemon

require 'rubygems'
require 'active_record'
require 'yaml'

# Logging
def timestamp
  Time.new.strftime("%Y-%m-%d %H:%M:%S")
end
def log(message)
  puts "#{timestamp} | #{message}"
end
def logerror(message)
  puts "#{timestamp} !!! #{message}"
end

log "=== MDDd start ==="
begin

# Load DB config
log "Loading DB configuration"
dbcfg = YAML.load_file("config/database.yml")["production"]
dbcfg["database"] = "#{dbcfg["database"]}" if dbcfg["adapter"]=="sqlite3"
log "Connecting to database"
ActiveRecord::Base.establish_connection(dbcfg)

# Include all models from panel
log "Loading models"
Dir.new("app/models").each do |model|
  model_path = "app/models/#{model}"
  require "#{model_path}" if File.file?(model_path)
end

successes = 0
failures = 0

# Loop on all pending configurations
Configuration.all.select {|c| c.file_path.nil?}.each do |config|
  begin

  base_rom = config.base_rom
  device = base_rom.device
  log "Creating '#{config.name}' from '#{base_rom.name}' for '#{device.name}'"

  log "Extracting '#{base_rom.name}' from '#{base_rom.file_path}'"
  system "unzip -qo #{base_rom.file_path} -d files/tmp/" or raise "Can't unzip '#{base_rom.file_path}'"

  log "Removing stuff"
  base_rom.to_remove.each_line do |file|
    system "rm files/tmp/#{file.strip}" or raise "Can't remove '#{file.strip}'"
  end

  us_path = "files/tmp/META-INF/com/google/android/updater-script"
  us = "ui_print(\" \");\n"
  us << "ui_print(\"This ROM was created using Minidoudou [minidoudou.joelcogen.com]\");\n"
  us << "ui_print(\"Device: #{device.name}\");\n"
  us << "ui_print(\"Base ROM: #{base_rom.name}\");\n"
  us << "ui_print(\"Configuration: #{config.name}\");\n"
  us << "ui_print(\" \");\n"
  us << File.read(us_path) or raise "Can't read updater_script from base ROM"
  system "rm #{us_path}" or raise "Can't remove updater_script from base ROM"

  config.packages.select {|p| !p.apk}.each do |package|
    log "Extracting package '#{package.fullname}' from '#{package.file_path}'"
    system "unzip -qo #{package.file_path} -d files/tmp/" or raise "Can't unzip '#{package.file_path}'"

    if File.exist? us_path
      us << "\n" + File.read(us_path) or raise "Can't read updater_script from package"
      system "rm #{us_path}" or raise "Can't remove updater_script from package"
    end
  end

  File.open(us_path, "w") { |f| f.puts us }
  config.packages.select {|p| p.apk}.each do |package|
    # Check /system usage
    system_full = false
    system_used = `du -s files/tmp/system | awk '{print $1}'`.to_i
    package_size = `du -s #{package.file_path} | awk '{print $1}'`.to_i
    if system_used+package_size > device.system_size*1024
      system_full = true
    end

    log "Adding APK '#{package.fullname}' from '#{package.file_path}'#{system_full ? " (/data)" : ""}"
    system "cp #{package.file_path} files/tmp/#{system_full ? "data" : "system"}/app/" or raise "Can't copy '#{package.file_path}'"
  end

  zipname = "MDD_#{device.name.split(" ").join("_")}_#{base_rom.name.split(" ").join("_")}_#{config.name.split(" ").join("_")}.zip"
  log "Zipping as '#{zipname}'"
  system "cd files/tmp; zip -rq #{zipname}.unsigned *" or raise "Can't zip '#{zipname}'"

  log "Signing"
  system "java -cp testsign.jar testsign files/tmp/#{zipname}.unsigned public/download/#{zipname}" or raise "Can't sign 'files/tmp/#{zipname}.unsigned' as 'public/download/#{zipname}'"

  system "rm -rf files/tmp/*" or raise "Can't empty tmp"

  config.file_path = "download/#{zipname}"
  config.save or raise "Can't save configuration #{config.id} to DB"

  successes += 1

  rescue Exception => e
    logerror e
    logerror "Failed to build '#{config.name}' from '#{base_rom.name}' for '#{device.name}'"
    failures += 1
  end
end

log "=== MDDd haz finish (#{successes} great successes, #{failures} fail) ==="

rescue Exception => e
  logerror e
  logerror "=== MDDd haz failed BIG TIME ==="
ensure
  system "rm -rf files/tmp/*"
end

