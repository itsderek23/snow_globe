require 'pi_piper'

result = `ruby is_it_snowing.rb`

pin = PiPiper::Pin.new(:pin => 17, :direction => :out)

if result == 'true'
	pin.on
else
	pin.off
end