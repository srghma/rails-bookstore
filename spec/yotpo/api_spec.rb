require 'rails_helper'

RSpec.describe 'Yotpo integration' do
  # it 'get_oauth_token and validate' do
  #   params = { app_key: ENV['YOTPO_KEY'], secret: ENV['YOTPO_SECRET'] }
  #   resp = Yotpo.get_oauth_token(params)
  #   expect(resp.status).to eq 200
  #   utoken = resp.body.access_token

  #   params = { utoken: utoken, app_key: ENV['YOTPO_KEY'] }
  #   resp = Yotpo.validate_token(params)
  #   expect(resp.status).to eq 200
  # end
end
