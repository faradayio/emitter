source :rubygems

gemspec

gem 'sniff', :path => ENV['LOCAL_SNIFF'] if ENV['LOCAL_SNIFF']
gem 'data_miner', :path => ENV['LOCAL_DATA_MINER'] if ENV['LOCAL_DATA_MINER']
gem 'earth', :path => ENV['LOCAL_EARTH'] if ENV['LOCAL_EARTH']

gem 'activerecord', '~>3'
gem 'bueller'
gem 'sniff', '>=0.11.0' unless ENV['LOCAL_SNIFF']

if RUBY_VERSION < "1.9"
  gem 'fastercsv'
end

platforms :ruby do
  gem 'sqlite3'
end

platforms :jruby do
  gem 'jruby-openssl'
  gem 'activerecord-jdbcsqlite3-adapter'
end
