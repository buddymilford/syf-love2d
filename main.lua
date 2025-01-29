if arg[2] == "debug" then
    require("lldebugger").start()
end

function love.load()
    Object = require "classic"
    require "overlay"
    require "player"
    require "fireball"
    require "enemy"

    Overlay = Overlay()
    Player = Player()
    Fireballs = {}
    Enemy = Enemy()

    love.graphics.setBackgroundColor(1, 1, 1)
end

function love.update(dt)
    if Overlay.isStart == false then
        Player:update(dt, Overlay.isPaused)
        Enemy:update(dt, Overlay.isPaused)

        for i, v in ipairs(Fireballs) do
            v:update(dt, Overlay.isPaused)
            v:checkCollision(Enemy)

            --If the bullet has the property dead and it's true then..
            if v.dead then
                --Remove it from the list
                table.remove(Fireballs, i)
            end
        end
    end
end

function love.draw()
    if Overlay.isPaused or Overlay.isStart then
        Overlay:draw()
    else 
        Player:draw()
        Enemy:draw()
    
        for i, v in ipairs(Fireballs) do
            v:draw()
        end
    end
end

function love.keypressed(key)
    Overlay:keyPressed(key)
    Player:keyPressed(key, Overlay.isPaused)
end

local love_errorhandler = love.errorhandler

function love.errorhandler(msg)
    if lldebugger then
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end
