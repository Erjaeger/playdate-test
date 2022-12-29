local gfx <const> = playdate.graphics

class("Player").extends(gfx.sprite)

function Player:init(x, automatic)
    Player.super.init(self)
    self.x = x
    self.y = 10
    self.w = 10
    self.h = 40
    self.speed = 3
    self.automatic = automatic

    self:setCenter(0, 0)
    self:moveTo(self.x, self.y)

    local img = gfx.image.new(self.w, self.h)

    gfx.pushContext(img)
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRect(0, 0, self.w, self.h)
    gfx.popContext()

    self:setImage(img)

    self:setCollideRect(0, 0, self:getSize())
    self.collisionResponse = gfx.sprite.kCollisionTypeBounce
    self:add()
end

function Player:moveUp()
    self.y -= self.speed
end

function Player:moveDown()
    self.y += self.speed
end

function Player:update()
    Player.super.update(self)
    if self.automatic == false then
        if playdate.buttonIsPressed(playdate.kButtonUp) then
            self:moveUp()
        elseif playdate.buttonIsPressed(playdate.kButtonDown) then
            self:moveDown()
        end
    end

    self:moveWithCollisions(self.x, self.y)
end
