require 'pi_piper'

result = `ruby is_it_snowing.rb`
puts "Is it snowing? #{result}"

pin = PiPiper::Pin.new(:pin => 17, :direction => :out)

if result.include?('true')
	pin.on
else
	pin.off
end