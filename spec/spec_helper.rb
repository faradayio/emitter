require 'bundler/setup'

require 'emitter'

ENV['DATABASE_URL'] ||= "mysql2://root:password@localhost/test_emitter"
require 'active_record'
ActiveRecord::Base.establish_connection
ActiveRecord::Base.connection
