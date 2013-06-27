class Message
	attr_reader :hostmask, :type, :location, :message, :match, :nick, :realname, :hostname, :trig

	def initialize(data, trig)
		/:(.*) (.*) (.*) :(.*)/.match data
		@hostmask, @type, @location, @message = $1, $2, $3, $4
		@match = @message.scan(trig)[0]

		/(.*)!(.*)@(.*)/.match @hostmask
		@nick, @realname, @hostname = $1, $2, $3

		@trig = trig
	end

	def admin?
		if $config['admins'].include? @nick
			return true
		else
			return false
		end
	end
end