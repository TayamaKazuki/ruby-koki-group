# coding: utf-8


class Player < Sprite
  def initialize(x=0, y=0, image=nil, xspeed, yspeed)
  @x, @y, @image = x, y, image
  @z = 0
  @angle = 0
  @scale_x = @scale_y = 1.0
  if image
    @center_x = image.width / 2
    @center_y = image.height / 2
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
    
    if self.x > Window.width - self.image.width
      self.x = Window.width - self.image.width
    end

    if self.y < 0
      self.y = 0
    end
    
    if self.y > Window.height - self.image.height
      self.y = Window.height - self.image.height
    end

    if self.x >= Window.width - self.image.width || self.x <= 0
      @xspeed *= -1
    end
    if self.y >= Window.height - self.image.height 
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
        self.y -= self.image.height
    end
    if @yspeed > 0
        self.y += self.image.height
    end
  end
end
