class TwiliosController < ApplicationController

account_sid = "AC3848360ee17f1b1d583ea780e5420a3c"
auth_token = "46c8642262194c3e8b5670412e0606c6"
client = Twilio::REST::Client.new account_sid, auth_token
from = "+14153295828"

  def incoming

    @name = "Luke"

    @enabled = true
  
    if @enabled
      render action: "incoming.xml.builder", :layout => false
    else
      render action:

  end

end
