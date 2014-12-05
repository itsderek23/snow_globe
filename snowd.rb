INTERVAL = 5*60 # seconds
while true do
	puts "[#{Time.now.strftime("%m/%d %l:%M %p")}] Checking for snow..."
	res = `ruby snow_globe_controller.rb`
	puts "[#{Time.now.strftime("%m/%d %l:%M %p")}] #{res.include?('on') ? 'Snowing!' : 'No snow :('}"
	sleep INTERVAL
end