require 'rubygems'
require 'optparse'
#require 'nokogiri'

# => Dynamic loader
#Dir["./tools/*.rb"].each {|file| require file }

# => Arguments parsing
options ={}
OptionParser.new do |opts|
	opts.banner = "Test de l'aide"
	opts.on("-g", "--git action","mass git action") do |action|
		options[:git] =action
	end
	opts.on("-a", "--apt action","apt action") do |action|
		options[:git] =action
	end
end.parse!

p options
p ARGV
