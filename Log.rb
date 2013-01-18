module Log

	def logger
		Log.logger
	end

	def self.logger
		#@logger ||= Logger.new(STDOUT)
		@logger ||= Logger::new("log/vn.log",'daily')
	end
end