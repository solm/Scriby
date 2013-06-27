on :regex, /#{$config['nick']}!/ do |bot, m|
	bot.msg "#{m.nick}!", m.location
end

on :regex, /^Kill me, #{$config['nick']}/, /^#{$config['nick']}, kill me/ do |bot, m|
	bot.msg "\001ACTION gets out a machete and slashes #{m.nick}!", m.location
end