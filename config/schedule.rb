set :output, "log/mddd.log"

every 5.minutes do
  rake "mdd:generate"
end