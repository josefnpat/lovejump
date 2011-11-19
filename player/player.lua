player = {}

function player:load()
  player.sheet = love.graphics.newImage("player/assets/player.png")
  player.x = 32
  player.y = 0
  player.sprite = 1
  player.v_x = 0
  player.v_y = 0
  player.jump = false
  player.quads = {}
  player.scale = 2
  local playerw = player.sheet:getWidth();
  local playerh = player.sheet:getHeight();
  for q = 1,(playerw/16) do
    player.quads[q] = love.graphics.newQuad((q-1)*16,0,16,16,playerw,playerh)
  end
end
function player:draw()
  love.graphics.drawq(player.sheet,player.quads[player.sprite],player.x,player.y,0,player.scale,player.scale)
  --[[
  if player.debug.right then
    love.graphics.setColor( 0, 255, 0, 64 )
  else
    love.graphics.setColor( 255, 0, 0, 64 )
  end
  love.graphics.rectangle("fill",player.x+16*player.scale,player.y,32,32)
    if player.debug.left then
    love.graphics.setColor( 0, 255, 0, 64 )
  else
    love.graphics.setColor( 255, 0, 0, 64 )
  end
  love.graphics.rectangle("fill",player.x-16*player.scale,player.y,32,32)
    if player.debug.down then
    love.graphics.setColor( 0, 255, 0, 64 )
  else
    love.graphics.setColor( 255, 0, 0, 64 )
  end
  love.graphics.rectangle("fill",player.x,player.y+16*player.scale,32,32)
    if player.debug.up then
    love.graphics.setColor( 0, 255, 0, 64 )
  else
    love.graphics.setColor( 255, 0, 0, 64 )
  end
  love.graphics.rectangle("fill",player.x,player.y-16*player.scale,32,32)
  love.graphics.setColor( 255, 255, 255, 255 )

  love.graphics.print("v_x:"..player.v_x,0,16)
  love.graphics.print("v_y:"..player.v_y,0,32)
    --]]
  if player.jump then
    love.graphics.print("jump!",0,48)
  end
end

player.debug = {
  up = true,
  down = true,
  left = true,
  right = true
}

function player:update(dt)
  local new_x = player.x + player.v_x*dt
  if stage:blockatpos(new_x+16*player.scale,player.y+2) == 0 and stage:blockatpos(new_x+16*player.scale,player.y+16*player.scale-2) == 0 and player.v_x > 0 then
    player.x = new_x
    player.debug.right = true
  else
    player.debug.right = false
  end
  if stage:blockatpos(new_x,player.y+2) == 0 and stage:blockatpos(new_x,player.y+16*player.scale-2) == 0 and player.v_x < 0  then
    player.x = new_x
    player.debug.left = true
  else
    player.debug.left = false
  end
  
  if player.jump then
    player.v_y = player.v_y - 4
    if player.v_y < -120 then
      player.jump = false
    end
  else
    player.v_y = player.v_y + 4
  end
  local new_y = player.y + player.v_y*dt
  if stage:blockatpos(player.x+2,new_y+16*player.scale) ~= 0 or stage:blockatpos(player.x+16*player.scale-2,new_y+16*player.scale) ~= 0 then
    player.v_y = 0
    player.jump = false
  end
  
  if stage:blockatpos(player.x+2,new_y) == 0 and stage:blockatpos(player.x+16*player.scale-2,new_y) == 0 and player.v_y < 0 then
    player.y = new_y
    player.debug.up = true
  else
    if player.v_y < 0 then
      player.v_y = 0
      player.jump = false
    end
    player.debug.up = false
  end
  if stage:blockatpos(player.x+2,new_y+16*player.scale) == 0 and stage:blockatpos(player.x+16*player.scale-2,new_y+16*player.scale) == 0 and player.v_y > 0 then
    player.y = new_y
    player.debug.down = true
  else
    if player.v_y > 0 then
      player.v_y = 0
      player.jump = false
    end
    player.debug.down = false
  end
  local dir = player.sprite
  if player.v_x > 0 then
    dir = 3
  elseif player.v_x < 0 then
    dir = 4
  end
  if player.v_y ~= 0 then
    if dir == 3 then
      dir = 1
    elseif dir == 4 then
      dir = 2
    end
  end
  player.sprite = dir
end

function player:keypressed(key)
  if key == "left" then
    player.v_x = -100
  elseif key == "right" then
    player.v_x = 100
  elseif key == " " and player.v_y == 0 then
    player.v_y = -190
    player.jump = true
  end
end

function player:keyreleased(key)
  if key == "left" or key == "right" then
    player.v_x = 0
  end
end

function math.round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

