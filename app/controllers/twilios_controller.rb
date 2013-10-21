class TwiliosController < ApplicationController

  def incoming
    # Twilio::TwiML::Response.new do |r|
    #   r.Play 'http://demo.twilio.com/hellomonkey/monkey.mp3'
    # end.text
    render :action => "incoming.xml.builder", :layout => false


  end

end
