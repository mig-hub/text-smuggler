Gem::Specification.new do |s|

  s.authors = ['Mickael Riga']
  s.email = ['mig@mypeplum.com']
  s.homepage = 'https://github.com/mig-hub/text-smuggler'
  s.licenses = ['MIT']

  s.name = 'text-smuggler'
  s.version = '0.0.1'
  s.summary = 'TextSmuggler is for encoding/decoding text'
  s.description = 'TextSmuggler makes it easy to obfuscate pieces of text which need to be decoded later on using OpenSSL::Cipher. Possibly incorporated in a URL'

  s.platform = Gem::Platform::RUBY
  s.files = `git ls-files`.split("\n").sort
  s.test_files = s.files.grep(/^test\//)
  s.require_paths = ['lib']

end

