import "CoreLibs/timer"

local gfx <const> = playdate.graphics

class('SceneManager').extends()

function SceneManager:drawTransition()
    local rectangleWidth = 0
    -- local drawTimer = playdate.timer.keyRepeatTimer(function()
    --     playdate.graphics.setColor(playdate.graphics.kColorWhite)
    --     gfx.drawRect(0, 0, rectangleWidth, 240)
    --     rectangleWidth += 2
    -- end)

    -- print(rectangleWidth)
    -- if rectangleWidth >= 400 and drawTimer then
    --     drawTimer:remove()
    --     self:loadNewScene()
    -- end
end

function SceneManager:switchScene(scene)
    self.newScene = scene
    self:drawTransition()
    self:loadNewScene()
end

function SceneManager:loadNewScene()
    self:cleanupScene()
    self.newScene()
end

function SceneManager:cleanupScene()
    gfx.sprite.removeAll()
    gfx.clear()
    gfx.setDrawOffset(0, 0)
end
