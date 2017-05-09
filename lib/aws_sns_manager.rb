# frozen_string_literal: true

require 'aws-sdk'
require 'json'

# = AwsSnsManager
module AwsSnsManager
  autoload :Config, 'aws_sns_manager/config'
  autoload :Client, 'aws_sns_manager/client'

  def self.config(&block)
    block.call(AwsSnsManager::Config) if block_given?
  end
end
