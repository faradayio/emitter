gem 'sniff', :path => ENV['LOCAL_SNIFF'] if ENV['LOCAL_SNIFF']
gem 'data_miner', :path => ENV['LOCAL_DATA_MINER'] if ENV['LOCAL_DATA_MINER']
gem 'earth', :path => ENV['LOCAL_EARTH'] if ENV['LOCAL_EARTH']
gem 'mini_record', :path => ENV['LOCAL_MINI_RECORD'] if ENV['LOCAL_MINI_RECORD']

source :rubygems

gemspec :path => '.'

if RUBY_VERSION < "1.9"
  gem 'fastercsv'
end
