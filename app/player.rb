require 'app/character.rb'

class Player
  include Character
  include GTK::Geometry

  attr_accessor :attacked_at, :angle
  attr_accessor :damage

  ATTACK_DELAY = 5

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
    )

    args.outputs.sprites << projectiles.map do |p|
      p.merge(path: 'sprites/square/blue.png')
    end
  end

  def projectiles
    @projectiles
  end

  def future_position (dx, dy)
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

  def input (args, inputs)
    angle = inputs.directional_angle || angle

    if angle == 90.0
      @direction = 8
    elsif angle == 180.0
      @direction = 4
    elsif angle == 0.0
      @direction = 6
    elsif angle == -90.0
      @direction = 2
    end

    if inputs.controller_one.key_down.a || inputs.keyboard.key_down.space
      attacked_at = args.state.tick_count
    end
  end

  def calc (args)
    if attacked_at == args.state.tick_count
      projectiles << { at: args.state.tick_count,
                       x: x,
                       y: y,
                       angle: angle,
                       w: 16,
                       h: 16 }.center_inside_rect(self)
    end

=begin
    if attacked_at.elapsed_time > 5
      future_player = merge future_position(args.inputs.left_right * 2, args.inputs.up_down * 2)
      #future_player_collision = future_collision(player, future_player, level.walls)
      player.x = future_player_collision.x if !future_player_collision.dx_collision
      player.y = future_player_collision.y if !future_player_collision.dy_collision
    end
=end
  end

  def calc_projectiles
    projectiles.map! do |p|
      dx, dy = p.angle.vector 10
      p.merge(x: p.x + dx, y: p.y + dy)
    end
  end
end
