local gfx <const> = playdate.graphics
local scoreSprite
local scoreEnemy = 0
local scorePlayer = 0

function createScoreDisplayer()
    scoreSprite = gfx.sprite.new()
    scorePlayer = 0
    scoreEnemy = 0
    updateDisplayer()
    scoreSprite:setCenter(0, 0)
    scoreSprite:add()
end

function updateScoreEnemy()
    scoreEnemy += 1
    updateDisplayer()
end

function updateScorePlayer()
    scorePlayer += 1
    updateDisplayer()
end

function updateDisplayer()
    local score = scorePlayer .. ' : ' .. scoreEnemy
    local wText, hText = gfx.getTextSize(score)
    scoreSprite:moveTo((200 - wText / 2), 30)
    local imgText = gfx.image.new(wText, hText)
    gfx.pushContext(imgText)
    gfx.setImageDrawMode(gfx.kDrawModeInverted)
    gfx.drawText(score, 0, 0)
    gfx.popContext()
    scoreSprite:setImage(imgText)
end
