local LoseScreen = {}
LoseScreen = gamestate.new()

function LoseScreen:init()
    local width = 200
    local height = 30

    restart_button = {
        x = love.graphics.getWidth()/2 - width/2,
        y = love.graphics.getHeight()/2 - height/2,
        width = width,
        height = height
    }
end

function LoseScreen:update(dt)

end

function LoseScreen:mousepressed(x, y, b)
    if b == 1 then
        if x >= restart_button.x and x <= restart_button.x + restart_button.width and y >= restart_button.y and y <= restart_button.y + restart_button.height then
            gamestate.switch(StartScreen)
        end
    end
end

function LoseScreen:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(love.graphics.setNewFont(35))
    love.graphics.printf("You lost your score was: " .. score, 0, 200, love.graphics.getWidth(), "center")

    love.graphics.setColor(.25, .25, .25)
    love.graphics.rectangle("fill", restart_button.x, restart_button.y, restart_button.width, restart_button.height, 10)

    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(love.graphics.setNewFont(15))
    love.graphics.printf("Click here to try again", restart_button.x, restart_button.y + 5, restart_button.width, "center")
end

return LoseScreen