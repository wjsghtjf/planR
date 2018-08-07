CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'                        # required
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     'AKIAJ52RW7PYXHSXDEHA',                        # required
    aws_secret_access_key: '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',                        # required
    region:                'ap-northeast-2',             # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'plan-r'            # required
end