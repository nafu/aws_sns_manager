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
    # +type+:: Notification type :normal, :silent, :nosound
    #
    def message(text, options = {}, env = :prod, type = :normal)
      if type == :normal
        data = normal_notification(text, options)
      elsif type == :silent
        data = silent_notification(text, options)
      elsif type == :nosound
        data = nosound_notification(text, options)
      end
      return dev_json(data) if env == :dev
      prod_json(data)
    end

    def normal_notification(text, options = {})
      base = {
        aps: {
          alert: {
            title: nil,
            subtitle: nil,
            body: text
          },
          sound: 'default',
          badge: 1,
          'mutable-content': 1,
          'content-available': 1
        }
      }
      base.merge(options)
    end

    def silent_notification(_text, options = {})
      base = {
        aps: {
          'mutable-content': 1,
          'content-available': 1
        }
      }
      base.merge(options)
    end

    def nosound_notification(text, options = {})
      base = {
        aps: {
          alert: {
            title: nil,
            subtitle: nil,
            body: text
          },
          badge: 1,
          'mutable-content': 1,
          'content-available': 1
        }
      }
      base.merge(options)
    end

    private

    def dev_json(data)
      { default: data.to_json, APNS_SANDBOX: data.to_json }
    end

    def prod_json(data)
      { default: data.to_json, APNS: data.to_json, GCM: { data: data }.to_json }
    end
  end
end
