if arg[2] == "debug" then
    require("lldebugger").start()
end

function love.load()
    Object = require "classic"
    require "startscreen"
    require "player"
    require "fireball"
    require "enemy"

    StartScreen = StartScreen()
    Player = Player()
    Fireballs = {}
    Enemy = Enemy()

    love.graphics.setBackgroundColor(1, 1, 1)
end

function love.update(dt)
    if StartScreen.isShowing == false then
        Player:update(dt)
        Enemy:update(dt)

        for i,v in ipairs(Fireballs) do
            v:update(dt)
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
    if StartScreen.isShowing then
        StartScreen:draw()
    else
        Player:draw()
        Enemy:draw()

        for i,v in ipairs(Fireballs) do
            v:draw()
        end
    end
end

function love.keypressed(key)
    if StartScreen.isShowing then
        StartScreen:keyPressed(key)
    else
        Player:keyPressed(key)
    end
end

local love_errorhandler = love.errorhandler

function love.errorhandler(msg)
    if lldebugger then
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end