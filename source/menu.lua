local gfx <const> = playdate.graphics

local selectedItem = 1
local items = {
    {
        Jouer = function()
            stateGame = stateGameEnum.RUNNING
        end
    },
    { Options = function()

    end
    }
}
local sprite

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
    gfx.clear()
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
    end

    if playdate.buttonJustPressed(playdate.kButtonUp) then
        if selectedItem == 1 then
            selectedItem = #items
        else
            selectedItem -= 1
        end
    end

    if playdate.buttonJustPressed(playdate.kButtonA) then
        for key, value in pairs(items[selectedItem]) do
            value()
        end
    end
    initMenuStartGame()
end
