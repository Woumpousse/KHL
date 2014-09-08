require 'date'
require './ical.rb'


$cal = ICal::Calendar.from_file('calendar.ics')



$cal.select do |event|
  event.algo_practice?
end.sort.each do |event|
  puts event.start.strftime("%W %d/%m"), event.summary, event.groups
end
