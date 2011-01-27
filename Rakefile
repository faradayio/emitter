require 'bundler'
Bundler::GemHelper.install_tasks

require 'rake'

begin
  require 'rake/rdoctask'
  Rake::RDocTask.new do |rdoc|
    rdoc.rdoc_dir = 'rdoc'
    rdoc.title = 'emitter'
    rdoc.options << '--line-numbers' << '--inline-source'
    rdoc.rdoc_files.include('README*')
    rdoc.rdoc_files.include('lib/**/*.rb')
  end
rescue LoadError
   puts "Rdoc is not available"
end

require 'sniff/rake_tasks'
Sniff::RakeTasks.define_tasks do |s|
  s.cucumber = false
  s.rspec = true
end
