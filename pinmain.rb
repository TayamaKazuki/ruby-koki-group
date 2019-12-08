# coding: utf-8
require 'dxopal'
include DXOpal

require_remote 'ball.rb'
require_remote 'bumper.rb'
require_remote 'flipper.rb'

Image.register(:player, 'images/player.png') 
Image.register(:enemy, 'images/enemy.png') 

Window.load_resources do
  Window.width  = 600
  Window.height = 800

  player_img = Image[:player]
  player_img.set_color_key([0, 0, 0])

  enemy_img = Image[:enemy]
  enemy_img.set_color_key([0, 0, 0])

  player = Player.new(400, 50, player_img,1, 1)

  players = [player]
  enemies = []
  10.times do
    enemies << Enemy.new(rand(600), rand(800), enemy_img)
  end

  Window.loop do
    #if Input.key_push?(K_R)
   #     break
    #end
    Sprite.update(enemies)
    Sprite.draw(enemies)
    if Input.key_down?(K_SPACE)
        Sprite.update(players)
    end
    #player.update
    Sprite.draw(players)

    # 当たり判定
    Sprite.check(players, enemies)
  end
end
