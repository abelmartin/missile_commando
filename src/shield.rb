class ShieldView < ActorView
  def draw(target, x_off, y_off, z)
    target.draw_box(
      5,
      target.screen.height - 150,
      target.screen.width - 5,
      target.screen.height - 100,
      [255,255,255,255], z
    )
  end
end

class Shield < Actor
  def setup
    #debugger
  end
end
