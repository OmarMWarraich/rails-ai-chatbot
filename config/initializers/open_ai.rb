OpenAi.configure do |config|
    config.access_token = ENV['OPENAI_ACCESS_TOKEN']
    config.request_timeout = 240
end