#!/usr/bin/env ruby

require 'nokogiri'
require 'open-uri'

# Represents a single row in the list of reported observations.
class Observation
	SNOWING_THRESHOLD = 0.3 # if > than this amount in inches, we consider it snowing.
	OUT_OF_RANGE = 5 # in inches, would be awesome, but we consider this out of range.

	attr_accessor :text

	def initialize(text)
		# sample row text - snow height is 11th column. don't look to be tab-seperated, so parsing is hokey.
		# 2014 Dec 05 01:00 pm    29    -    -   18  62   7 259  15  26.7   299    72   221   268   180
		@text = text
	end

	def snow_height
		text.split(/\s+/).reverse[5].to_f
	end

	# returns the difference btw this observation and another.
	def difference(previous_observation)
		snow_height - previous_observation.snow_height
	end

	def snowing?(previous_observation)
		diff = difference(previous_observation)
		diff >= SNOWING_THRESHOLD and diff < OUT_OF_RANGE
	end
end

class Observations
	URL = 'http://avalanche.state.co.us/caic/obs_stns/tabular.php?unit=e&area=caic'

	attr_accessor :doc

	# date should be formatted like: 2014-11-23-14
	# station is the ST param
	def initialize(options = {})
		default_options = {station: 'CACMP'} # Cameron Pass
		options = default_options.merge(options)
		url = URL
		url += "&date=#{options[:date]}" if options[:date]
		url += "&st=#{options[:station]}" if options[:station]
		@doc = Nokogiri::HTML(open(url))
	end

	def rows
		doc.xpath("//span")
	end
end

# ST = Cameron Pass
URL = 'http://avalanche.state.co.us/caic/obs_stns/tabular.php?st=CACMP&unit=e&area=caic'
doc = Nokogiri::HTML(open(URL))
observations = Observations.new({date: ENV['DATE']})
current = Observation.new(observations.rows.first.inner_html) # the most current reading. assume it's current - might not be. 
previous = Observation.new(observations.rows[6].inner_html) # an hour ago ... might not be.

puts current.snowing?(previous)

