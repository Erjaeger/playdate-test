local gfx <const> = playdate.graphics

class("LaunchMenu").extends(gfx.sprite)

function LaunchMenu:init()
    LaunchMenu.super.init(self)
    self.selectedItem = 1
    self.items = {
        {
            Jouer = function()
                SCENE_MANAGER:switchScene(GameScene)
            end
        },
        { Options = function()
        end
        }
    }
    self:drawMenuStartGame()
    self:add()
end

function LaunchMenu:update()
    gfx.clear(gfx.kColorBlack)
    if playdate.buttonJustPressed(playdate.kButtonDown) then
        if self.selectedItem == #self.items then
            self.selectedItem = 1
        else
            self.selectedItem += 1
        end
    end

    if playdate.buttonJustPressed(playdate.kButtonUp) then
        if self.selectedItem == 1 then
            self.selectedItem = #self.items
        else
            self.selectedItem -= 1
        end
    end

    if playdate.buttonJustPressed(playdate.kButtonA) then
        for key, value in pairs(self.items[self.selectedItem]) do
            value()
        end
    end
    self:drawMenuStartGame()
end

function LaunchMenu:drawMenuStartGame()
    local wTextMax = 0
    local hTextMax = 0

    gfx.setBackgroundColor(gfx.kColorBlack)

    for index, value in ipairs(self.items) do
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
    gfx.clear()
    gfx.setImageDrawMode(gfx.kDrawModeInverted)
    local lastHText = 0

    for index, value in ipairs(self.items) do
        for key, valueItems in pairs(value) do

            local _, hText = gfx.getTextSize(key)
            local text = key
            if index == self.selectedItem then
                text = "*" .. key .. "*"
            end
            gfx.drawText(text, 0, hText + lastHText)
            lastHText += 20
        end
    end
    
    playdate.graphics.setImageDrawMode(playdate.graphics.kDrawModeCopy)

    gfx.popContext()
    self:setImage(imgText)
    self:moveTo(150, 100)
end
