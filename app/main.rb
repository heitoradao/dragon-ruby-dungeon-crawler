require 'app/game.rb'

def tick args
  $game ||= Game.new
  $game.args = args
  $game.tick
end

$gtk.reset
$game = nil
