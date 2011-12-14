require 'rake/testtask'

task default: :spec

desc 'Compile the regset library'
task :build_regset do
  system 'gcc -c -fPIC -o ext/regset.o ext/regset.c'
  system 'gcc -shared -o ext/regset.so ext/regset.o'
end

Rake::TestTask.new :spec do |task|
  task.test_files = FileList['spec/**/*_spec.rb']
end
