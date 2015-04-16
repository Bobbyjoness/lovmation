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

	self.sequence = {}

	self.currentSequence = nil -- denotes the currntly updating sequence. Internal use only.
	self.currentFrame    = 1

end

-- These functions should only be use once.

function lovmation:addImage( image )

	assert(image:typeOf("Image"), "Need to pass in an Image")

	self.image = image

	self.spritebatch = nil

end

function lovmation:addSpriteBatch( SpriteBatch )

	assert(image:typeOf("SpriteBatch"), "Need to pass in an SpriteBatch")

	self.spritebatch = SpriteBatch

	self.spritebatch:setColor(0,0,0,0)

	self.id = self.spritebatch:add( self.frames[1].quad, 0, 0 )

	self.image = nil

end

--[[
	frames is an array listing frames
	the index represents the order
	the name is how you reference the sequence
--]]

function lovmation:newSequence( sequenceName, frames, delay ) 

	self.sequence[sequenceName] = {}

	self.sequence[sequenceName].frames = frames

	self.sequence[sequenceName].delay = delay or 0.5

	self.sequence[sequenceName].timer = 0

end

function lovmation:updateSequence( sequenceName, dt )

	self.sequence[sequenceName].timer = self.sequence[sequenceName].timer + dt

	if  self.sequence[sequenceName].timer > self.sequence[sequenceName].delay then

	end




end
--[[
	sequenceName is the name of the sequence you would like to draw
	if this uses a spritebatch then it alone will not draw the sprite must draw the spritebatch your self.
--]]
function lovmation:drawSequence( sequenceName, x, y, flipx, flipy, r, sx, sy, ox, oy, kx, ky )



end


return setmetatable({new = new},
{__call = function(_, ...) return new(...) end})