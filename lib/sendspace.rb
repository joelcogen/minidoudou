# SendSpace uploader

def ss_upload filename
  index = `curl -q http://www.sendspace.com 2> /dev/null`

  # Extract upload URL
  form = index.scan(/<form [^>]*>/)[0]
  up_url = form.scan(/action=\"([^\"]*)\"/)[0]

  # Extract all hidden inputs
  data = []
  inputs = index.scan(/<input [^>]*>/)
  inputs.each do |input|
    name = input.scan(/name=\"([^\"]*)\"/)[0]
    value = input.scan(/value=\"([^\"]*)\"/)[0]
    data << "#{name}=#{value}" unless name.nil? || value.nil? || value==[""]
  end

  # Create curl command
  curl = "curl -q -F file_0=@#{filename} "
  curl << data.collect {|d| "-F #{d}"}.join(" ")
  curl << " #{up_url} 2> /dev/null"

  # Upload
  result = `#{curl}`
  url = result.scan(/<a href=\'(http:\/\/www.sendspace.com\/file\/[^\']*)\'>/)[0]

  # Return
  if url.nil? || url==[""]
    return nil
  else
    return url[0]
  end
end

