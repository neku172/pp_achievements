achievements_list = {
	['Bez auta ani rusz'] = {
		['hidden'] = {1, 'Gratulujemy! Zakupiłeś swój pierwszy pojazd. Życzymy miłej jazdy.'}, 
		['bronze'] = {3, 'Gratulujemy! Zakupiłeś swój trzeci pojazd. Życzymy miłej jazdy.'}, 
		['silver'] = {5, 'Gratulujemy! Zakupiłeś swój piąty pojazd. Życzymy miłej jazdy.'}, 
		['gold'] = {10, 'Gratulujemy! Zakupiłeś swój dziesiąty pojazd. Życzymy miłej jazdy.'}, 
	},
}

divisions = {
	"gold",
	"silver",
	"bronze",
	"hidden",
}

function table.find(t, v)
	for k, a in ipairs(t) do
		if a == v then
			return k
		end
	end
	return false
end

function getAchievementList()
	return achievements_list
end