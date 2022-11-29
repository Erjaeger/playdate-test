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
	Wall(0, 0, 400, 6)
	Wall(0, 234, 400, 6)
end

function init()
	math.randomseed(playdate.getSecondsSinceEpoch())
	drawGameScreen()
	scoreDisplayer = ScoreDisplayer()
	ball = Ball()
	Player(10, false)
	enemy = Player(380, true)

	gfx.setBackgroundColor(gfx.kColorBlack)
end

init()

function playdate.update()
	gfx.clear(gfx.kColorBlack)
	if ball.y < (enemy.y + enemy.h / 2) then
		enemy:moveUp()
	elseif ball.y > (enemy.y + enemy.h / 2) then
		enemy:moveDown()
	end

	gfx.sprite.update()
	scoreDisplayer:updateDisplayer()
end
