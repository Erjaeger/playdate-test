import "elements/scoreDisplayer"
import "elements/ball"
import "elements/player"
import "elements/wall"

local pd <const> = playdate
local gfx <const> = pd.graphics

ballCount = 0

class("GameScene").extends(gfx.sprite)

function GameScene:init()
    GameScene.super.init(self)
	self:launchGame()
end

function GameScene:drawGameScreen()
	-- Top / Bottom wall
	Wall(0, 0, 400, 6)
	Wall(0, 234, 400, 6)

	-- Left / Right wall
	Wall(0, 0, 6, 240, true)
	Wall(394, 0, 6, 240, true)
end

function GameScene:launchGame()
	gfx.clear(gfx.kColorBlack)
	self:drawGameScreen()
	createScoreDisplayer()
	self.ball = Ball()
	Player(10, false)
	self.enemy = Player(380, true)
	self:add()
end

function GameScene:update()
	local errorPourcentage = 0.7
	if self.ball.y < (self.enemy.y + self.enemy.h / 2) and math.random() > errorPourcentage then
		self.enemy:moveUp()
	elseif self.ball.y > (self.enemy.y + self.enemy.h / 2) and math.random() > errorPourcentage then
		self.enemy:moveDown()
	end
	updateDisplayer()

	if ballCount == 0 then
		self:newBall()
	end

	if playdate.buttonJustPressed(playdate.kButtonB) then
		SCENE_MANAGER:switchScene(LaunchMenu)
	end
end

function GameScene:newBall()
	self.ball = Ball()
end
