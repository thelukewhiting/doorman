xml.instruct!
xml.Response do
  
  # This can be used in lieu of Twilio's play digits
  # xml.Play  "http://jetcityorange.com/dtmf/DTMF-0.mp3"
  
  xml.Play( " ", :digits => @unlock_digits )
  
  #Send text message
  xml.Sms( @message, :to => @recipient )

end