local gfx <const> = playdate.graphics

class("Wall").extends(gfx.sprite)

function Wall:init(x, y, w, h, transparent)
    Wall.super.init(self)

    self:setCenter(0, 0)
    self:moveTo(x, y)

    local img = gfx.image.new(w, h)

    gfx.pushContext(img)
    if transparent == true then
        gfx.setColor(gfx.kColorClear)
        self.collisionResponse = gfx.sprite.kCollisionTypeOverlap
    else
        gfx.setColor(gfx.kColorWhite)
        self.collisionResponse = gfx.sprite.kCollisionTypeBounce
    end

    gfx.fillRect(0, 0, w, h)
    gfx.popContext()

    self:setImage(img)
    self:setCollideRect(0, 0, self:getSize())


    self:add()
end
