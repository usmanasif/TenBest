# for custom paperclip interpolates like record name that are not otherwise available in url
Paperclip.interpolates('name') do |attachment, _style|
  attachment.instance.name.parameterize
end
Paperclip.interpolates(:placeholder) do |_attachment, _style|
  arr = ['brands', 'brewery', 'events', 'parks', 'travel']
  ActionController::Base.helpers.asset_path("image-places-#{arr[rand(arr.length)]}.jpg")
end
Paperclip::Attachment.default_options.merge!(
  storage: :fog,
  fog_credentials: {
    provider: 'AWS',
    aws_access_key_id: ENV['AMAZON_ID'],
    aws_secret_access_key: ENV['AMAZON_KEY'],
    region: ENV['REGION']
  },
  fog_directory: ENV['BUCKET'],
  preserve_files: false,
  url: 'images/:class/:name/:style/:basename.:extension',
  path: 'images/:class/:name/:style/:basename.:extension',
  default_url: ':placeholder'
)
