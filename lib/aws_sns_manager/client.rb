module AwsSnsManager
  # = AwsSnsManager::Client
  class Client
    attr_accessor :client
    attr_accessor :arn

    def initialize(options = {})
      super()

      @client = Aws::SNS::Client.new(options)
    end

    def send
      message = message('Hi').to_json
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

    def message(text)
      {
        APNS: notification(text).to_json
      }
    end

    def notification(text)
      {
        aps: {
          alert: text,
          sound: 'default',
          badge: 1
        }
      }
    end
  end
end
