class DataFile < ActiveRecord::Base
  def self.store(upload)
    return false if upload.nil?

    name = upload['datafile'].original_filename
    directory = "files"

    # create the file path
    path = File.join(directory, name)

    # write the file
    if File.exist? path
      false
    else
      File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
      path
    end
  end
end

