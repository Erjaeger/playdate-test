local gfx <const> = playdate.graphics

class("ScoreDisplayer").extends(gfx.sprite)

function ScoreDisplayer:init()
    ScoreDisplayer.super.init(self);

    self.scorePlayer = 0
    self.scoreEnemy = 0
    self:updateDisplayer()
    self:setCenter(0,0)
    
    self:add()
end

function ScoreDisplayer:updateDisplayer()
    local score = self.scorePlayer .. ' : ' .. self.scoreEnemy
    local wText, hText = gfx.getTextSize(score)
    self:moveTo((200-wText/2), 30)
    print(wText, hText)
    local imgText = gfx.image.new(wText, hText)
    print('SCORE : ' .. score)
    gfx.pushContext(imgText)
    gfx.setImageDrawMode(gfx.kDrawModeInverted)
    gfx.drawText(score, 0, 0)
    gfx.popContext()
    self:setImage(imgText)
end


function ScoreDisplayer:UpdateScoreEnemy()
    self.scoreEnemy += 1
    self:updateDisplayer()
end

function ScoreDisplayer:UpdateScorePlayer()
    self.scorePlayer += 1
    self:updateDisplayer()
end