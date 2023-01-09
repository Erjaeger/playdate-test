import "CoreLibs/timer"

local gfx <const> = playdate.graphics
local spriteTransition = nil
class('SceneManager').extends()

function SceneManager:drawTransition()
    self:cleanupScene()
    local rectangleWidth = 0
    spriteTransition = gfx.sprite.new()
    local imageTransition = gfx.image.new(400, 240)
    gfx.pushContext(imageTransition)
    gfx.setImageDrawMode(gfx.kDrawModeInverted)
    gfx.drawTextAligned("Loading . . . ", 200, 120, kTextAlignment.center)
    gfx.drawRect(0 , 0, rectangleWidth, 240)
    gfx.popContext()
    spriteTransition:setImage(imageTransition)
    spriteTransition:moveTo(200, 120)
    spriteTransition:add()
end

function SceneManager:switchScene(scene)
    if self.scene ~= nil and self.scene.saveStatusBeforePause ~= nil then
        self.initScene:saveStatusBeforePause()
    end
    
    self:drawTransition()
    playdate.timer.performAfterDelay(500, function ()
        self.scene = scene
        self:loadNewScene()
        spriteTransition:remove()
    end)
    
end

function SceneManager:loadNewScene()
    self.initScene = self.scene()
end

function SceneManager:cleanupScene()
    gfx.sprite.removeAll()
    gfx.clear(gfx.kColorBlack)
    gfx.setDrawOffset(0, 0)
end
