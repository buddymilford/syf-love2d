StartScreen = Object:extend()

function StartScreen:new()
    self.x = 250
    self.y = 225
    self.isShowing = true
end

function StartScreen:update()

end

function StartScreen:draw()
    love.graphics.print({{0, 0, 1, 1}, "steal your face -- press spacebar to begin"}, self.x, self.y)
end

function StartScreen:keyPressed(key)
    --If the spacebar is pressed
    if key == "space" then
        self.isShowing = false
    end
end