class Installer
	def main
		
	end

	def install (packageName)
		cmd = 'apt-get install '.packageName
		exec(cmd)
	end
end
