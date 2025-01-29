Overlay = Object:extend()

function Overlay:new()
    self.x = 350
    self.y = 250
    self.isStart = true
    self.isPaused = false
end

function Overlay:update()

end

function Overlay:draw()
    if self.isStart then
        love.graphics.print({{0, 0, 1, 1}, "-- steal your face --\nspacebar to shoot\nescape to pause\nenter to begin"}, self.x, self.y)
    elseif self.isPaused then
        love.graphics.print({{0, 0, 1, 1}, "-- paused --\nescape to continue"}, self.x, self.y)
    end
end

function Overlay:keyPressed(key)
    --If enter is pressed
    if key == "return" then
        self.isStart = false
    end

    if not self.isStart and key == "escape" then
        self.isPaused = not self.isPaused
    end
end