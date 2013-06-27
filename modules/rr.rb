$rr_a = ['Click', 'Click', 'Click', 'Click', 'Click', 'BOOM! YOU ARE DEAD! DEAD!'].shuffle
on(/^\.rr/) do |bot, m|
	if $rr_a.count < 1
		$rr_a = ['Click', 'Click', 'Click', 'Click', 'Click', 'BOOM! YOU ARE DEAD! DEAD!']
	end
	answer = $rr_a.pop
	bot.reply m, answer
end