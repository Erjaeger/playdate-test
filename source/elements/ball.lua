local gfx <const> = playdate.graphics

class("Ball").extends(gfx.sprite)

function Ball:init(x, y, xVelocity, yVelocity)
    Ball.super.init(self)
    self.size = 5
    self.speed = 5

    if x~=nil and y~=nil then
        self:moveTo(x, y)    
    else
        self:moveTo(200, 120)
    end

    -- local theta = 2 * math.pi * (math.random())
    local theta = math.rad(0)
    local ax = math.cos(theta) * self.speed
    local ay = math.sin(theta) * self.speed

    self.xVelocity = xVelocity ~= nil and xVelocity or ax
    self.yVelocity = yVelocity ~= nil and yVelocity or ay

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

    function map(value, start1, stop1, start2, stop2, withinBounds)
        local range1 = stop1 - start1
        local range2 = stop2 - start2
        value = (value - start1) / range1 * range2 + start2
        return withinBounds and math.clamp(value, start2, stop2) or value
    end

    local actualX, actualY, collisions, length = self:moveWithCollisions(self.x + self.xVelocity, self.y + self.yVelocity)
    local bounce = false
    local bounceNormal = { x = 0, y = 0 }
    for i = 1, length do
        local collision = collisions[i]
        
        if collision.other.collisionResponse == gfx.sprite.kCollisionTypeBounce then
            if collision.other.className == "Player" then
                print(math.random())
                local touchY = collision.bounce.y - collision.other.y + self.size
                
    
                if self.x < 100 then
                    print("left")
                    local newAngle = map(touchY, 0, 40, math.rad(-45), math.rad(45))
                    self.xVelocity = math.cos(newAngle) * self.speed
                    self.yVelocity = math.sin(newAngle) * self.speed
                else
                    print("right")
                    local newAngle = map(touchY, 0, 40, math.rad(-135), math.rad(135))
                    self.xVelocity = math.cos(newAngle) * self.speed *-1
                    self.yVelocity = math.sin(newAngle) * self.speed
                end
    
            else
                bounce = true
                
                if collision.normal.x ~= 0 then
                    bounceNormal.x = collision.normal.x
                end
                if collision.normal.y ~= 0 then
                    bounceNormal.y = collision.normal.y
                end
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
        print("bounce?")
        if bounceNormal.x ~= 0 then
            self.xVelocity *= -1
        end

        if bounceNormal.y ~= 0 then
            self.yVelocity *= -1
        end
    end


end
