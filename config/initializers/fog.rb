# Adding Amazon S3 to Carrierwave
CarrierWave.configure do |config| 
  config.fog_credentials = { 
    provider:               'AWS', 
    aws_access_key_id:      "AKIAINJNEY4727JLRKDQ", 
    aws_secret_access_key:  "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", 
  } 
  config.fog_directory  = 'ghacka'
  config.fog_public     = true 
end 

# Ref:
# https://support.cloud.engineyard.com/entries/20996881-Use-CarrierWave-and-Optionally-Fog-to-Upload-and-Store-Files#update3
# http://stackoverflow.com/questions/7946819/carrierwave-and-amazon-s3
