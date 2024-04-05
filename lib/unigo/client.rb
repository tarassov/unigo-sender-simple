# frozen_string_literal: true

module Unigo
  module Sender
    class Client
      include Unigo::Sender::Connection

      class BaseException < StandardError; end
      class InvalidCallbackAuth < BaseException; end

      class << self
        def run(*args, &block)
          new(*args).run(&block)
        end
      end

      API_ENDPOINT =
        "https://%{hostname}/%{lang}/transactional/api/v1/"

      # * *Args* :
      #   - +host+          -> string, API hostname, for example 'go1.unisender.ru'
      #   - +api_key_in_params+ -> boolean, pass API key in parameters, otherwise pass in headers (default)
      def initialize(params = {})
        @hostname = params[:host] || Unigo::Sender.configuration.host
      end

      def run
        yield self
      end

      private

      def api_endpoint
        @api_endpoint ||=
          format(API_ENDPOINT, hostname: @hostname, lang: Unigo::Sender.configuration.lang)
      end

      def handle_time_param(param)
        param.respond_to?(:strftime) ? param.strftime("%Y-%m-%d %H:%M:%S") : param
      end

      def handle_date_param(param)
        param.respond_to?(:strftime) ? param.strftime("%Y-%m-%d") : param
      end
    end
  end
end
