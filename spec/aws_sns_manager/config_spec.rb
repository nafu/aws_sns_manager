# frozen_string_literal: true
require 'spec_helper'

describe AwsSnsManager::Config do
  describe '.model' do
    it 'only uses the model' do
      AwsSnsManager::Config.model = 'PushEndpoint'
      expect(AwsSnsManager::Config.model).to eq('PushEndpoint')
    end
  end
end
