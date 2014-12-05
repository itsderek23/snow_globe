require 'pi_piper'

result = `./is_it_snowing`

pin = PiPiper::Pin.new(:pin => 17, :direction => :out)

if result == 'true'
	pin.on
else
	pin.off
end