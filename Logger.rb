module Log

	def logger
		Log.logger
	end

	def self.logger
		@logger ||= Logger.new(STDOUT)
	end
end