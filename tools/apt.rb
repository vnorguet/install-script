class Apt
	attr_accessible packageList
	
	def loadFromXml (xmlFilePath)
		
	end
	
	def install
		puts "installing..."
		cmd = 'apt-get install '.packageList.map{|pack| pack.to_s}.join(" ")
		exec(cmd)
	end

	def upgrade
		puts "updating..."
		cmd = "apt-get update && apt-get dist-upgrade -y && apt-get autoclean"
		exec(cmd)
	end
end
