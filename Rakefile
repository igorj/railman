require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList['test/**/*_test.rb']
end

task :patch do
  system "gem bump --tag"
end

task :minor do
  system "gem bump --version minor --tag"
end

task :major do
  system "gem bump --version major --tag"
end

task :publish => [:build] do
  $VERBOSE = nil
  load 'railman/version.rb'
  system "gem push pkg/railman-#{Railman::VERSION}.gem"
end

desc "Bump patch version, create git tag, build the gem and release to geminabox (default)"
task :release_patch => [:test, :patch, :publish]

desc "Bump minor version, create git tag, build the gem and release to geminabox"
task :release_minor => [:test, :minor, :publish]

desc "Bump major version, create git tag, build the gem and release to geminabox"
task :release_major => [:test, :major, :publish]


task :default => :test
