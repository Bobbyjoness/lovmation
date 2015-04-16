lovmation = require("lovmation")

naruto = love.graphics.newImage("naruto_sheet.png")

quad = {} 

w = 25
h = 32

quad[1] = love.graphics.newQuad( 0, 0, w, h, naruto:getWidth(), naruto:getHeight() )
quad[2] = love.graphics.newQuad( w*1, 0, w,h, naruto:getWidth(), naruto:getHeight() )
quad[3] = love.graphics.newQuad( w*2, 0, w, h, naruto:getWidth(), naruto:getHeight() )
--quad[4] = love.graphics.newQuad( w*3, 0, w, h, naruto:getWidth(), naruto:getHeight() )

framerate = .75
timer = 0 

s = 1

function love.update(dt)

	timer = timer + 1*dt
	if timer>framerate then
		s = s + 1
		if s >3 then
			s = 1
		end
		timer = 0
	end

end

function love.draw( )
	love.graphics.draw( naruto, quad[s], 0,0, 0, -5, 5)
end