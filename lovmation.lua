local lovmation = {}

lovmation.__index = lovmation

local function new()
  return setmetatable({}, lovmation)
end

--can only handle uniform quad sizes
-- frames are numbered from left to right and carry overs on to the next row.
--[[ example:
	|1|2|3|
	|4|5|6|
	|7|8|9|
--]]

function lovmation:init(  qwidth, qheight, iwidth, iheight, rows, columns  )
	self.frames = {}
	local rows = rows or iwidth/qwidth
	local columns = columns or qheight/iheight
	local frameCount = 1
	for i = 0, rows - 1 do
		for j = 0, columns - 1 do
			self.frames[frameCount] = {} -- use a table so we can add "user data" for each frame.
			self.frames[frameCount].quad = love.graphics.newQuad( j*qwidth, i*qheight, qwidth, qheight, iwidth, iheight )
		end
	end

end

function lovmation:newSequence( )


function lovmation:update( dt )

end

function lovmation:draw()

end


return setmetatable({new = new},
{__call = function(_, ...) return new(...) end})