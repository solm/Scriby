on :cmd, 'decide', 'choose' do |bot, m|
	answer = m.match[0].split('|').sample
	bot.msg answer, m.location
end