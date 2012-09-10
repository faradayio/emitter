require 'bundler/setup'
require 'bundler/gem_tasks'

require 'bueller'
Bueller::Tasks.new

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new
task :default => :spec

require 'active_record'
load 'active_record/railties/databases.rake'

def config
  spec = ENV['DATABASE_URL']
  resolver = ActiveRecord::Base::ConnectionSpecification::Resolver.new spec, {}
  resolver.spec.config.stringify_keys
end

Rake::Task['db:load_config'].clear
Rake::Task['db:create'].clear
Rake::Task['db:drop'].clear

namespace :db do
  task :create do
    create_database(config)
  end
  task :drop do
    drop_database_and_rescue(config)
  end
  task :load_config do
    ActiveRecord::Base.establish_connection
    ActiveRecord::Base.connection
  end
end

