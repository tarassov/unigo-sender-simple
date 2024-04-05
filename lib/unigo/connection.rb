require "json"
require "faraday"
require "hashie"

module Unigo
  module Sender
    module Connection
      def get(url, params = {})
        prepare_params!(params)

        # Assume HTTP library receives params as Hash
        request(:get, url, params)
      end

      def post(url, params = {})
        prepare_params!(params)

        # Assume HTTP library receives payload body as String
        request(:post, url, JSON.dump(params))
      end

      private

      def request(method, path, data)
        @last_response = connection.send(method, path, data)
      end

      def connection
        headers = { "Content-Type" => "application/json" }
        prepare_headers!(headers)

        @connection ||= Faraday.new(
          url: api_endpoint,
          headers: headers,
        ) do |conn|
          conn.response(:mashify, content_type: /\bjson$/)
          conn.response(:json, content_type: /\bjson$/)
          conn.response(:raise_error)
          conn.adapter(Unigo::Sender.configuration.adapter)
          conn.options.timeout = Unigo::Sender.configuration.connection_timeout
          conn.options.open_timeout = Unigo::Sender.configuration.connection_open_timeout

          if Unigo::Sender.configuration.enable_logging
            conn.response(:logger, nil, { headers: true, bodies: true, errors: true })
          end
        end
      end

      def prepare_params!(params)
        params.merge!({ api_key: Unigo::Sender.configuration.api_key }) if Unigo::Sender.configuration.api_key_in_params
      end

      def prepare_headers!(headers)
        headers.merge!("X-API-KEY" => Unigo::Sender.configuration.api_key) unless Unigo::Sender.configuration.api_key_in_params
      end
    end
  end
end
