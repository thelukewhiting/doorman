xml.instruct!
xml.Response do
  xml.Say "Hello #{@name}"
  xml.Play "/app/tones/0.mp3"
end