class Level
  attr_accessor :walls, :enemies, :spawn_locations

  def initialize
    @walls = []
    @enemies = []
    @spawn_locations = []
  end

  def self.from_hash (structure)
    level_instance = self.new
    level_instance.walls = structure.walls.map { |w| to_cell(w.ordinal_x, w.ordinal_y).merge(w) }
    level_instance.spawn_locations = structure.spawn_locations.map { |s| to_cell(s.ordinal_x, s.ordinal_y).merge(s) }
    level_instance
  end

  def render (outputs)
    render_walls(outputs)
    render_spawn_locations(outputs)
    render_enemies(outputs)
  end

  protected

  def render_walls (outputs)
    outputs.sprites << walls.map do |w|
      w.merge(path: 'sprites/square/gray.png')
    end
  end

  def render_spawn_locations (outputs)
    outputs.sprites << spawn_locations.map do |s|
      s.merge(path: 'sprites/square/blue.png')
    end
  end

  def render_enemies (outputs)
    outputs.sprites << enemies.map do |e|
      e.merge(path: 'Characters/Monster1.png',
              tile_x: 4 * 32,
              tile_y: 0,
              tile_w: 32,
              tile_h: 32,
              w: 32,
              h: 32,)
    end
  end

  def self.to_cell (ordinal_x, ordinal_y)
    { x: ordinal_x * 16,
      y: ordinal_y * 16,
      w: 16,
      h: 16 }
  end

  def serialize
    { walls: walls,
      enemies: enemies,
      spawn_locations: spawn_locations }
  end

  def inspect
    serialize.to_s
  end

  def to_s
    serialize.to_s
  end
end
