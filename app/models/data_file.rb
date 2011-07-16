require 'ftools'

class DataFile < ActiveRecord::Base
  def self.store(upload)
    return false if upload.nil?

    name = upload['datafile'].original_filename
    directory = "files"

    # create the file path
    path = File.join(directory, name)

    # write the file
    if File.exist? path
      num = 1
      while File.exist? "#{path}_#{num.to_s}"
        num += 1
      end
      path = "#{path}_#{num.to_s}"
    end
    
    begin
      File.cp upload['datafile'].path, path
      path
    rescue
      false
    end
  end
end