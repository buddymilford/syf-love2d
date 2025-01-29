Player = Object:extend()

function Player:new()
    self.image = love.graphics.newImage("dancing_bear.png")
    self.x = 325
    self.y = 0
    self.speed = 500
    self.width = self.image:getWidth()
    self.isFacingLeft = false;
end

function Player:update(dt, isPaused)
    if isPaused then
        self.speed = 0
    else
        self.speed = 500
        if love.keyboard.isDown("left") then
            self.isFacingLeft = true
            self.x = self.x - self.speed * dt
        elseif love.keyboard.isDown("right") then
            self.isFacingLeft = false
            self.x = self.x + self.speed * dt
        end

        --Get the width of the window
        local window_width = love.graphics.getWidth()

        --If the x is too far too the left then..
        if self.x < 0 then
            --Set x to 0
            self.x = 0

            --Else, if the x is too far to the right then..
        elseif self.x > window_width - self.width then
            --Set the x to the window's width.
            self.x = window_width - self.width
        end
    end
end

function Player:draw()
    if self.isFacingLeft then
        self:drawFacingLeft()
    else
        self:drawFacingRight()
    end
end

function Player:drawFacingRight()
    -- image is already facing right
    love.graphics.draw(self.image, self.x, self.y)
end

function Player:drawFacingLeft()
    -- account for the vertical flip by adding 100 pixels to x
    -- flip vertically by setting sx to -1 and sy to 1
    love.graphics.draw(self.image, self.x + 100, self.y, 0, -1, 1)
end

function Player:keyPressed(key, isPaused)
    if not isPaused then
        --If the spacebar is pressed
        if key == "space" then
            --Put a new instance of Bullet inside listOfBullets.
            table.insert(Fireballs, Fireball(self.x, self.y))
        end
    end
end
