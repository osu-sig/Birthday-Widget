require 'date'

send_event("demo_1", :end => (Date.today + 1).to_time, :title => "Someone's birthday")

send_event("demo_3", :end => Time.now, :title => "Someone's birthday")

send_event("demo_4", :end => nil, :title => nil)