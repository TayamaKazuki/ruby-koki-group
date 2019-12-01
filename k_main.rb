# coding: utf-8
require 'dxopal'
include DXOpal

require_remote 'k_player.rb'
require_remote 'k_enemy.rb'

Image.register(:player, 'images/player.png') 
Image.register(:enemy, 'images/enemy.png') 

Window.load_resources do
  Window.width  = 800
  Window.height = 600

  player_img = Image[:player]
  player_img.set_color_key([0, 0, 0])

  enemy_img = Image[:enemy]
  enemy_img.set_color_key([0, 0, 0])

  player = Player.new(400, 50, player_img,1, 1)

  players = [player]
  enemies = []
  10.times do
    enemies << Enemy.new(rand(800), rand(600), enemy_img)
  end

  Window.loop do
    Sprite.update(enemies)
    Sprite.draw(enemies)
    Sprite.update(players)
    #player.update
    Sprite.draw(players)

    # 当たり判定
    Sprite.check(players, enemies)
  end
end
