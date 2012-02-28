Gem::Specification.new do |gem|
  gem.name     = 'wiresnark'
  gem.version  = '0.1.4'
  gem.summary  = 'Wiresnark: packet generator/monitor'
  gem.homepage = 'http://github.com/chastell/wiresnark'
  gem.author   = 'Piotr Szotkowski'
  gem.email    = 'p.szotkowski@tele.pw.edu.pl'

  gem.files       = `git ls-files -z`.split "\0"
  gem.executables = `git ls-files -z -- bin/*`.split("\0").map { |file| File.basename file }
  gem.test_files  = `git ls-files -z -- spec/*`.split "\0"

  gem.add_dependency 'ffi'
  gem.add_dependency 'nokogiri'
  gem.add_dependency 'pcaprub'

  gem.add_development_dependency 'bundler'
  gem.add_development_dependency 'minitest', '>= 2.11.1'
end
