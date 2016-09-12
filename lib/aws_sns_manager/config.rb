# frozen_string_literal: true
module AwsSnsManager
  # = AwsSnsManager::Config
  module Config
    @model = 'PushEndpoint'
    class << self
      # Configuration option to specify a model
      # you want to use AwsSnsManager to work with.
      # Default: PushEndpoint
      attr_accessor :model
    end
  end
end
