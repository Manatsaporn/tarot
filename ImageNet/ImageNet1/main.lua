local function loadImageListener(event)
	if (event.isError or event.status ~= 200) then
		print("ERROR code = " .. event.status)
	else
		print(event.response.filename)
		print(event.response.baseDirectory)
	end
end

local params = {}
network.download(
	"http://www.phuketsmartcity.com/files/images/flag/1.png",
	"GET",
	loadImageListener,
	params,
	"flag.png",
	system.TemporaryDirectory
)