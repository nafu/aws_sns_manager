# frozen_string_literal: true
require 'spec_helper'

describe AwsSnsManager do
  describe '.config' do
    it 'only uses the model' do
      expect(AwsSnsManager::Config.model).to eq('PushEndpoint')
      AwsSnsManager.config do |config|
        config.model = 'UserDefine'
      end
      expect(AwsSnsManager::Config.model).to eq('UserDefine')
    end
  end
end
