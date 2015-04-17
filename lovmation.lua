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

			frameCount = frameCount + 1

		end

	end

	self.sequence = {}

	self.currentSequence = nil -- denotes the currntly updating sequence. Internal use only.

	self.currentFrame    = 1

	self.currentSequence = ""

end

-- These functions should only be use once.

function lovmation:addImage( image )

	assert(image:typeOf("Image"), "Need to pass in an Image")

	self.image = image

	self.spritebatch = nil

end

function lovmation:addSpriteBatch( SpriteBatch )

	assert(SpriteBatch:typeOf("SpriteBatch"), "Need to pass in an SpriteBatch")

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

function lovmation:newSequence( sequenceName, quads, delay ) 

	self.sequence[sequenceName] = {}

	self.sequence[sequenceName].quads = quads

	self.sequence[sequenceName].currentFrame = #self.sequence[sequenceName].quads

	self.sequence[sequenceName].delay = delay or 0.5

	self.sequence[sequenceName].timer = 0

end

function lovmation:updateSequence( sequenceName, dt )

	self.sequence[sequenceName].timer = self.sequence[sequenceName].timer + dt

	if self.sequence[sequenceName].timer > self.sequence[sequenceName].delay then

		self.sequence[sequenceName].timer = 0 

		if self.sequence[sequenceName].currentFrame == #self.sequence[sequenceName].quads then 

			self.sequence[sequenceName].currentFrame = 1

		else 

			self.sequence[sequenceName].currentFrame = self.sequence[sequenceName].currentFrame + 1

		end

	end

end
--[[
	sequenceName is the name of the sequence you would like to draw
	if this uses a spritebatch then it alone will not draw the sprite must draw the spritebatch your self.
--]]
function lovmation:drawSequence( sequenceName, x, y, r, sx, sy, ox, oy, kx, ky )
	local currentFrame = self.sequence[sequenceName].currentFrame
	local quads = self.sequence[sequenceName].quads
	local quad  = self.frames[quads[currentFrame]].quad

	if self.image then

		love.graphics.setColor( 255, 255, 255, 255 )

		love.graphics.draw(self.image, quad, x, y, r, sx, sy, ox, oy, kx, ky )

	elseif self.spritebatch then

		self.spritebatch:setColor( 255, 255, 255, 255 )

		self.spritebatch:set( self.id, quad, x, y, r, sx, sy, ox, oy, kx, ky )

	end

end


return setmetatable({new = new},
{__call = function(_, ...) return new(...) end})