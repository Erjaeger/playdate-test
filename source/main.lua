import "CoreLibs/sprites"
import "CoreLibs/object"
import "CoreLibs/graphics"

import "wall"
import "ball"
import "player"
import "scoreDisplayer"

local gfx <const> = playdate.graphics
local enemy = nil
local ball = nil
local scoreDisplayer = nil

function drawGameScreen()
	-- Top / Bottom wall
	Wall(0, 0, 400, 6)
	Wall(0, 234, 400, 6)

	-- Left / Right wall
	Wall(0, 0, 6, 240, true)
	Wall(394, 0, 6, 240, true)
end

function init()
	math.randomseed(playdate.getSecondsSinceEpoch())
	drawGameScreen()
	createScoreDisplayer()
	ball = Ball()
	Player(10, false)
	enemy = Player(380, true)

	gfx.setBackgroundColor(gfx.kColorBlack)
end

init()

function newBall()
	ball = Ball()
end

function playdate.update()
	gfx.clear(gfx.kColorBlack)

	local errorPourcentage = 0.7
	if ball.y < (enemy.y + enemy.h / 2) and math.random() > errorPourcentage then
		enemy:moveUp()
	elseif ball.y > (enemy.y + enemy.h / 2) and math.random() > errorPourcentage then
		enemy:moveDown()
	end

	gfx.sprite.update()
	updateDisplayer()
end
