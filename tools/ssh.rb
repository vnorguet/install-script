require "net/ssh"

class Ssh
	def update(servers)
		output =""
		servers.each do |host|
			ssh = Net::SSH::start(host, 'vincent',:config => '/home/vincent/.ssh/config') do |conn|
				output = conn.exec! "echo 'password' | sudo apt-get update && sudo apt-get dist-upgrade -y && sudo apt-get autoclean"
			end
		end
		puts output
	end

end

ssh = Ssh.new
ssh.update(["neptune"])
