=begin
total  = 384 x 256
1 char = 96 x 128
1 tile = 32 x 32
=end

module Character
  TILE_WIDTH = 32
  TILE_HEIGTH = 32

  attr_accessor :x, :y
  attr_accessor :w, :h
  attr_accessor :direction

  attr_accessor :visible
  alias_method :visible?, :visible


  def render(args)
    frame = (1 - args.state.tick_count.idiv(16).mod(4)).abs
    {
      x: @x,
      y: @y,
      w: TILE_WIDTH,
      h: TILE_HEIGTH,
      path: @sprite_sheet,
      tile_x: frame * TILE_WIDTH + ((@char_index % 4) * TILE_WIDTH * 3),
      tile_y: direction_to_index[@direction] + ((@char_index.div 4) * TILE_HEIGTH * 4),
      tile_w: TILE_WIDTH,
      tile_h: TILE_HEIGTH,
      #flip_horizontally: args.state.player.direction > 0
    }
  end

  def serialize
    {
      x: @x,
      y: @y,
      direction: @direction,
      sprite_sheet: @sprite_sheet
    }
  end

  def to_s
    serialize.to_s
  end

  def inspect
    serialize.to_s
  end

  private

  def direction_to_index
    {
      2 => TILE_HEIGTH * 0,
      4 => TILE_HEIGTH * 1,
      6 => TILE_HEIGTH * 2,
      8 => TILE_HEIGTH * 3
    }
  end
end

