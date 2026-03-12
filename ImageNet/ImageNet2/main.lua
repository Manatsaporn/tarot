local myImg

local function loadImageListener(event)
	if (event.isError or event.status ~= 200) then
		print("ERROR code = " .. event.status)
	else
		if (myImg) then
			myImg:removeSelf()
			myImg = nil
		end
		myImg = display.newImage(
			event.response.filename, 
			event.response.baseDirectory, 
			display.contentCenterX,
			display.contentCenterY
		)
	end
end

local params = {}
display.setDefault("background", 1, 1, 1)
network.download(
	"http://www.phuketsmartcity.com/files/images/flag/" .. math.random(1, 230) .. ".png",
	"GET",
	loadImageListener,
	params,
	"flag.png",
	system.TemporaryDirectory
)