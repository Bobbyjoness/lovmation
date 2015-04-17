Lovmation = require("lovmation")

naruto = love.graphics.newImage("naruto_sheet.png")

narutos = love.graphics.newSpriteBatch( naruto )

playerState = "standing-forwards"

playerFacing = "forwards"

playerX = 0

playerY = 0

lovmation = Lovmation()

lovmation:init( 24, 32, naruto:getWidth(), naruto:getHeight(), 4, 3 )

lovmation:addSpriteBatch( narutos )

lovmation:newSequence("standing-right", {5}, 0.5 )

lovmation:newSequence("walking-right", {4,6}, 0.5 )

lovmation:newSequence("standing-forwards", {8}, 0.5 )

lovmation:newSequence("walking-forwards", {7,9}, 0.5 )

lovmation:newSequence("standing-back", {2}, 0.5 )

lovmation:newSequence("walking-back", {1,3}, 0.5 )

lovmation:newSequence("standing-left", {11}, 0.5 )

lovmation:newSequence("walking-left", {10,12}, 0.5 )

function love.update(dt)
	lovmation:updateSequence( playerState, dt*2 )

	if love.keyboard.isDown( "d" ) then

		playerX = playerX + 20*dt

		playerFacing = "right"

		playerState = "walking-right"

	elseif love.keyboard.isDown( "a" ) then

		playerX = playerX - 20*dt

		playerFacing = "left"

		playerState = "walking-left"
	
	elseif love.keyboard.isDown( "w" ) then

		playerY = playerY - 20*dt

		playerFacing = "back"

		playerState = "walking-back"

	elseif love.keyboard.isDown( "s" ) then

		playerY = playerY + 20*dt	

		playerFacing = "forwards"

		playerState = "walking-forwards"

	else 

		playerState = "standing-"..playerFacing

	end

end

function love.draw( )
	lovmation:drawSequence( playerState, playerX, playerY )

	love.graphics.draw( narutos )
end