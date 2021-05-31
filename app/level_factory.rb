require 'app/level.rb'

class LevelFactory


  def self.create_level_one_template
    structure = {
      walls:           [{ ordinal_x: 25, ordinal_y: 20},
                        { ordinal_x: 25, ordinal_y: 21},
                        { ordinal_x: 25, ordinal_y: 22},
                        { ordinal_x: 25, ordinal_y: 23}],
      spawn_locations: [{ ordinal_x: 10, ordinal_y: 10, rate: 120, countdown: 0, hp: 5 }]
    }

    {
      walls:           structure.walls.map { |w| to_cell(w.ordinal_x, w.ordinal_y).merge(w) },
      enemies:         [],
      spawn_locations: structure.spawn_locations.map { |s| to_cell(s.ordinal_x, s.ordinal_y).merge(s) }
    }
  end



  def self.create_random_level
    data = {
      walls:           [{ ordinal_x: rand(20), ordinal_y: rand(20)},
                        { ordinal_x: rand(20), ordinal_y: rand(20)},
                        { ordinal_x: rand(20), ordinal_y: rand(20)},
                        { ordinal_x: rand(20), ordinal_y: rand(20)},
                        { ordinal_x: rand(20), ordinal_y: rand(20)},
                        { ordinal_x: 20, ordinal_y: 20}],
      spawn_locations: [{ ordinal_x: 10, ordinal_y: 10, rate: 120, countdown: 0, hp: 5 }]
    }


    {
      walls:           data.walls.map { |w| to_cell(w.ordinal_x, w.ordinal_y).merge(w) },
      enemies:         [],
      spawn_locations: data.spawn_locations.map { |s| to_cell(s.ordinal_x, s.ordinal_y).merge(s) }
    }
  end



  def self.to_cell (ordinal_x, ordinal_y)
    { x: ordinal_x * 16,
      y: ordinal_y * 16,
      w: 16,
      h: 16 }
  end
end
