# coding: utf-8
require 'dxopal'
include DXOpal

require_remote 'ball.rb'
require_remote 'bumper.rb'
require_remote 'r-flipper.rb'
require_remote 'l-flipper.rb'


Image.register(:player, 'images/player.png') 
Image.register(:enemy, 'images/enemy.png')
Image.register(:flipper, 'images/flipper.png')

Window.load_resources do
  Window.width  = 600
  Window.height = 800

  player_img = Image[:player]
  flipper_img = Image[:flipper]
  player_img.set_color_key([0, 0, 0])

  enemy_img = Image[:enemy]
  enemy_img.set_color_key([0, 0, 0])

  player = Player.new(400, 50, player_img,-1, 1)
  flipper_r = Rflipper.new(130, 500, flipper_img)
  flipper_l = Lflipper.new(30, 500, flipper_img)

  players = [player]
  enemies = []
  flippers_r = [flipper_r]
  flippers_l = [flipper_l]
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
        flippers_r[0].setflag(1)
        flippers_l[0].setflag(1)
    else
        flippers_r[0].setflag(0)
        flippers_l[0].setflag(0)
    end
    player.update
    Sprite.update(flippers_r)
    Sprite.update(flippers_l)
    
    Sprite.draw(players)
    
    Sprite.draw(flippers_r)
    Sprite.draw(flippers_l)

    # 当たり判定
    Sprite.check(players, enemies)
  end
end
