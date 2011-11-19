require("player/player")
require("stage/stage")

function love.load()
  player:load()
  stage:load()
end

function love.draw()
  stage:draw()
  player:draw()
  --love.graphics.print("blockasmouse:"..t,0,0)
end

t = 0
function love.update(dt)
  player:update(dt)
  t = stage:blockatpos(love.mouse.getX(),love.mouse.getY())
end

function love.keypressed(key)
  player:keypressed(key)
end

function love.keyreleased(key)
  player:keyreleased(key)
end
