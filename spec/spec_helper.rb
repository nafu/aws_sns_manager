require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start
require 'simplecov'
SimpleCov.start

require 'rspec'
require 'aws-sdk'
require 'aws_sns_manager'
