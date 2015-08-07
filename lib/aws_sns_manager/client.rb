module AwsSnsManager
  # = AwsSnsManager::Client
  class Client
    attr_accessor :client
    attr_accessor :arn

    def initialize(options = {})
      super()

      @client = Aws::SNS::Client.new(options)
    end

    def send(text = nil, options = {}, env = :prod, type = :normal)
      message = message(text, options, env, type).to_json
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

    #
    # Return json payload
    #
    # +text+:: Text you want to send
    # +options+:: Options you want on payload
    # +env+:: Environments :prod, :dev
    # +type+:: Notification type :normal, :silent
    #
    def message(text, options = {}, env = :prod, type = :normal)
      json = nil
      if type == :normal
        json = normal_notification(text, options).to_json
      elsif type == :silent
        json = silent_notification(text, options).to_json
      end
      return { default: json, APNS_SANDBOX: json } if env == :dev
      { default: json, APNS: json }
    end

    def normal_notification(text, options = {})
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

    def silent_notification(_text, options = {})
      base = {
        aps: {
          'content-available': 1
        }
      }
      base.merge(options)
    end
  end
end
