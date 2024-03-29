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
    self.x += 2 * @xspeed
    self.y += 2 * @yspeed + 2
    if self.x >= Window.width - self.image.width || self.x <= 0
      @xspeed *= -1
    end
    if self.y >= Window.height - self.image.height || self.y <= 0
      @yspeed *= -1
    end
  end
  def shot
    @xspeed *= -1
    @yspeed *= -1
  end
end
