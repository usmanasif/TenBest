require 'segment/analytics'

Analytics = Segment::Analytics.new({
    write_key: '3s0TPWLTY1CxsdDO0AD0ahMHodZ2zoy8',
    on_error: Proc.new { |status, msg| print msg }
})