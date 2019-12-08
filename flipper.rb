# coding: utf-8


class Flipper < Sprite
  @@flag = 0
  
  def initialize(x=0, y=0, image=nil)
  @x, @y, @image = x, y, image
  @z = 0
  @angle = 0
  @scale_x = @scale_y = 1.0
  if image
    @center_x = image.width / 2
    @center_y = image.height / 2
    @center_x = @x - @center_x
  end
  
  @angle = 20
  
  @visible = true
  @vanished = false
  _init_collision_info(@image)
  end
  
  def update
     
     if @@flag == 0
         if self.angle >= -10
            self.angle -= 2
        end
     elsif @@flag == 1
        if self.angle <= 20
            self.angle += 1
        elsif self.angle >= 20
            @@flag ==0
       end
     end
 
  end
  
  def hit
  end
  
  
  def f_flag(val)
      @@flag = val
  end
  
end
