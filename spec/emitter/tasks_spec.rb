require 'spec_helper'
require 'sandbox'
require 'emitter/tasks'

describe Emitter::Tasks do
  def git(cmd, dir = nil, &blk)
    full_cmd = ''
    full_cmd << "cd #{dir} && " if dir
    full_cmd << "unset GIT_DIR && unset GIT_INDEX_FILE && unset GIT_WORK_TREE && git #{cmd}"
    `#{full_cmd}`
  end

  let(:tasks) { Emitter::Tasks.new }
  let(:emitter_path) { File.expand_path '../../', File.dirname(__FILE__) }
  let(:rakefile) do
    rakefile = <<-RAKEFILE
require '#{emitter_path}/lib/emitter/tasks'

Emitter::Tasks.define
    RAKEFILE
  end

  describe '#define' do
    describe 'docs task' do
      it 'should generate docs' do
        Sandbox.play do |path|
          flight_path = File.join(path, 'flight')
          git "clone git://github.com/brighterplanet/flight.git #{flight_path}"
          File.open(File.join(flight_path, 'Rakefile'), 'w') do |f|
            f.puts rakefile
          end

          `cd #{flight_path} && rake docs`
          Dir.entries(File.join(flight_path, 'docs')).
            count.should > 2
        end
      end
    end

    describe 'pages task' do
      it 'should commit any changed doc files' do
        Sandbox.play do |path|
          flight_path = File.join(path, 'flight')
          git "clone git://github.com/brighterplanet/flight.git #{flight_path}"
          File.open(File.join(flight_path, 'Rakefile'), 'w') do |f|
            f.puts rakefile
          end

          `cd #{flight_path} && mkdir docs && echo "<html>" > docs/foobar.html`
          `cd #{flight_path} && NO_PUSH=true rake pages`

          git('log -n 1', File.join(flight_path, 'docs')).
            should =~ /rebuild pages/
        end
      end
    end
  end
end

