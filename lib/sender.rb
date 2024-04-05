# frozen_string_literal: true

require "json"
require "json-schema"
require "faraday"
require "zeitwerk"

module Unigo
  module Sender
    class << self
      attr_writer :configuration

      def configuration
        @configuration ||= Configuration.new
      end

      def configure
        yield(configuration)
      end
    end
  end
end

loader = Zeitwerk::Loader.new
loader.inflector = Zeitwerk::GemInflector.new(__FILE__)
loader.push_dir("#{__dir__}/unigo", namespace: Unigo::Sender)
loader.setup
