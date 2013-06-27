on :cmd, 'reload' do |bot, m|
	bot.msg "#{m.match[0]} not loaded!", m.location
end