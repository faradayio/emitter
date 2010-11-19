require 'emitter'
require 'rake'
require 'rake/clean'
require 'rake/tasklib'
require 'rocco/tasks'

module Emitter
  class Tasks < ::Rake::TaskLib
    def self.define
      new.define
    end

    def git(cmd, dir = nil, &blk)
      full_cmd = ''
      full_cmd << "cd #{dir} && " if dir
      full_cmd << "unset GIT_DIR && unset GIT_INDEX_FILE && unset GIT_WORK_TREE && git #{cmd}"
      sh full_cmd, &blk
    end

    def define(name)
      Rocco::make 'docs/', "lib/#{name}/carbon_model.rb"

      desc 'Build rocco docs'
      task :docs => :rocco
      directory 'docs/'

      # GITHUB PAGES ===============================================================

      desc 'Update gh-pages branch'
      task :pages => ['pages:sync', :docs] do
        rev = `git rev-parse --short HEAD`.strip
        git 'add *.html', 'docs'
        git "commit -m 'rebuild pages from #{rev}'", 'docs' do |ok,res|
          if ok
            verbose { puts "gh-pages updated" }
            git 'push -q o HEAD:gh-pages', 'docs' unless ENV['NO_PUSH']
          end
        end
      end

      # Update the pages/ directory clone
      namespace :pages do
        task 'sync' => ['.git/refs/heads/gh-pages', '.git/refs/heads/gh-pages', 'docs/.git/refs/remotes/o'] do |f|
          git 'fetch -q o', 'docs'
          git 'reset -q --hard o/gh-pages', 'docs'
          sh 'touch docs'
        end

        file '.git/refs/heads/gh-pages' do |f|
          unless File.exist? f.name
            git 'branch gh-pages --track origin/gh-pages', 'docs' 
          end
        end

        file 'docs/.git/refs/remotes/o' do |f|
          unless File.exist? f.name
            git 'init -q docs'
            git 'remote add o ../.git', 'docs'
          end
        end
      end

      CLOBBER.include 'docs/.git'
    end
  end
end
