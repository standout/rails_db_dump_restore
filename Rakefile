begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rdoc/task'

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'RailsDbDumpRestore'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end






Bundler::GemHelper.install_tasks

require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end


task default: :test

namespace :dummy do
  # Because we need a repo to deploy, and dummy is nested inside this repo
  desc "Copy test/dummy into test/dummy-repo, run git init and commit"
  task :gitify do
    require 'fileutils'

    dummy_code = "test/dummy"
    dummy_repo = "test/dummy-repo"

    if File.directory? dummy_repo
      FileUtils.rm_rf dummy_repo
    end

    FileUtils.cp_r dummy_code, dummy_repo

    FileUtils.cd dummy_repo
    system "git init -q && git add . && git commit -qm 'blah blah' > /dev/null"
  end

  def deploy(stage)
    FileUtils.cd "test/dummy"

    system "bundle exec cap #{stage} deploy && RAILS_ENV=#{stage} bundle exec cap #{stage} db:pull"
  end

  [
    :postgres,
    :mysql
  ].each do |stage|
    desc "Deploy dummy #{stage} app"
    task stage do
      deploy stage
    end
  end
end
