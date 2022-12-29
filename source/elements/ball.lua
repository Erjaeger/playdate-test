local gfx <const> = playdate.graphics

class("Ball").extends(gfx.sprite)

function Ball:init()
    Ball.super.init(self)
    self.size = 5
    self.speed = 2

    self:moveTo(200, 110)

    local radius = 3
    local theta = math.random() * ((math.pi * 2))
    local ax = math.cos(theta) * radius
    local ay = math.sin(theta) * radius

    self.xVelocity = ax
    self.yVelocity = ay

    local img = gfx.image.new(self.size * 2, self.size * 2)
    gfx.pushContext(img)
    gfx.setColor(gfx.kColorWhite)
    gfx.fillCircleAtPoint(self.size, self.size, self.size)
    gfx.popContext()
    self:setImage(img)


    self:setCollideRect(0, 0, self:getSize())
    self.collisionResponse = gfx.sprite.kCollisionTypeBounce
    ballCount += 1
    self:add()
end

function Ball:update()
    Ball.super.update(self)

    local _, _, collisions, length = self:moveWithCollisions(self.x + self.xVelocity, self.y + self.yVelocity)
    local bounce = false
    local bounceNormal = { x = 0, y = 0 }
    for i = 1, length do
        local collision = collisions[i]

        if collision.other.collisionResponse == gfx.sprite.kCollisionTypeBounce then
            bounce = true
            if collision.normal.x ~= 0 then
                bounceNormal.x = collision.normal.x
            end
            if collision.normal.y ~= 0 then
                bounceNormal.y = collision.normal.y
            end
        elseif collision.other.collisionResponse == gfx.sprite.kCollisionTypeOverlap then
            if self.x > 380 then
                updateScorePlayer()
            elseif self.x < 15 then
                updateScoreEnemy()
            end
            ballCount -= 1
            self:remove()
        end
    end

    if bounce then
        if bounceNormal.x ~= 0 then
            self.xVelocity *= -1
        end

        if bounceNormal.y ~= 0 then
            self.yVelocity *= -1
        end
    end


end
