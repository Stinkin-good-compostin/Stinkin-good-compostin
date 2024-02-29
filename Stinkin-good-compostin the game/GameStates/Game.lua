local Game = {}
Game = gamestate.new()

score = 0

function Game:init()
    background = love.graphics.newImage("wide/map.jpg") 
   
    player = love.graphics.newImage("wide/wide.png")

    player_scaleDown = .04
    facingLeft = false
    player_details = {
        x = 300,
        y = 200,
        width = player:getWidth() * player_scaleDown,
        height = player:getHeight() * player_scaleDown
    }

    bag = love.graphics.newImage("wide/bag.png")
    bag_scaleDown = .05
    amount_of_bags = 3

    bags = {}

    max_timer = 5
    timer = max_timer
end

function isColliding(obj1, obj2)
    local epsilon = 6
    local left1, right1, top1, bottom1 = getAABB(obj1)
    local left2, right2, top2, bottom2 = getAABB(obj2)


    return left2 <= right1 - epsilon and right2 >= left1 - epsilon and top2 <= bottom1 + epsilon and bottom2 >= top1 + epsilon
end

function getAABB(obj)
    local left = obj.x - obj.width/2
    local right = obj.x + obj.width/2
    local top = obj.y - obj.height/2
    local bottom = obj.y + obj.height/2

    return left, right, top, bottom
end

local miliseconds = 1
local second = 180
function Game:update(dt)
    if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
        player_details.x = player_details.x - .5
        facingLeft = true
    elseif love.keyboard.isDown("d") or love.keyboard.isDown("right") then
        player_details.x = player_details.x + .5
        facingLeft = false
    end

    if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
        player_details.y = player_details.y - .5
    elseif love.keyboard.isDown("s") or love.keyboard.isDown("down") then
        player_details.y = player_details.y + .5
    end

    if #bags < amount_of_bags then
        local bagX, bagY = math.floor(love.math.random() * (love.graphics.getWidth() - 105)), math.floor(love.math.random() * (love.graphics.getHeight() - 125))
        if bagX <= 100 then
            bagX = bagX + 100
        end
        if bagY <= 120 then
            bagY = bagY + 120
        end

        table.insert(bags, {x = bagX, y = bagY, width = bag:getWidth() * bag_scaleDown, height = bag:getHeight() * bag_scaleDown})
    end

    for i, b in ipairs(bags) do
        if isColliding(b, player_details) then
            table.remove(bags, i)
            score = score + 1
            
            if timer ~= max_timer then
                timer = timer + 1
            end
        end
    end

    if miliseconds ~= second then
        miliseconds = miliseconds + 1
    else
        timer = timer - 1

        miliseconds = 1
    end

    if timer <= 0 then
        gamestate.switch(LoseScreen)
    end
end

function Game:draw()
    love.graphics.setColor(1,1,1)
    love.graphics.draw(background, 0, 0, 0, love.graphics.getWidth()/background:getWidth(), love.graphics.getHeight()/background:getHeight())

    local scaleX = facingLeft and player_scaleDown or -player_scaleDown
    local offsetX = facingLeft and 0 or player_details.width

    love.graphics.draw(player, player_details.x + offsetX, player_details.y, 0, scaleX, player_scaleDown)
    love.graphics.printf("Time Left: " .. timer, 0, 20, love.graphics.getWidth(), "center")

    for _, b in ipairs(bags) do
        love.graphics.draw(bag, b.x, b.y, 0, bag_scaleDown, bag_scaleDown)
    end
end

return Game