class Level
  attr_accessor :walls, :enemies, :spawn_locations

  def initialize
    @walls = []
    @enemies = []
    @spawn_locations = []
  end

  def render (outputs)
    render_walls(outputs)
  end

  protected

  def render_walls (outputs)
    outputs.sprites << walls.map do |w|
      w.merge(path: 'sprites/square/gray.png')
    end
  end
end
