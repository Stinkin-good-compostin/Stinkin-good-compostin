local StartScreen = {}
StartScreen = gamestate.new()

function StartScreen:init()
    Startup_Screen = love.graphics.newImage("wide/covermaybe.png")

    StartButton = {
        x = 300,
        y = 410,
        width = 200,
        height = 30
    }
end

function StartScreen:update(dt)

end

function StartScreen:mousepressed(x, y, b)
    if b == 1 then
        if x >= StartButton.x and x <= StartButton.x + StartButton.width and y >= StartButton.y and y <= StartButton.y + StartButton.height then
            gamestate.switch(Game)
        end
    end
end

function StartScreen:draw()
    love.graphics.draw(Startup_Screen, 0, 0, 0, love.graphics.getWidth()/Startup_Screen:getWidth(), love.graphics.getHeight()/Startup_Screen:getHeight())
    
    love.graphics.setColor(.25, .25, .25)
    love.graphics.rectangle("fill", StartButton.x, StartButton.y, StartButton.width, StartButton.height, 10)

    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(love.graphics.setNewFont(17))
    love.graphics.printf("Press here to start", StartButton.x, StartButton.y + 5, StartButton.width, "center")
end

return StartScreen