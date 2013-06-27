class KeyboardHandler < EM::Connection
	include EM::Protocols::LineText2

	attr_reader :queue

	def initialize(q)
		@queue = q
	end

	def receive_line(data)
		@queue.push(data)
	end
end