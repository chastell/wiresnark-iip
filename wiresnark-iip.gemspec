Gem::Specification.new do |gem|
  gem.name     = 'wiresnark-iip'
  gem.version  = '0.0.1'
  gem.summary  = 'Wiresnark: IIP support'
  gem.homepage = 'http://github.com/chastell/wiresnark-iip'
  gem.author   = 'Piotr Szotkowski'
  gem.email    = 'p.szotkowski@tele.pw.edu.pl'

  `git ls-files`
  if $?.exitstatus.zero?
    gem.files       = `git ls-files -z`.split "\0"
    gem.executables = `git ls-files -z -- bin/*`.split("\0").map { |path| File.basename path }
    gem.test_files  = `git ls-files -z -- spec/*`.split "\0"
  else
    gem.files       = Dir['**/*']
    gem.executables = Dir['bin/**/*'].map { |path| File.basename path }
    gem.test_files  = Dir['spec/**/*']
  end

  gem.extensions = ['ext/wiresnark/iip/extconf.rb']

  gem.add_dependency 'ffi'
  gem.add_dependency 'nokogiri'

  gem.add_development_dependency 'bundler'
  gem.add_development_dependency 'minitest', '>= 2.12'
end
