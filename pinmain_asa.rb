# coding: utf-8
require 'dxopal'
include DXOpal

require_remote 'ball.rb'
require_remote 'bumper.rb'
require_remote 'r-flipper.rb'
require_remote 'l-flipper.rb'

Image.register(:player, 'images/ball.png') 
Image.register(:enemy, 'images/enemy.png')
Image.register(:flipper, 'images/flipper.png')

Window.load_resources do
    
  Window.width  = 400
  Window.height = 800

  #画像関連-------------------------------------
  player_img = Image[:player]
  flipper_img = Image[:flipper]
  player_img.set_color_key([0, 0, 0])
  enemy_img = Image[:enemy]
  enemy_img.set_color_key([0, 0, 0])
  #---------------------------------------------

  #配列---------------------------------------
  players = []
  enemies = []
  flippers_r = []
  flippers_l = []
  #---------------------------------------------
  
  #実体の生成-----------------------------------
  players << Player.new(400, 50, player_img,-1, 1)
  flippers_r << Rflipper.new(390, 700, flipper_img)
  flippers_l << Lflipper.new(10, 700, flipper_img)
  enemies << Enemy.new(200, 60, enemy_img)
  enemies << Enemy.new(100, 200, enemy_img)
  enemies << Enemy.new(300, 200, enemy_img)
  #---------------------------------------------


  #ループ
  Window.loop do
      
    #操作----------------------------------------
    if Input.key_down?(K_RIGHT)
        flippers_r[0].setflag(1)
    else
        flippers_r[0].setflag(0)
    end
    if Input.key_down?(K_LEFT)
        flippers_l[0].setflag(1)
    else
        flippers_l[0].setflag(0)
    end
    #---------------------------------------------
    
    #更新-----------------------------------------
    Sprite.update(enemies)
    Sprite.update(players)
    Sprite.update(flippers_r)
    Sprite.update(flippers_l)
    #---------------------------------------------
    
    #描画-----------------------------------------
    Sprite.draw(players)
    Sprite.draw(flippers_r)
    Sprite.draw(flippers_l)
    Sprite.draw(enemies)
    #---------------------------------------------
    
    # 当たり判定----------------------------------
    Sprite.check(players, enemies)
    Sprite.check(players, flippers_r)
    Sprite.check(players, flippers_l)
    #---------------------------------------------
    
    
  end
end
