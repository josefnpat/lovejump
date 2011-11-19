stage = {}

function stage:load()
  stage.map = {}
  stage.map[1] = {
    {1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    {1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    {1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1},
    {1,0,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1},
    {1,0,1,0,0,0,0,0,0,1,0,0,0,0,1,1,0,0,0,1},
    {1,0,1,1,1,0,0,0,0,0,1,0,0,1,0,0,1,1,0,1},
    {1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1},
    {1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1},
    {1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1},
    {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    {1,0,0,0,2,3,0,0,0,0,0,1,1,1,1,0,0,0,0,1},
    {1,0,0,0,4,5,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
  }
  stage.sheet = love.graphics.newImage("stage/assets/sheet.png")
  stage.quads = {}
  local stagew = stage.sheet:getWidth();
  local stageh = stage.sheet:getHeight();
  for q = 1,(stagew/16) do
    stage.quads[q] = love.graphics.newQuad((q-1)*16,0,16,16,stagew,stageh)
  end
end

stage.scale = 2

function stage:draw()
  for icol,vcol in ipairs(stage.map[1]) do
    for irow,vrow in ipairs(vcol) do
      if vrow > 0 then
        love.graphics.drawq(stage.sheet,stage.quads[vrow],(irow-1)*16*stage.scale,(icol-1)*16*stage.scale,0,stage.scale,stage.scale)
      end
    end
  end
end

function stage:blockatpos(x,y)
  local check_x = math.floor(x/(16*stage.scale))+1
  local check_y = math.floor(y/(16*stage.scale))+1
  if stage.map[1][check_y] then
    if stage.map[1][check_y][check_x] then
      return stage.map[1][check_y][check_x]
    else
      return 0
    end
  else
    return 0
  end
end
