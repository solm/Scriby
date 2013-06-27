on :regex, /^\.help/ do |bot, m|
	bot.msg "Commands are #{$commands}.", m.location
end