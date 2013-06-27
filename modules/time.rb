require 'date'

on :cmd, 't', 'time' do |bot, m|
	timezone = m.match[0]
	d = DateTime.now
	d2 = d.new_offset(timezone)
	bot.reply m, d2.strftime('%H:%M:%S')
end