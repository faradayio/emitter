require 'rubygems'

def require_or_fail(gems, message, failure_results_in_death = false)
  gems = [gems] unless gems.is_a?(Array)

  begin
    gems.each { |gem| require gem }
    yield
  rescue LoadError
    puts message
    exit if failure_results_in_death
  end
end

unless ENV['NOBUNDLE']
  message = <<-MESSAGE
In order to run tests, you must:
  * `gem install bundler`
  * `bundle install`
  MESSAGE
  require_or_fail('bundler',message,true) do
    Bundler.setup
  end
end

require_or_fail('jeweler', 'Jeweler (or a dependency) not available. Install it with: gem install jeweler') do
  Jeweler::Tasks.new do |gem|
    gem.name = %q{emitter}
    gem.summary = %q{The mother of all carbon models}
    gem.description = %q{A software model in Ruby for the greenhouse gas emissions}
    gem.email = %q{derek@brighterplanet.com}
    gem.homepage = %q{http://github.com/brighterplanet/emitter}
    gem.authors = ["Andy Rossmeissl", "Seamus Abshere", "Ian Hough", "Matt Kling", 'Derek Kastner']
    gem.files = ['LICENSE', 'README.rdoc'] + 
      Dir.glob(File.join('lib', '**','*.rb'))
    gem.add_development_dependency 'activerecord', '>=3.0.0'
    gem.add_development_dependency 'bundler', '>=1.0.0.beta.2'
    gem.add_development_dependency 'jeweler', '>=1.4.0'
    gem.add_development_dependency 'rake'
    gem.add_development_dependency 'rdoc'
    gem.add_development_dependency 'rspec', '>=2.0.0.beta.17'
    gem.add_development_dependency 'sniff', '~> 0.1.12'
    gem.add_dependency 'activesupport', '>=3.0.0'
    gem.add_dependency 'characterizable', '>=0.0.16'
    gem.add_dependency 'cohort_scope', '~>0.1.0'
    gem.add_dependency 'data_miner', '~>0.5.5' unless ENV['LOCAL_DATA_MINER']
    gem.add_dependency 'earth', '~>0.2.6' unless ENV['LOCAL_EARTH']
    gem.add_dependency 'falls_back_on', '=0.0.3' unless ENV['LOCAL_FALLS_BACK_ON']
    gem.add_dependency 'fast_timestamp', '>=0.0.4'
    gem.add_dependency 'leap', '~> 0.4.4' unless ENV['LOCAL_LEAP']
    gem.add_dependency 'summary_judgement', '>=1.3.8'
    gem.add_dependency 'timeframe', '>=0.0.8'
    gem.add_dependency 'weighted_average', '>=0.0.4'
    gem.add_development_dependency 'rocco', '~>0.4'
  end
  Jeweler::GemcutterTasks.new
end

require_or_fail('sniff', 'Sniff gem not found, sniff tasks unavailable') do
  require 'sniff/rake_task'
  Sniff::RakeTask.new(:console)
end

require_or_fail('rspec', 'RSpec gem not found, RSpec tasks unavailable') do
  require 'rspec/core/rake_task'

  desc "Run all examples"
  RSpec::Core::RakeTask.new('examples')

  task :default => :examples
  task :test => :examples
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "lodging #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
