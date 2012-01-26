require 'fileutils'
require 'lib/sendspace'

namespace :mdd do
  desc "Generate configurations"
  task :generate => :environment do
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
      successes = 0
      failures = 0

      # Loop on all pending configurations
      Configuration.all.select {|c| c.file_path.nil?}.each do |config|
      begin
        # Cleanup first to make sure we start nice
        system "rm -rf files/tmp/*"

        # Extract data
        base_rom = config.base_rom
        device = base_rom.device
        log "Creating '#{config.name}' from '#{base_rom.name}' for '#{device.name}'"

        # Extract Base ROM
        log "Extracting '#{base_rom.name}' from '#{base_rom.file_path}'"
        system "unzip -qo #{base_rom.file_path} -d files/tmp/" or raise "Can't unzip '#{base_rom.file_path}'"

        # Add some prints to updater-script
        us_path = "files/tmp/META-INF/com/google/android/updater-script"
        us = "ui_print(\" \");\n"
        us << "ui_print(\"This ROM was created using Minidoudou [minidoudou.joelcogen.com]\");\n"
        us << "ui_print(\"Device: #{device.name}\");\n"
        us << "ui_print(\"Base ROM: #{base_rom.name}\");\n"
        us << "ui_print(\"Configuration: #{config.name}\");\n"
        us << "ui_print(\" \");\n"
        us << File.read(us_path) or raise "Can't read updater_script from base ROM"
        system "rm #{us_path}" or raise "Can't remove updater_script from base ROM"
        # Add /data/app extraction to updater-script
        us << "mount(\"MTD\", \"userdata\", \"/data\");"
        us << "package_extract_dir(\"data\", \"/data\");"
        us << "set_perm(1000, 1000, 0771, \"/data/app\");"
        us << "unmount(\"/data\");"

        # Extract packages
        config.packages.each do |package|
          log "Extracting package '#{package.fullname}' from '#{package.file_path}'"
          system "unzip -qo #{package.file_path} -d files/tmp/" or raise "Can't unzip '#{package.file_path}'"

          # Append updater-script
          if File.exist? us_path
            us << "\n" + File.read(us_path) or raise "Can't read updater_script from package"
            system "rm #{us_path}" or raise "Can't remove updater_script from package"
          end
        end

        # Write final updater-script
        File.open(us_path, "w") { |f| f.puts us }

        # Make sure /data/app exists
        FileUtils.mkpath "files/tmp/data/app" or raise "Can't create /data/app"

        # Apply changes
        config.changes.sort_by { |c| c.destination=='remove' ? 0 : ( c.apk.base_rom.nil? ? 2 : 1 ) }.each do |change|
          log change.explain.gsub(/<\/?strong>/, '')
          if change.destination == 'remove'
            # Removal
            File.unlink "files/tmp/#{change.apk.location}/app/#{change.apk.name}.apk" \
              or raise "Can't remove 'files/tmp/#{change.apk.location}/app/#{change.apk.name}.apk'"
          elsif change.apk.base_rom.nil?
            # Addition
            FileUtils.copy change.apk.location, "files/tmp/#{change.destination}/app/#{change.apk.name}.apk" \
              or raise "Can't move '#{change.apk.location}' to 'files/tmp/#{change.destination}/app/#{change.apk.name}.apk'"
          else
            # Move
            FileUtils.move "files/tmp/#{change.apk.location}/app/#{change.apk.name}.apk", "files/tmp/#{change.destination}/app/#{change.apk.name}.apk" \
              or raise "Can't move 'files/tmp/#{change.apk.location}/app/#{change.apk.name}.apk' to 'files/tmp/#{change.destination}/app/#{change.apk.name}.apk'" \
          end
        end

        # Check /system usage
        system_used = `du -sm files/tmp/system | awk '{print $1}'`.to_i
        while system_used >= device.system_size
          # Move a random package to /data
          apk = Dir.entries('files/tmp/system/app/').select{|e| e.end_with?('.apk')}.first
          raise "System full: no more APKs to move" if apk.nil?
          log "System full: moving #{apk} to data"
          FileUtils.move "files/tmp/system/app/#{apk}", "files/tmp/data/app/#{apk}" \
            or raise "Can't move #{apk} from system to data"
          # Recompute
          system_used = `du -s files/tmp/system | awk '{print $1}'`.to_i
        end

        # Zip the result
        zipname = "MDD_#{device.name}_#{base_rom.name}_#{config.name}.zip".gsub(' ', '_').gsub(/[^[:alnum:]_.]/, '')
        log "Zipping as '#{zipname}'"
        system "cd files/tmp; zip -rq #{zipname}.unsigned *" or raise "Can't zip '#{zipname}'"

        # Sign
        log "Signing"
        system "java -cp testsign.jar testsign files/tmp/#{zipname}.unsigned files/tmp/#{zipname}" or raise "Can't sign 'files/tmp/#{zipname}.unsigned' as 'files/tmp/#{zipname}'"

        # Upload to SendSpace
        log "Uploading"
        file_path = SendSpace.upload "files/tmp/#{zipname}"

        # Cleanup
        system "rm -rf files/tmp/*" or raise "Can't empty tmp"

        # Write new data
        config.file_path = file_path
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
  end
end
