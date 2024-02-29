_G.love = require "love"

gamestate = require "hump.gamestate"

StartScreen = require "GameStates.StartScreen"
Game = require "GameStates.Game"
LoseScreen = require "GameStates.LoseScreen"

function love.load()
    gamestate.registerEvents()
    gamestate.switch(StartScreen)
end

function love.update(dt)

end

function love.draw()

end