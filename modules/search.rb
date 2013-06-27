require 'open-uri'

on :cmd, 'google', 'g' do |bot, m|
	query = URI::encode(m.match[0])
	response = JSON.parse(open("https://ajax.googleapis.com/ajax/services/search/web?v=1.0&safe=off&q=#{query}").read)
	results = response["responseData"]["results"]
	answer = results[0]

	bot.msg "#{answer['title'].gsub(/<b>|<\/b>/,'')}: #{answer['content'].gsub(/<b>|<\/b>/,'')} #{answer['url']}", m.location
end