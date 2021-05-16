require 'app/character.rb'

puts 'something'

def defaults(args)
  args.state.enemy ||= Character.new('sprites/monster4.png',
                                        rand(8))
=begin

caveira = Character.new(sprite_sheet: 'sprites/monster4.png',
                        char_index: 2)

mumia = Character.new(sprite_sheet: 'sprites/monster4.png',
                      char_index: 4)
=end
end

speed = 2

def tick(args)
  defaults(args)
  Character.tick(args)
  #args.outputs.labels  << [640, 500, 'Hello World!', 5, 1]
  #args.outputs.labels  << [640, 460, 'Go to docs/docs.html and read it!', 5, 1]
  #args.outputs.labels  << [640, 420, 'Join the Discord! http://discord.dragonruby.org', 5, 1]
  #args.outputs.sprites << [576, 280, 128, 101, 'dragonruby.png']
  #args.outputs.sprites << [0, 0, 384, 256, 'sprites/monster4.png']
  args.outputs.sprites << args.state.enemy.render(args)
  
  
  if args.inputs.keyboard.key_up.h
    #args.state.h_pressed_at = args.state.tick_count
    $gtk.console.open
  end
  
  if args.inputs.keyboard.key_up.up
    args.state.enemy.direction = 8
    args.state.enemy.y += 1
  end
  if args.inputs.keyboard.key_up.down
    args.state.enemy.direction = 2
    args.state.enemy.y -= 1
  end
  if args.inputs.keyboard.key_up.left
    args.state.enemy.direction = 4
    args.state.enemy.x -= 1
  end
  if args.inputs.keyboard.key_up.right
    args.state.enemy.direction = 6
    args.state.enemy.x += 1
  end
end
