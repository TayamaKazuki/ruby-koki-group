=begin
class Enemy < Sprite

 
 def update 
    #self.y += 1
    if self.y >= Window.height - self.image.height
      self.vanish
    end
  end 
  

 

  # 他のオブジェクトから衝突された際に呼ばれるメソッド
  def hit
   
     
   # self.vanish
  end
end

=end
require "dxopal"
include DXOpal

Window.width = 300
Window.height = 300
Window.bgcolor = C_WHITE


Window.load_resources do

 Window.draw_circle_fill(50, 50, 10, C_RED)
 
end

