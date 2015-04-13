require 'spec_helper'

describe AwsSnsManager::Client do
  describe '#send' do
    context 'when client arn is valid' do
      let(:client) do
        manager = AwsSnsManager::Client.new(stub_responses: true)
        manager.client.stub_responses(
          :publish, message_id: '606781ee-ff46-5f93-bd04-cc4ac4dd68c3')
        manager
      end

      it 'should send SNS successfully' do
        # without message
        expect(client.send).to be true
        # with message
        expect(client.send('Hi')).to be true
      end
    end

    context 'when client arn is not valid' do
      let(:client) do
        manager = AwsSnsManager::Client.new(stub_responses: true)
        manager.client.stub_responses(
          :publish, Aws::SNS::Errors::InvalidParameter)
        manager
      end

      let(:error) do
        begin
          client.send
        rescue => error
          # suppress for testing
        end
        error
      end

      it 'should raise Aws::SNS::Errors::InvalidParameter' do
        expect(error.class.name).to eq('Aws::SNS::Errors::InvalidParameter')
      end
    end
  end
end
