require 'webmock/rspec'
require 'dotenv/load'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.before(:each) do
    api_url = ENV['ABSTRACT_API_URL']

    stub_request(:any, /#{api_url}/)
      .to_return(status: 200, body: { quality_score: 0.8 }.to_json, headers: {})
  end
end