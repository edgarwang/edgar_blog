json.files [@attachment] do |attachment|
  json.name attachment.read_attribute(:file)
  json.url attachment.file.url
end
