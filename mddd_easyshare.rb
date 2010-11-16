# Minidoudou EasyShare functions

# mddd_easyshare_config.rb should define @es_user and @es_pass
require 'mddd_easyshare_config'

def login
  html = `curl -q -H "Accept: application/atom+xml" --data "_method=POST&login=#{@es_user}&password=#{@es_pass}" http://api.easy-share.com/apikeys`
  @es_apikey = html.split("<content type=\"text\">").last.split("</content>").first
  !@es_apikey=='Invalid login or password'
end

def upload file
  login or raise "Error connecting to EasyShare"
  html = `curl -q -F upload=@#{file} -H "Accept: application/atom+xml" -H "Authorization: #{@es_apikey}" http://api.easy-share.com/files`
  link = html.split("<link title=\"download_link\" href=\"").last.split("\"").first
  link
end

