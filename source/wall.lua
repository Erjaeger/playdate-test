local gfx <const> = playdate.graphics

class("Wall").extends(gfx.sprite)

function Wall:init(x, y, w, h)
    Wall.super.init(self)

    self:setCenter(0, 0)
    self:moveTo(x, y)

    local img = gfx.image.new(w, h)

    gfx.pushContext(img)
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRect(0, 0, w, h)
    gfx.popContext()

    self:setImage(img)
    self:setCollideRect(0, 0, self:getSize())

    self.collisionResponse = gfx.sprite.kCollisionTypeBounce
    self:add()
end
