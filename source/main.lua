import "CoreLibs/sprites"
import "CoreLibs/object"
import "CoreLibs/graphics"

local stateGameEnum = { RUNNING = 0, PAUSED = 1, LAUNCHED = 2 }
local stateGame = stateGameEnum.PAUSED

import "wall"
import "ball"
import "player"
import "scoreDisplayer"
import "menu"

local gfx <const> = playdate.graphics
local enemy = nil
local ball = nil
local scoreDisplayer = nil
local sprite
local selectedItem = 1


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
	initMenuStartGame()
	gfx.setBackgroundColor(gfx.kColorBlack)
end

function launchGame()
	gfx.clear(gfx.kColorBlack)
	stateGame = stateGameEnum.RUNNING
	drawGameScreen()
	createScoreDisplayer()
	ball = Ball()
	Player(10, false)
	enemy = Player(380, true)
end

function newBall()
	ball = Ball()
end

function updateGame()
	local errorPourcentage = 0.7
	if ball.y < (enemy.y + enemy.h / 2) and math.random() > errorPourcentage then
		enemy:moveUp()
	elseif ball.y > (enemy.y + enemy.h / 2) and math.random() > errorPourcentage then
		enemy:moveDown()
	end
	updateDisplayer()

	if playdate.buttonJustPressed(playdate.kButtonB) then
		stateGame = stateGameEnum.PAUSED
	end
end

function playdate.update()
	gfx.clear(gfx.kColorBlack)
	if stateGame == stateGameEnum.PAUSED then
		updateMenu()
	elseif stateGame == stateGameEnum.RUNNING then
		updateGame()
	end

	gfx.sprite.update()
end

local items = {
	{
		Jouer = function()
			-- print("okay")
			gfx.setBackgroundColor(gfx.kColorBlack)
			launchGame()
		end
	},
	{ Options = function()

	end
	}
}

function initMenuStartGame()
	sprite = gfx.sprite.new()
	local wTextMax = 0
	local hTextMax = 0
	for index, value in ipairs(items) do
		for key, value in pairs(value) do
			local wText, hText = gfx.getTextSize(key)
			if wText > wTextMax then
				wTextMax = wText
			end
			hTextMax += hText
		end
	end

	hTextMax += 20
	local imgText = gfx.image.new(wTextMax, hTextMax)
	gfx.pushContext(imgText)
	gfx.clear(gfx.kColorBlack)
	gfx.setImageDrawMode(gfx.kDrawModeInverted)
	local lastHText = 0

	for index, value in ipairs(items) do
		for key, valueItems in pairs(value) do

			local _, hText = gfx.getTextSize(key)
			local text = key
			if index == selectedItem then
				text = "*" .. key .. "*"
			end
			gfx.drawText(text, 0, hText + lastHText)
			lastHText += 20
		end
	end

	gfx.popContext()
	sprite:setImage(imgText)
	sprite:moveTo(150, 100)
	sprite:add()

end

function updateMenu()
	if playdate.buttonJustPressed(playdate.kButtonDown) then
		if selectedItem == #items then
			selectedItem = 1
		else
			selectedItem += 1
		end
		initMenuStartGame()
	end

	if playdate.buttonJustPressed(playdate.kButtonUp) then
		if selectedItem == 1 then
			selectedItem = #items
		else
			selectedItem -= 1
		end
		initMenuStartGame()
	end

	if playdate.buttonJustPressed(playdate.kButtonA) then
		for key, value in pairs(items[selectedItem]) do
			value()
			sprite:remove()
		end
	end
end

init()
