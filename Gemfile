source :rubygems

gemspec

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
