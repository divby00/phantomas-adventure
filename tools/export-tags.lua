-- This Aseprite script is useful to save the tags from an image in separate files.
-- It's heavily based on https://github.com/StarJackal57/Aseprite-Export-Tags but it's designed
-- to be used from the command line.

local img = app.open(app.params["input"])

local function split_filename(filename)
	return string.match(filename, "(.-)([^\\]-([^\\%.]+))$")
end

local function find(str, match, startIndex)
	if not match then return nil end
	str = tostring(str)
	local _ = startIndex or 1
	local _s = nil
	local _e = nil
	local _len = match:len()
	while true do
		local _t = str:sub( _ , _len + _ - 1)
		if _t == match then
			_s = _
			_e = _ + _len - 1
			break
		end
		_ = _ + 1
		if _ > str:len() then break end
	end
	if _s == nil then return nil else return _s, _e end
end

local function seperate(str, divider)
	if not divider then return nil end
	str = tostring(str)
	local start = {}
	local endS = {}
	local n=1
	repeat
		if n==1 then
			start[n], endS[n] = find(str, divider)
		else
			start[n], endS[n] = find(str, divider, endS[n-1]+1)
        end
		n=n+1
	until start[n-1]==nil
	local subs = {}
	for n=1, #start+1 do
		if n==1 then
			subs[n] = str:sub(1, start[n]-1)
		elseif n==#start+1 then
			subs[n] = str:sub(endS[n-1]+1)
		else
			subs[n] = str:sub(endS[n-1]+1, start[n]-1)
        end
	end
	return subs
end

local function replace(str, from, to)
	if not from then return nil end
	str = tostring(str)
	local pcs = seperate(str, from)
	str = pcs[1]
	for n=2,#pcs do
		str = str..to..pcs[n]
	end
	return str
end

tags_found = #img.tags
if tags_found > 0 then
    for i, tag in ipairs(img.tags) do
        local frames_count = tag.frames
        local new_img = Image(img.width * frames_count, img.height)

        for j = 0, frames_count do
            local p = Point(img.width * j, 0);
            new_img:drawSprite(img, tag.fromFrame.frameNumber + j, p)
        end
        local path, file, ext = split_filename(app.params["input"])
        filename = replace(file, "." .. ext, "")
        new_img:saveAs(path .. filename:lower() .. "-" .. tag.name:lower() .. ".png")
    end
else
    print("The image " .. app.params["input"] .. " doesn't contain any tag.")
    return
end

