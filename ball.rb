# coding: utf-8

class Player < Sprite
  def initialize(x=0, y=0, image=nil, xspeed, yspeed)
  @x, @y, @image, @point = x, y, image
  @z = 0
  @angle = 0
  @scale_x = @scale_y = 0.4
  if image
     @center_x = 0
     @center_y = 0
   # @center_x = image.width / 2
   # @center_y = image.height / 2
  end
  
  @xspeed = xspeed
  @yspeed = yspeed
  
  @visible = true
  @vanished = false
  _init_collision_info(@image)
  end
  def update
    self.x += @xspeed
    self.y += @yspeed
    @yspeed += 1
    @xspeed *= 0.99
    if self.x < 0
      self.x = 0
    end
    
    if self.x > Window.width - self.image.width*self.scale_x #テレポート
      self.x = Window.width - self.image.width*self.scale_x
    end

    if self.y < 0
      self.y = 0
      #@yspeed *= -1
    end
    
    if self.y > Window.height - self.image.height*self.scale_y #テレポート
      self.y = Window.height - self.image.height*self.scale_y
    end

    if self.x >= Window.width - self.image.width*self.scale_x || self.x <= 0 #壁の反転
      @xspeed *= -1
    end
    if self.y >= Window.height - self.image.height*self.scale_y #床の反転
      @yspeed *= -0.8
    end
    if self.y <= 0 && @yspeed < 0
      @yspeed *= -1
    end
  end
  
  def change_x(flag)
    if flag == 8
        #@yspeed *= 0.1
        @xspeed *= 1.3
        
    elsif flag == 6
        #@xspeed *= 0.2
        @yspeed *= 0.2
        self.x = rand(390)
        self.y = rand(600)
        
    elsif flag == 4
        @xspeed *= 0.2
        @yspeed *= 0.2
        
    elsif flag > 0
        @xspeed += 8
        
    elsif flag < 0
        @xspeed -= 8
    end
  end
  
  def shot
   # @xspeed *= -1
    @yspeed *= 0.98
    @yspeed *= -1
    if @yspeed < 0
        self.y -= self.image.height*self.scale_y
    end
    if @yspeed > 0
        self.y += self.image.height*self.scale_y
    end
  end
end