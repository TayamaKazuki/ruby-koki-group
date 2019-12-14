# coding: utf-8
require 'dxopal'
include DXOpal

require_remote 'ball.rb'
require_remote 'bumper.rb'
require_remote 'r-flipper.rb'
require_remote 'l-flipper.rb'


Image.register(:player, 'images/ball.png') 
Image.register(:enemy, 'images/bumper.png')
Image.register(:enemy2, 'images/bumper2.png')
Image.register(:flipper, 'images/flipper.png')
Image.register(:item, 'images/item.png')
Image.register(:tit, 'images/title.png')
Image.register(:back, 'images/background.png')
Image.register(:back2, 'images/back2.jpg')
Image.register(:gameover, 'images/gameover.jpg')
Image.register(:wrap, 'images/wrap.png')

Window.load_resources do
  Window.width  = 400
  Window.height = 1000

  GAME_INFO = {
  scene: :title,  # 現在のシーン(起動直後は:title)
  }

  #画像関連-----------------------------------
  player_img = Image[:player]
  flipper_img = Image[:flipper]
  title_img = Image[:tit]
  background_img = Image[:back]
  background2_img = Image[:back2]
  gameover_img = Image[:gameover]
  enemy_img = Image[:enemy]
  enemy2_img = Image[:enemy2]
  item_img =Image[:item]
  wrap_img =Image[:wrap]
  #---------------------------------------------

  #配列-----------------------------------------
  players = []
  enemies = []
  items = []
  warp = []
  flippers_r = []
  flippers_l = []
  #---------------------------------------------
  
  #実体の生成-----------------------------------
  players << Player.new(400, 50, player_img,-1, 1)
  flippers_r << Rflipper.new(390, 700, flipper_img)
  flippers_l << Lflipper.new(10, 700, flipper_img)
  font = Font.new(30,"ＭＳ 明朝",color: C_YELLOW)
  #---------------------------------------------
  
  #初期化---------------------------------------
  pt = 0
  iuni = 2
  uni = iuni #残機
  f_scene = 0
  #---------------------------------------------

  Window.loop do
  
    case GAME_INFO[:scene]
    when :title
      # タイトル画面
      Window.draw(0,0,title_img)
      Window.draw_font(120, 450, "PRESS KEY", font,color: C_YELLOW)
      Window.draw_font(120, 500, "☆1　☆2", font,color: C_YELLOW)
      
      #ステージ選択　（１）ステージ１　（２）ステージ２
      if Input.key_push?(K_1)
        enemies[0] = Enemy.new(200, 80, enemy_img)
        enemies[1] = Enemy.new(100, 220, enemy_img)
        enemies[2] = Enemy.new(300, 220, enemy_img)
        GAME_INFO[:scene] = :playing
        
      elsif Input.key_push?(K_2)
        enemies[0] = Enemy.new(200, 300, enemy2_img)
        enemies[1] = Enemy.new(100, 80, enemy2_img)
        enemies[2] = Enemy.new(300, 80, enemy2_img)
        enemies[3] = Enemy.new(200, 200, enemy_img)
        warp[0] = Enemy.new(200, 30, wrap_img)
        GAME_INFO[:scene] = :playing2
      end
      
      
    when :playing
        #プレイ画面
        f_scene = 1
        #背景
        Window.draw(0,0,background_img)
        #得点表示　残機表示
        Window.draw_font(10,10,"得点:#{pt}",font)
        Window.draw_font(10,40,"ボール:#{uni}",font)
        
        # 更新-----------------------------------------
        Sprite.update(enemies)
        Sprite.update(players)
        Sprite.update(flippers_r)
        Sprite.update(flippers_l)
        #---------------------------------------------
        
        # 描画-----------------------------------------
        Sprite.draw(enemies)
        Sprite.draw(items)
        Sprite.draw(players)
        Sprite.draw(flippers_r)
        Sprite.draw(flippers_l)
        #---------------------------------------------
        
        # 操作----------------------------------------
        #Rを押すとリスタート
        if Input.key_push?(K_R)
            player = Player.new(400, 50, player_img,1, 1)
            players = [player]
        end
        #フリッパー操作（right :（押） 右フリッパー上昇（離）右フリッパー下降、
        #                left : （押）左フリッパー上昇、（離）左フリッパー下降）
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

        
        # 当たり判定----------------------------------
        
        #アイテム
        if players[0] === items
            players[0].change_x(4)   #ボールの減速
            items[0].vanish
        end
        
        #敵
        if players[0] === enemies
            players[0].change_x(8)   #ｘ方向への加速
            pt += 1   #得点追加
            
            #得点が100の倍数の時
            if pt % 100 == 0
                uni += 1   #残機追加
            end
            #得点が50の倍数の時
            if pt % 50 == 0
                item = Enemy.new(220, 150, item_img)   #アイテム出現
                items = [item]
            end
        end
        Sprite.check(players, enemies)
        
        #フリッパー
        if players[0] === flippers_r
            players[0].change_x(flippers_r[0].ang_flag)   #ボールの加速
        end
        if players[0] === flippers_l
            players[0].change_x(flippers_l[0].ang_flag)   #ボールの加速
        end
        Sprite.check(players, flippers_r)
        Sprite.check(players, flippers_l)
        
        #ゲーム遷移
        #下に落ちるかつ残機が1以上の時
        if players[0].y >= Window.height - players[0].image.height*players[0].scale_y && uni != 0
            uni -= 1
            GAME_INFO[:scene] = :restart
        end
        #残機が０の時
        if uni == 0
            GAME_INFO[:scene] = :game_over
        end
        #---------------------------------------------
        
        
    when :playing2
        #プレイ画面(map2)
        f_scene = 2
        #背景
        Window.draw(0,0,background2_img)
        #得点表示　残機表示
        Window.draw_font(10,10,"得点:#{pt}",font,color: [255,50,255,0])
        Window.draw_font(10,40,"ボール:#{uni}",font,color: [255,50,255,0])
        
        #更新-----------------------------------------
        Sprite.update(enemies)
        Sprite.update(warp)
        Sprite.update(flippers_r)
        Sprite.update(flippers_l)
        Sprite.update(players)
        #---------------------------------------------
        
        #描画-----------------------------------------
        Sprite.draw(enemies)
        Sprite.draw(items)
        Sprite.draw(warp)
        Sprite.draw(players)
        Sprite.draw(flippers_r)
        Sprite.draw(flippers_l)
        #---------------------------------------------
    
        #操作----------------------------------------
        #Rを押すとリスタート
        if Input.key_push?(K_R)
            player = Player.new(400, 50, player_img,1, 1)
            players = [player]
        end
        #フリッパー操作（right :（押） 右フリッパー上昇（離）右フリッパー下降、
        #                left : （押）左フリッパー上昇、（離）左フリッパー下降）
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
        
        
        
        # 当たり判定----------------------------------
        if players[0] === items
            players[0].change_x(4)
            items[0].vanish
        end
        if players[1] === items
            players[1].change_x(4)
            items[0].vanish
        end
        
        if players[0] === warp
            players[0].change_x(6)
        end
        if players[1] === warp
            players[1].change_x(6)
        end
        
        if players[0] === enemies
            pt += 1
            if pt % 100 == 0
                uni += 1
            end
            
            if pt % 50 == 0
                if players[1] == nil
                    players[1] = Player.new(400, 50, player_img,1, 1)
                end
                item = Enemy.new(90, 200, item_img)
                items = [item]            
                end
        end
        if players[1] === enemies
            pt += 1
            if pt % 100 == 0
                uni += 1
            end
            
            if pt % 50 == 0
                if players[1] == nil
                    players = Player.new(400, 50, player_img,1, 1)
                end
                item = Enemy.new(90, 200, item_img)
                items = [item]            
                end
        end
        
        Sprite.check(players, enemies)
        
        if players[0] === flippers_r
            players[0].change_x(flippers_r[0].ang_flag)
        end
        if players[1] === flippers_r
            players[1].change_x(flippers_r[0].ang_flag)
        end
        
        if players[0] === flippers_l
            players[0].change_x(flippers_l[0].ang_flag)
        end
        if players[1] === flippers_l
            players[1].change_x(flippers_l[0].ang_flag)
        end
        
        if players[0] === enemies
            players[0].change_x(8)
        end
        if players[1] === enemies
            players[1].change_x(8)
        end
        Sprite.check(players, flippers_r)
        Sprite.check(players, flippers_l)
        
        if players[0].y >= Window.height - players[0].image.height*players[0].scale_y && uni != 0
            uni -= 1
            GAME_INFO[:scene] = :restart
        end
        if players[1] != nil
            if players[1].y >= Window.height - players[0].image.height*players[0].scale_y && uni != 0
                uni -= 1
                GAME_INFO[:scene] = :restart
            end
        end
        if uni == 0
            GAME_INFO[:scene] = :game_over
        end
        #---------------------------------------------
        
    when :restart
        Window.draw_font(20, 30, "CONTINUE PRESS SPACE_KEY", font)

        # スペースキーが押されたらゲームの状態をリセットし、シーンを変える
        if Input.key_push?(K_SPACE)
          player = Player.new(400, 50, player_img,1, 1)
          players = [player]
          if f_scene == 1
            GAME_INFO[:scene] = :playing
          elsif f_scene == 2
            GAME_INFO[:scene] = :playing2
          end
        end
    
    when :game_over
      # ゲームオーバー画面
      Window.draw(0,0,gameover_img)
      Window.draw_font(20, 360, "SCORE:#{pt}", font)
      Window.draw_font(20, 390, "REPLAY PRESS SPACE_KEY", font)
      Window.draw_font(20, 420, "TITLE PRESS T_KEY",font)
      
      # スペースキーが押されたらゲームの状態をリセットし、シーンを変える
      if Input.key_push?(K_SPACE)
        player = Player.new(400, 50, player_img,1, 1)
        players = [player]
        pt = 0
        uni = iuni #残機リセット
        if f_scene == 1 
            GAME_INFO[:scene] = :playing
          elsif f_scene == 2
            GAME_INFO[:scene] = :playing2
         end
      end
      
      if Input.key_push?(K_T)
        player = Player.new(400, 50, player_img,1, 1)
        players = [player]
        pt = 0
        uni = iuni
        if f_scene == 2
           enemies[3].vanish
        end
        GAME_INFO[:scene] = :title
      end
      
    end
  end
end
