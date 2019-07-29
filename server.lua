-- todo: zapis do bazy danych

function getAchievementDivision(data, amount)
	local toReturn = {}
	for k, v in pairs(data) do
		if amount >= v[1] then
			table.insert(toReturn, k)
		end
	end
	return takeBiggestDivision(toReturn)
end

function takeBiggestDivision(tbl)
	for k, v in ipairs(divisions) do
		if table.find(tbl, v) then
			return v
		end
	end
end

function getPlayerAchievement()
	-- @todo
	return false
end

function addAchievement(player, achievement_name, amount)
	local achievement_data = achievements_list[achievement_name] 
	if achievement_data then
		local division = getAchievementDivision(achievement_data, amount)
		if not division then
			return
		end

		-- dodać sprawdzanie czy gracz odblokował już ten achievement
		if not getPlayerAchievement(player, achievement_name, division) then
			triggerClientEvent(player, "showPlayerAchievement", player, achievement_name, achievement_data[division][2], division)
		end
	end
end

--[[
	przykład użycia:
	addAchievement(player, "Bez auta ani rusz", getPlayerCars(player))
]]