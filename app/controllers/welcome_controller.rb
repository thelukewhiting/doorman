class WelcomeController < ApplicationController
  def index
    @response = Twilio::TwiML::Response.new do |r|
      r.Say 'Hello Monkey'
    end.text
    render :inline => "Welcome to the world"
  end
end
