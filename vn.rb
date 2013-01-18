require 'rubygems'
require 'optparse'
require 'logger'
#SSH
require 'nokogiri'
require 'net/ssh'


# => Dynamic loader
Dir["./tools/*.rb"].each do |file| 
	require file.to_s
end

# => Logger init
logger = Logger::new("log/vn.log",'daily')

# => Arguments parsing
options ={}
OptionParser.new do |opts|
	opts.banner = "Test de l'aide"
	opts.on("-g", "--git action","mass git action") do |action|
		options[:git] =action
	end
	opts.on("-a", "--apt action","apt action") do |action|
		options[:apt] =action
	end
	opts.on("-s", "--ssh action","ssh action") do |action|
		options[:ssh] =action
	end
end.parse!

#p options
#p ARGV
sh = Ssh.new
sh.update