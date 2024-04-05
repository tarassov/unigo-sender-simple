# frozen_string_literal: true

module Unigo
  module Sender
    class Client
      module Email
        extend Unigo::Sender::Validation::ClassMethods
        include Unigo::Sender::Validation::InstanceMethods
        def send_email(params = {})
          params[:message][:options][:send_at] =
            handle_time_param(params.dig(:message, :options, :send_at)) if params.dig(
              :message, :options, :send_at
            )
          post("email/send.json", params)
        end

        add_response_validations(
          :email,
          [
            "send_email",
          ],
        )
      end
    end
  end
end
