Based on official UniGo Gem https://gitflic.ru/project/unisender/unigo-ruby but using gem faraday", "~> 2.0" to prevent conflicts 

For the moment only send_email is supported from the base library

```ruby
  gem 'unigo-sender-simple'
```
```ruby
  bundle install
```
configuration example
```ruby
    Unigo::Sender.configure do |config|
      config.host = "go1.unisender.ru"
      config.api_key = Rails.application.secrets.api_key
    end

```
 
usage
```ruby
 message = {}

      message[:subject] = @subject
      message[:body] = { "html": "<h3>#{@title}</h3><div><p>#{@main_text}<br></p></div><div><p>#{@footer}</p></div>", "plaintext": @main_text } unless @template

      message[:from_email] = "from@test.ru"
      message[:from_name] = @from_name 

      if @bypass
        message[:bypass_unsubscribed] = 1
        message[:bypass_global] = 1
        message[:bypass_unavailable] = 1
        message[:skip_unsubscribe] = 1
      end
      message[:recipients] = []

      message[:template_engine] = "simple"
      message[:template_id] = @template if @template

      message[:recipients] << {
        email: "test@test.com",
        substitutions: {
          "title" => @title || "",
          "main_text" => @main_text || "",
          "link" => @link || "",
          "link_name" => @link_name || "",
          "secondary_text" => @secondary_text || "",
          "footer" => @footer || "",
        },
      }

      begin
        client = Unigo::Sender::Client.new
        client.send_email(message: message)
      rescue Faraday::Error => err
        raise err.response[:body] # raise Exception, { message: "Send error to #{@email} with subject #{@subject}" }
      end
```
