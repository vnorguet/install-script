class Apt
#	attr_accessible packageList
	
	def loadFromXml (xmlFilePath)
		
	end
	
	def install
		Log::logger.info( "installing packages from xml...")
		cmd = 'apt-get install '.packageList.map{|pack| pack.to_s}.join(" ")
		exec(cmd)
	end

	def upgrade
		Log::logger.error( "updating system packages...")
		cmd = "apt-get update && apt-get dist-upgrade -y && apt-get autoclean"
		exec(cmd)
	end
end
