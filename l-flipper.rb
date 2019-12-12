# coding: utf-8


class Lflipper < Sprite
  @@flag = 0                            #フラグ
  @@upspeed = 5                         #フリッパーが上がる時の速さ
  @@downspeed = 3                       #フリッパーが下がる時の速さ
  
  def initialize(x=0, y=0, image=nil)   #初期化
  @x, @y, @image = x, y, image
  @z = 0
  @angle = 0
  @scale_x = @scale_y = 0.5
  if image
    #@center_x = image.width / 2
    @center_y = image.height / 2
    @center_x = 0                     #回転の中心を左端にする
  end
  
  @angle = 40                          #角度の初期値
  
  @visible = true
  @vanished = false
  _init_collision_info(@image)
  end
  
  def update
     
     if @@flag == 1                    #スペースを押してる時
         if self.angle >= -40          #フリッパーを打つ
            self.angle -= @@upspeed
        end
     elsif @@flag == 0                 #スペースを押してない時
        if self.angle <= 40            #フリッパーが元の位置に戻る
            self.angle += @@downspeed
       end
     end
 
  end
  
  def hit                               #ballに当たった時
  end
  
  def setflag(val)                      #フラグをセット
      @@flag = val
  end
  
  def ang_flag
      @@aflag = 0
      if self.angle > 5
        @@aflag = 1
      elsif self.angle < 5
        @@aflag = -1
      end
      
      return @@aflag
  end
  
end
