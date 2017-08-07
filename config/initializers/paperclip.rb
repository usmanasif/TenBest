# for custom paperclip interpolates like record name that are not otherwise available in url
Paperclip.interpolates('name') do |attachment, _style|
  attachment.instance.name.parameterize
end
Paperclip::Attachment.default_options.merge!(
  storage: :fog,
  fog_credentials: {
    provider: 'AWS',
    aws_access_key_id: ENV['AMAZON_ID'],
    aws_secret_access_key: ENV['AMAZON_KEY'],
    preserve_files: false,
    region: ENV['REGION']
  },
  fog_directory: ENV['BUCKET'],
  url: 'images/:class/:name/:style/:basename.:extension',
  path: 'images/:class/:name/:style/:basename.:extension',
  default_url: 'images/place-image.png'
)
