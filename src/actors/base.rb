class BaseView < ActorView
  def draw(target, x_off, y_off, z)
    target.draw_box(
      actor.x,
      actor.y,
      actor.x + actor.default_width,
      actor.y + actor.default_height,
      [20,20,255,255], z
    )
  end
end

class Base < Actor
  attr_reader :default_width, :default_height

  def setup
    @default_width = (screen.width/DENOMINATOR)
    @default_height = 50
    self.y = screen.height - 80
  end
end
