--! file: enemy.lua
Enemy = Object:extend()

function Enemy:new()
    self.image = love.graphics.newImage("steal_your_face.png")
    self.x = 350
    self.y = 500
    self.speed = 100
    self.tempSpeed = 100
    self.speedIncrease = 0
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
end

function Enemy:update(dt, isPaused)
    if isPaused then
        self.speed = 0
    else
        self.speed = self.tempSpeed
        self.x = self.x + self.speed * dt

        local window_width = love.graphics.getWidth()
    
        if self.x < 0 then
            self.x = 0
            self.speed = -self.speed
            self.tempSpeed = self.speed
        elseif self.x + self.width > window_width then
            self.x = window_width - self.width
            self.speed = -self.speed
            self.tempSpeed = self.speed
        end
    end
end

function Enemy:draw()
    love.graphics.draw(self.image, self.x, self.y)
end