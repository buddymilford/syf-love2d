if arg[2] == "debug" then
    require("lldebugger").start()
end

function love.load()
    Object = require "classic"
    require "menu"
    require "player"
    require "fireball"
    require "enemy"

    Menu = Menu()
    Player = Player()
    Fireballs = {}
    Enemy = Enemy()

    love.graphics.setBackgroundColor(1, 1, 1)
end

local function reset()
    Menu.isGameOver = true;
    Fireballs = {}
    Player.x = 325
    Enemy.x = 350
    Enemy.speed = 0
    Enemy.tempSpeed = 100
    Enemy.speedIncrease = 0
end

function love.update(dt)
    if Menu.isStart == false and Menu.isGameOver == false then
        Player:update(dt, Menu.isPaused)
        Enemy:update(dt, Menu.isPaused)

        for i, v in ipairs(Fireballs) do
            v:update(dt, Menu.isPaused)
            v:checkCollision(Enemy)

            --If the bullet has the property dead and it's true then..
            if v.dead then
                --Remove it from the list
                table.remove(Fireballs, i)
            end

            if v.outOfBounds then
                table.remove(Fireballs, i)
                reset()
            end
        end

        if Menu.isQuit then
            reset()
        end
    end
end

function love.draw()
    if Menu:isActive() then
        Menu:draw()
    else
        Player:draw()
        Enemy:draw()

        for i, v in ipairs(Fireballs) do
            v:draw()
        end
    end
end

function love.keypressed(key)
    Menu:keyPressed(key)
    if not Menu:isActive() then
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
