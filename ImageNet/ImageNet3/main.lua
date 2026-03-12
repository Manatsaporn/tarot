local flagImg, flagTxt
local options
local flag, cx, cy

local function loadImageListener(event)
	if (not event.isError) then
		if (flagImg) then
			flagImg:removeSelf()
			flagImg = nil
		end
		flagImg = display.newImage(
			event.response.filename, 
			event.response.baseDirectory, 
			cx,
			cy - 50
		)
	end
end

local function loadTextListener(event)
	if (not event.isError) then
		flagTxt.text = event.response
	end
end

local function randomFlag()
	flag = math.random(1, 100)
	network.download(
		"http://www.phuketsmartcity.com/files/images/flag/" .. flag .. ".png",
		"GET",
		loadImageListener,
		{},
		flag .. ".png",
		system.TemporaryDirectory
	)
	network.request(
		"http://www.phuketsmartcity.com/files/images/flag/" .. flag .. ".txt", 
		"GET", 
		loadTextListener
	)
end

local function touchImage(event)
	if (event.phase == "began") then
		randomFlag()
	end
end

cx = display.contentCenterX
cy = display.contentCenterY

options = {
	text = "",
	x = cx,
	y = 370,
	width = display.contentWidth - 50,
	height = 180,
	font = "Arial",   
	fontSize = 30,
	align = "center"
}

display.setDefault("background", 1, 1, 1)
flagTxt = display.newText(options)
flagTxt:setTextColor(0, 0, 0)
Runtime:addEventListener("touch", touchImage)
randomFlag()