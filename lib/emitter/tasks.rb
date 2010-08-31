namespace :emitter do
  task :rocco do
    require 'rocco'
  end
  
  task :docs => :rocco do
    FileUtils.mkdir_p File.join('.', 'doc')
    %w(carbon_model characterization data summarization).each do |file|
      puts "[docs] #{file}.rb"
      File.open(File.join('.', 'doc', "#{file}.html"), 'wb') { |fd| fd.write(Rocco.new(File.join('.', 'lib', File.basename(Dir.pwd), "#{file}.rb")).to_html) }
    end
  end
end
