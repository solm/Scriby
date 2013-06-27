class Scriby < EventMachine::Connection
	attr_reader :queue

	def initialize(q)
		@queue = q
		relay(@queue)
	end

	def post_init
		@queue.push("CAP REQ acc-notify")
		@queue.push("PASS #{$config['server_pass']}") if $config['server_pass']
		@queue.push("USER #{$config['nick']} 0 * :#{$config['real_name']}")
		@queue.push("NICK #{$config['nick']}")
		@queue.push("CAP END")
	end

	def receive_data(data)
		pong(data) if data =~ /PING :(.*)/ # Check for ping
		on_startup if data =~ /:(.*) 376 (.*) :End of \/MOTD command./

		# Check for triggers
		/:(.*) (.*) (.*) :(.*)/.match(data)
		check_msg = $4
		hostmask = /(.*)!(.*)@(.*)/.match($1)
		nick = $1.to_s.downcase
		$trigtrig = $triggers.dup
		$trigtrig.each do |trig, block|
			if check_msg =~ trig
				begin
					block.call(Bot.new(@queue), Message.new(data, trig))
				rescue => e
					bot.msg "Error Occurred: #{e.msg}", $3
				end
			end
		end
		if $on_actives.keys.include? nick
			$on_actives[nick].each do |array|
				begin
					array[0].call(Bot.new(@queue), Message.new(data, ''))
				rescue => e
					bot.msg "Error Occurred: #{e.msg}", $3
				end
			end
		end

		puts data
	end

	def send_data(data)
		data << "\r\n"
		puts ">>> #{data}"
		super data
	end

	def unbind
		puts 'Yikes, connection totally closed!'
	end

	def pong(data)
		/PING :(.*)/.match data
		@queue.push "PONG :#{$1}"
	end

	def relay(q)
		cb = Proc.new do |msg|
			send_data(msg)
			q.pop &cb
		end

		q.pop &cb
	end

	def on_startup
		$config['channels'].each do |channel|
			@queue.push("JOIN ##{channel}")
		end
		@queue.push("PRIVMSG NickServ :#{$config['ident_pass']}")
	end

end
