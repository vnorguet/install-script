require "net/ssh"
require "nokogiri"

class Ssh
	def update
		output =""
		loadFromXml.each do |host|
			begin
				ssh = Net::SSH::start(host, 'vincent',:config => '/home/vincent/.ssh/config') do |conn|
					output = conn.exec! "echo 'password' | sudo apt-get update && sudo apt-get dist-upgrade -y && sudo apt-get autoclean"
				end
				Logger.debug(host.to_s+" updated ")
			rescue Timeout::Error
			    puts host.to_s+"  Timed out"
			rescue Errno::EHOSTUNREACH
			    puts host.to_s+"  Host unreachable"
			rescue Errno::ECONNREFUSED
			    puts host.to_s+"  Connection refused"
			rescue Net::SSH::AuthenticationFailed
			    puts host.to_s+"  Authentication failure"
			rescue SocketError
				puts host.to_s+"  Hostname problem"
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
			else puts "File doesn't exists"
		end
		return servers
	end

end

#ssh = Ssh.new
#ssh.update