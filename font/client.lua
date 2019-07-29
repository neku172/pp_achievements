local fonts = {}
GUI = {}

GUI.getFont = function(name, size)
	if not fonts[name] then
		fonts[name] = {}
		fonts[name].small = dxCreateFont("font/"..name..".ttf", 10, false, "antialiased")
		fonts[name].normal = dxCreateFont("font/"..name..".ttf", 17, false, "antialiased")
		fonts[name].big = dxCreateFont("font/"..name..".ttf", 24, false, "antialiased")
		fonts[name].huge = dxCreateFont("font/"..name..".ttf", 32, false, "antialiased")
	end
	
	if type(size) == "number" then
		if not fonts[name][size] then
			fonts[name][size] = dxCreateFont("font/"..name..".ttf", size, false, "antialiased")
		end
	end
	return fonts[name][size] or "default-bold"
end