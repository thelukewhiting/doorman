class WelcomeController < ApplicationController
  def index
    Twilio::TwiML::Response.new do |r|
      r.Say 'Hello Monkey'
    end.text
  end
end