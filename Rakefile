require 'rake/testtask'

task default: :spec

desc 'Compile the regset library'
task :build_regset do
  system 'gcc -c -fPIC -o ext/wiresnark-iip/regset.o ext/wiresnark-iip/regset.c'
  system 'gcc -shared -o ext/wiresnark-iip/regset.so ext/wiresnark-iip/regset.o'
end

Rake::TestTask.new :spec do |task|
  task.test_files = FileList['spec/**/*_spec.rb']
end
