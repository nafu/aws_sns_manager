module AwsSnsManager
  # = AwsSnsManager::Client
  class Client
    attr_accessor :client
    attr_accessor :arn

    def initialize(options = {})
      super()

      @client = Aws::SNS::Client.new(options)
    end

    def send(text = nil, options = {})
      message = message(text, options).to_json
      response = publish_rescue(message)
      !response.nil?
    end

    def publish_rescue(message)
      client.publish(
        target_arn: arn,
        message: message,
        message_structure: 'json'
      )
    end

    def message(text, options = {})
      json = notification(text, options).to_json
      {
        default: json
        APNS: json
      }
    end

    def notification(text, options = {})
      base = {
        aps: {
          alert: text,
          sound: 'default',
          badge: 1,
          'content-available': 1
        }
      }
      base.merge(options)
    end
  end
end
