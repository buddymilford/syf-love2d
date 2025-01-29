Fireball = Object:extend()

DefaultSpeed = 700

function Fireball:new(x, y)
    self.image = love.graphics.newImage("fire_emoji.png")
    self.x = x
    self.y = y
    self.speed = 700
    --We'll need these for collision checking
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
end

function Fireball:update(dt, isPaused)
    if isPaused then
        self.speed = 0
    else
        self.speed = DefaultSpeed
        self.y = self.y + self.speed * dt

        --If the bullet is out of the screen
        if self.y > love.graphics.getHeight() then
            --Restart the game
            -- love.load()
        end
    end
end

function Fireball:draw()
    love.graphics.draw(self.image, self.x, self.y)
end

function Fireball:checkCollision(obj)
    local self_left = self.x
    local self_right = self.x + self.width
    local self_top = self.y
    local self_bottom = self.y + self.height

    local obj_left = obj.x
    local obj_right = obj.x + obj.width
    local obj_top = obj.y
    local obj_bottom = obj.y + obj.height

    if self_right > obj_left
        and self_left < obj_right
        and self_bottom > obj_top
        and self_top < obj_bottom then
        self.dead = true

        obj.speedIncrease = obj.speedIncrease + 50

        --Increase enemy speed
        if obj.speed > 0 then
            obj.speed = obj.speed + obj.speedIncrease
            obj.tempSpeed = obj.speed
        else
            obj.speed = obj.speed - obj.speedIncrease
            obj.tempSpeed = obj.speed
        end
    end
end
