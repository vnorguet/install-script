require 'net/ssh'
require 'nokogiri'

class Ssh 
	include Log
	def update
		output =""
		loadFromXml.each do |host|
			begin
				ssh = Net::SSH::start(host, 'vincent',:config => '/home/vincent/.ssh/config') do |conn|
					output = conn.exec! "echo 'password' | sudo apt-get update && sudo apt-get dist-upgrade -y && sudo apt-get autoclean"
				end
			rescue Timeout::Error || Errno::ETIMEDOUT
			    Log::logger.error( host.to_s+"  Timed out")
			rescue Errno::EHOSTUNREACH
			    Log::logger.error( host.to_s+"  Host unreachable")
			rescue Errno::ECONNREFUSED
			    Log::logger.error( host.to_s+"  Connection refused")
			rescue Errno::EINVAL
				Log::logger.error( hosts.to_s+"  No internet connection")
			rescue Net::SSH::AuthenticationFailed
			    Log::logger.error( host.to_s+"  Authentication failure")
			rescue SocketError
				Log::logger.error( host.to_s+"  Hostname problem")

			end	
		end
	end

	def connect(servers,commands)
		servers.each do |host|
			ssh = Net::SSH::start(host, 'vincent',:config => '/home/vincent/.ssh/config') do |conn|
				commands.each do |cmd|
					conn.exec! cmd
				end
			end
		end
	end

	def loadFromXml(filePath ="/home/vincent/git/install-script/conf/servers.xml")
		servers = Array.new
		if (File.exists?(filePath))
			then
				file = File.open(filePath)
				doc = Nokogiri::XML(file)
				doc.xpath('//servers/server').each do |node|
					servers.push(node.attribute("name"))
				end
				file.close
			else Log::logger.error( " Servers' xml conf file doesn't exists")
		end
		return servers
	end

end

#ssh = Ssh.new
#ssh.update