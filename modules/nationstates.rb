on :cmd, 'region', 'reg', 'r' do |bot, m|
	bot.reply m, "http://www.nationstates.net/region=#{m.match[0].gsub(" ","_")}"
end

on :cmd, 'nation', 'nat', 'n' do |bot, m|
	bot.reply m, "http://www.nationstates.net/nation=#{m.match[0].gsub(" ","_")}"
end

on :cmd, 'dossier', 'dos', 'd' do |bot, m|
	bot.reply m, "http://www.nationstates.net/page=dossier?action=add&nation=#{m.match[0].gsub(" ","_")}"
end