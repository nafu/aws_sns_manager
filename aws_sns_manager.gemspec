def aws_sns_manager_files
  `git ls-files -z`.split("\x0").reject { |f| f.start_with?('spec/') }
end

Gem::Specification.new do |s|
  s.authors       = ['Fumiya Nakamura']
  s.description   = 'Utility for Amazon Simple Notification Service'
  s.email         = ['nakamurafumiya003@gmail.com']
  s.files         = aws_sns_manager_files
  s.homepage      = 'http://github.com/nafu/aws_sns_manager'
  s.licenses      = %w(MIT)
  s.name          = 'aws_sns_manager'
  s.require_paths = %w(lib)
  s.required_rubygems_version = '>= 1.3.5'
  s.summary       = s.description
  s.version       = '0.0.1'

  s.add_dependency 'aws-sdk', '~> 2'
  s.add_dependency 'json'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rspec', '~> 3'
  s.add_development_dependency 'rubocop'
end
