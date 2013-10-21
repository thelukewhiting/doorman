class WelcomeController < ApplicationController
  def index
    @text = Twilio::TwiML::Response.new do |r|
      r.Say 'Hello Monkey'
    end.text
  end
end
