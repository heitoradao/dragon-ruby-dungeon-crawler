class Player
  attr_accessor :x, :y, :w, :h
  attr_accessor :attacked_at, :angle
  attr_accessor :damage

  def initialize
    @x = 640
    @y = 360
    @w = TILE_WIDTH
    @h = TILE_HEIGTH
    @attacked_at = -1
    @angle = 0
    @damage = 0
    @projectiles = []

    @direction = 2
    @char_index = 3
    @sprite_sheet = 'Characters/Actor4.png'
  end

  def render (args)
    frame = (1 - args.state.tick_count.idiv(16).mod(4)).abs
    args.outputs.sprites << merge(path: @sprite_sheet,
      tile_x: frame * TILE_WIDTH + ((@char_index % 4) * TILE_WIDTH * 3),
      tile_y: direction_to_index[@direction] + ((@char_index.div 4) * TILE_HEIGTH * 4),
      tile_w: TILE_WIDTH,
      tile_h: TILE_HEIGTH,
    #, angle: angle
    )
  end

  def future_player
    future_entity_position 0, 0
  end

  def projectiles
    @projectiles
  end

  def future_entity_position dx, dy
    {
      dx:   x + dx,
      dy:   y + dy,
      both: { x: x + dx,
              y: y + dy }
    }
  end

  def merge (**args)
    { x: x,
      y: y,
      w: w,
      h: h }.merge(args)
  end

  def direction_to_index
    { 2 => TILE_HEIGTH * 0,
      4 => TILE_HEIGTH * 1,
      6 => TILE_HEIGTH * 2,
      8 => TILE_HEIGTH * 3 }
  end

  TILE_WIDTH = 32
  TILE_HEIGTH = 32
end
