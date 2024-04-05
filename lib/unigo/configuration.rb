# frozen_string_literal: true

module Unigo
  module Sender
    class Configuration
      attr_accessor :adapter,
        :connection_open_timeout,
        :connection_timeout,
        :enable_logging,
        :lang,
        :api_key,
        :host,
        :api_key_in_params

      def initialize
        @adapter = Faraday.default_adapter
        @connection_open_timeout = 20
        @connection_timeout = 20
        @enable_logging = false
        @lang = "ru"
        @host = "go1.unisender.ru"
        @api_key_in_params = false
      end
    end
  end
end
