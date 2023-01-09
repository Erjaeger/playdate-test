import "elements/scoreDisplayer"
import "elements/ball"
import "elements/player"
import "elements/wall"

local pd <const> = playdate
local gfx <const> = pd.graphics

local saveStatusGame = {
    player1 = {
        x = nil,
        y = nil,
    },
    player2 = {
        x = nil,
        y = nil,
    },
    ball = {
        x = nil,
        y = nil
    }
}

ballCount = 0

class("GameScene").extends(gfx.sprite)

function GameScene:init()
    GameScene.super.init(self)
	print("Game Scene Init")
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

	local ballX = saveStatusGame["ball"]["x"]
	local ballY = saveStatusGame["ball"]["y"]
	local ballXVel = saveStatusGame["ball"]["xVel"]
	local ballYVel = saveStatusGame["ball"]["yVel"]
	
	self.ball = Ball(ballX, ballY, ballXVel, ballYVel)
	

	local pX = saveStatusGame["player1"]["x"]
	local pY = saveStatusGame["player1"]["y"]
	self.player = Player(pX ~= nil and pX or 10 , pY ~= nil and pY or 100, false)

	
	local pX2 = saveStatusGame["player2"]["x"]
	local pY2 = saveStatusGame["player2"]["y"]
	self.enemy = Player(pX2 ~= nil and pX2 or 380 , pY2 ~= nil and pY2 or 100, true)
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
		-- self:saveStatusBeforePause()
	end
end

function GameScene:newBall()
	print('newBall ?')
	self.ball = Ball(nil, nil)
end

function GameScene:getPlayer()
	return self.player.x
end
function GameScene:saveStatusBeforePause()
	saveStatusGame["player1"]["x"] = self.player.x
	saveStatusGame["player1"]["y"] = self.player.y
	saveStatusGame["player2"]["x"] = self.enemy.x
	saveStatusGame["player2"]["y"] = self.enemy.y
	saveStatusGame["ball"]["x"] = self.ball.x
	saveStatusGame["ball"]["y"] = self.ball.y
	saveStatusGame["ball"]["xVel"] = self.ball.xVelocity
	saveStatusGame["ball"]["yVel"] = self.ball.yVelocity
end
