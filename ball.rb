# coding: utf-8


class Player < Sprite
  def initialize(x=0, y=0, image=nil, xspeed, yspeed)
  @x, @y, @image = x, y, image
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
    if self.x < 0
      self.x = 0
    end
    
    if self.x > Window.width - self.image.width*self.scale_x
      self.x = Window.width - self.image.width*self.scale_x
    end

    if self.y < 0
      self.y = 0
    end
    
    if self.y > Window.height - self.image.height*self.scale_y
      self.y = Window.height - self.image.height*self.scale_y
    end

    if self.x >= Window.width - self.image.width*self.scale_x || self.x <= 0
      @xspeed *= -1
    end
    if self.y >= Window.height - self.image.height*self.scale_y
      @yspeed *= -0.8
    end
    if self.y <= 0
      @yspeed *= -1  
    end
  end
  
  def shot
   # @xspeed *= -1
    @yspeed *= -1
    if @yspeed < 0
        self.y -= self.image.height*self.scale_y
    end
    if @yspeed > 0
        self.y += self.image.height*self.scale_y
    end
  end
end
