local sx, sy = guiGetScreenSize()
local queue = {}
local actualAchievement = 1
local zoom = sx == 1920 and 1 or math.min(2, 1920/sx)
local header = GUI.getFont("bold", 22/zoom)
local desc = GUI.getFont("regular", 18/zoom)
addEvent("showPlayerAchievement", true)

SHOW_TIME = 4500

local positions = {
	x = math.floor(sx / 2 - ((717/2) / zoom)),
	y = math.floor(75/zoom),
	w = math.floor(717/zoom),
	h = math.floor(140/zoom),
}

local background = dxCreateTexture("img/background.png", "argb", true, "clamp")
local y = 0
local alpha = 255

function render_achievements()
	print(actualAchievement, queue[actualAchievement])
	if queue[actualAchievement] then
		if (getTickCount() - queue[actualAchievement].time < SHOW_TIME + 1000) and queue[actualAchievement].show then -- 1000 to czas obu animacji (500 + 500)
			dxDrawImage(positions['x'], positions['y'] + y/zoom, positions['w'], positions['h'], background, 0, 0, 0, tocolor(255, 255, 255, alpha))
			dxDrawImage(positions['x'] + 30/zoom, positions['y'] + 15/zoom + y/zoom, 100/zoom, 100/zoom, "img/"..queue[actualAchievement]['division']..".png", 0, 0, 0, tocolor(255, 255, 255, alpha))
			dxDrawText(queue[actualAchievement]['name'], positions['x'] + 128/zoom, positions['y'] + 10/zoom + y/zoom, positions['w']+positions['x'] - 30/zoom, positions['h'] + y/zoom, tocolor(255, 255, 255, alpha), 1, header, "center", "top")
			dxDrawText(queue[actualAchievement]['desc'], positions['x'] + 128/zoom, positions['y'] + 50/zoom + y/zoom, positions['w']+positions['x'] - 30/zoom, positions['h'] + y/zoom, tocolor(255, 255, 255, alpha), 1, desc, "center", "top", false, true)
		else
			queue[actualAchievement].show = false
			actualAchievement = actualAchievement + 1

			if not queue[actualAchievement] then
				table.remove(queue, 1)
				actualAchievement = 1
			else
				queue[actualAchievement].time = getTickCount()
				startAnimate()
			end
		end
	end
end
addEventHandler("onClientRender", root, render_achievements)

function startAnimate()
	animate(-45, 0, "OutQuad", 500, function(_y)
			y = _y
			alpha = ((45-math.abs(y))/45)*255
	end, function()
	setTimer(function()
			animate(0, 45, "OutQuad", 500, function(_y) 
				y = _y
				alpha = 255-((y/45)*255)
			end)
		end, SHOW_TIME, 1)
	end)
end

addEventHandler("showPlayerAchievement", root, function(name, desc, division)
	table.insert(queue, {show = true, name = name, desc = desc, division = division, time = getTickCount()})
	startAnimate()
end)