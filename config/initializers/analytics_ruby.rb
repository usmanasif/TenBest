require 'segment/analytics'

Analytics = Segment::Analytics.new({
    write_key: 't644WFwrpi5QqXP2flwFddEIj0wOAGyq',
    on_error: Proc.new { |status, msg| print msg }
})