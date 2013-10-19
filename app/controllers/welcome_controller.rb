class WelcomeController < ApplicationController
  def index
    Twilio::TwiML::Response.new do |r|
    @text = r.Say 'Hello Monkey'
    end.text
  end
end
