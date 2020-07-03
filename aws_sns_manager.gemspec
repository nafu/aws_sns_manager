# coding: utf-8
# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'aws_sns_manager/version'

Gem::Specification.new do |s|
  s.authors       = ['Fumiya Nakamura']
  s.description   = 'Utility for Amazon Simple Notification Service'
  s.email         = ['nakamurafumiya003@gmail.com']
  s.files         = `git ls-files -z`.split("\x0").reject { |f| f.start_with?('spec/') }
  s.homepage      = 'http://github.com/nafu/aws_sns_manager'
  s.licenses      = %w[MIT]
  s.name          = 'aws_sns_manager'
  s.require_paths = %w[lib]
  s.required_rubygems_version = '>= 1.3.5'
  s.summary       = s.description
  s.version       = AwsSnsManager::VERSION
  s.version       = "#{s.version}-alpha-#{ENV['TRAVIS_BUILD_NUMBER']}" if ENV['TRAVIS']

  s.required_ruby_version = '~> 2.0'

  s.add_dependency 'aws-sdk', '~> 2'
  s.add_dependency 'json', '~> 1.8'

  s.add_development_dependency 'bundler', '>= 1.3.0'
  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'rspec', '~> 3'
  s.add_development_dependency 'simplecov', '~> 0.9'
  s.add_development_dependency 'rubocop', '~> 0.30'
end
