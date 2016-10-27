class entity
  new: (@name,@screen,dm,@static) =>
    @x = dm.x * G.scale
    @y = dm.y * G.scale
    @w = dm.w
    @h = dm.h
    if not @static
      @speed = 15
      @xvel = 0
      @yvel = 0
    @canvas = juno.Buffer.fromBlank @w,@h
    G.world\add @,@x,@y,@w,@h
    return 
  update: (dt) =>
    G.coil.update dt
    G.tick.update dt
    G.flux.update dt
    if not @static
      @x += @xvel
      @y += @yvel + G.gravity
      @xvel = @xvel*(1 - math.min dt*G.friction,1)
      @yvel = @yvel*(1 - math.min dt*G.friction,1)
      if @x > G.width-@w then @x = G.width-@w elseif @x <= 0 then @x = 0
      if @y > G.height-@h then
        @y = G.height-@h
      elseif @y <= 0 then
        @y = 0
        @yvel = 0
      if @xvel != 0 or @yvel != 0
    return
  draw: () =>
    @canvas\drawRect 0,0,@w,@h
    @screen\copyPixels @canvas,@x,@y,nil
    return