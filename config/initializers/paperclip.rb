# for custom paperclip interpolates like record name that are not otherwise available in url
Paperclip.interpolates('name') do |attachment, style|
    attachment.instance.name.parameterize
end
Paperclip::Attachment.default_options.merge!(
  storage: :fog,
  fog_credentials: {
    provider: 'AWS',
    aws_access_key_id: ENV["AMAZON_ID"],
    aws_secret_access_key: ENV["AMAZON_KEY"],
    :preserve_files => true,
    region: ENV["REGION"],
  },
  fog_directory: ENV["BUCKET"]
)