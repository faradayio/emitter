require 'rubygems'
require 'rake/rdoctask'
require 'jeweler'

if ENV['BUNDLER'] == 'true'
  begin
    require 'bundler'
    Bundler.setup
  rescue LoadError
    puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
  end
end

Jeweler::Tasks.new do |gem|
  gem.name = %q{emitter}
  gem.summary = %q{The mother of all carbon models}
  gem.description = %q{A software model in Ruby for the greenhouse gas emissions}
  gem.email = %q{derek@brighterplanet.com}
  gem.homepage = %q{http://github.com/dkastner/emitter}
  gem.authors = ["Andy Rossmeissl", "Seamus Abshere", "Ian Hough", "Matt Kling", 'Derek Kastner']
  gem.files = ['LICENSE', 'README.rdoc'] + 
    Dir.glob(File.join('lib', '**','*.rb'))
  gem.add_development_dependency 'activerecord', '>=3.0.0.beta4'
  gem.add_development_dependency 'bundler', '>=1.0.0.beta.2'
  gem.add_development_dependency 'jeweler', '>=1.4.0'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rdoc'
  gem.add_development_dependency 'rspec', '>=2.0.0.beta.17'
  gem.add_dependency 'activesupport', '>=3.0.0.beta4'
  gem.add_dependency 'characterizable', '>=0.0.16'
  gem.add_dependency 'data_miner', '>=0.5.2' unless ENV['LOCAL_DATA_MINER']
  gem.add_dependency 'earth', '>=0.0.21'
  gem.add_dependency 'falls_back_on', '>=0.0.2'
  gem.add_dependency 'fast_timestamp', '>=0.0.4'
  gem.add_dependency 'leap', '>=0.4.3' unless ENV['LOCAL_LEAP']
  gem.add_dependency 'summary_judgement', '>=1.3.8'
  gem.add_dependency 'timeframe', '>=0.0.8'
  gem.add_dependency 'weighted_average', '>=0.0.4'
  gem.add_dependency 'cohort_scope', '>=0.0.6'
end
Jeweler::GemcutterTasks.new

Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "flight #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
