class Bot
	include EM::Protocols::LineText2
	attr_reader :queue

	def initialize(q)
		@queue = q
	end

	def msg(message, location)
		@queue.push("PRIVMSG #{location} :#{message}")
	end

	def reply(m, message)
		@queue.push("PRIVMSG #{m.location} :#{m.nick}: #{message}")
	end
end