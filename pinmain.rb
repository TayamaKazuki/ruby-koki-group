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
  Window.height = 1000

  GAME_INFO = {
  scene: :title,  # 現在のシーン(起動直後は:title)
  }

  player_img = Image[:player]
  flipper_img = Image[:flipper]
  player_img.set_color_key([0, 0, 0])

  enemy_img = Image[:enemy]
  enemy_img.set_color_key([0, 0, 0])
=begin
  player = Player.new(400, 50, player_img,1, 1)
  point = Player.new(0,0,nil,1,1)
  flipper = Flipper.new(30, 700, flipper_img)

  players = [player]
  points = [point]
  enemies = []
  flippers = [flipper]
=end
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

  font = Font.new(30)
  pt = 0
=begin
  10.times do
    enemies << Enemy.new(rand(600), rand(800), enemy_img)
=end
    enemies << Enemy.new(200, 30, enemy_img)
    enemies << Enemy.new(100, 60, enemy_img)
    enemies << Enemy.new(300, 60, enemy_img)

  Window.loop do
    #if Input.key_push?(K_R)
   #     break
    #end
    case GAME_INFO[:scene]
    when :title
      # タイトル画面
      Window.draw_font(0, 30, "PRESS SPACE", Font.default)
      # スペースキーが押されたらシーンを変える
      if Input.key_push?(K_SPACE)
        GAME_INFO[:scene] = :playing
      end
      
    when :playing
        Window.draw_font(10,10,"得点:#{pt}",font)
        Sprite.update(enemies)
        Sprite.draw(enemies)
       # if Input.key_down?(K_SPACE)
            Sprite.update(players)
        #end

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

        #player.update
        Sprite.update(flippers_r)
        Sprite.update(flippers_l)
        Sprite.draw(players)
        Sprite.draw(flippers_r)
        Sprite.draw(flippers_l)
        
        # 当たり判定
        if players[0] === enemies
            #points[0].x= pt
            pt += 1
        end
        Sprite.check(players, enemies)
        
        if players[0] === flippers_r
            players[0].change_x(flippers_r[0].ang_flag)
        end
        
        if players[0] === flippers_l
            players[0].change_x(flippers_l[0].ang_flag)
        end
        
        Sprite.check(players, flippers_r)
        Sprite.check(players, flippers_l)
        
        if players[0].y >= Window.height - players[0].image.height*players[0].scale_y
            GAME_INFO[:scene] = :game_over
        end
    when :game_over
      # ゲームオーバー画面
      Window.draw_font(0, 30, "REPLAY PRESS S_KEY", Font.default)

      # スペースキーが押されたらゲームの状態をリセットし、シーンを変える
      if Input.key_push?(K_S)
        player = Player.new(400, 50, player_img,1, 1)
        players = [player]
        GAME_INFO[:scene] = :playing
      end
    end
  end
end
