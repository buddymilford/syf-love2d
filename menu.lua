Menu = Object:extend()

function Menu:new()
    self.x = 300
    self.y = 250
    self.isStart = true
    self.isPaused = false
    self.isGameOver = false
    self.isQuit = false;
    self.dancingBearImage = love.graphics.newImage("dancing_bear.png")
    self.stealYourFaceImage = love.graphics.newImage("steal_your_face.png")
end

function Menu:update()

end

function Menu:draw()
    if self.isStart then
        love.graphics.draw(self.dancingBearImage, self.x - 100, self.y)
        love.graphics.print({ { 0, 0, 1, 1 },
            "-- steal your face --\nleft and right arrow keys to move\nspacebar to shoot\nescape to pause\nbackspace to quit\nenter to begin" },
            self.x, self.y)
        love.graphics.draw(self.stealYourFaceImage, self.x + 200, self.y)
    elseif self.isPaused then
        love.graphics.draw(self.dancingBearImage, self.x - 100, self.y)
        love.graphics.print({ { 0, 0, 1, 1 }, "-- paused --\nescape to continue" }, self.x, self.y)
        love.graphics.draw(self.stealYourFaceImage, self.x + 125, self.y)
    else
        if self.isGameOver then
            love.graphics.draw(self.dancingBearImage, self.x - 100, self.y)
            love.graphics.print({ { 0, 0, 1, 1 }, "-- game over --\nenter to try again" }, self.x, self.y)
            love.graphics.draw(self.stealYourFaceImage, self.x + 125, self.y)
        end
    end
end

function Menu:keyPressed(key)
    if key == "return" then
        self.isStart = false
        self.isGameOver = false
        self.isQuit = false
    end

    if not self.isStart and not self.isGameOver and key == "escape" then
        self.isPaused = not self.isPaused
    end

    if not self.isPaused then
        if key == "backspace" then
            self.isQuit = true
        end
    end
end

function Menu:isActive()
    return self.isPaused or self.isStart or self.isGameOver
end
