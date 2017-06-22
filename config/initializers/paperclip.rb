# for custom paperclip interpolates like record name that are not otherwise available in url
Paperclip.interpolates('name') do |attachment, style|
    attachment.instance.name.parameterize
end