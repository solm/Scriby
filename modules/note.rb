on :cmd, 'note', 'tell' do |bot, m|
	match = /(.*?) (.*)/.match(m.match[0])
	recipient = $1.to_s.downcase
	body = $2
	timestamp = Time.now
	sender = m.nick

	bot.msg "I'll send that note as soon as I see #{recipient.capitalize}", m.location

	on :active, timestamp.to_i, recipient do |bot, m|
		bot.reply m, "#{sender} left you a note at #{timestamp.strftime('%H:%M, %-m/%-d/%y')}: #{body}"
		$on_actives[recipient].delete_if { |value| value[1] == timestamp.to_i }
	end
end
