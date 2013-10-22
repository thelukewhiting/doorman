xml.instruct!
xml.Response do
  xml.Say "Hello #{@name}"
  xml.Play "http://jetcityorange.com/dtmf/DTMF-0.mp3"
end