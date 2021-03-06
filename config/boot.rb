require 'rubygems'

begin
  require 'bundler'
rescue
  Gem.path.push "/opt/local/lib/ruby/gems/1.8"
  Gem::Specification.find_by_name('bundler').activate
end

# Set up gems listed in the Gemfile.
gemfile = File.expand_path('../../Gemfile', __FILE__)
begin
  ENV['BUNDLE_GEMFILE'] = gemfile
  require 'bundler'
  Bundler.setup
rescue Bundler::GemNotFound => e
  STDERR.puts e.message
  STDERR.puts "Try running `bundle install`."
  exit!
end if File.exist?(gemfile)
