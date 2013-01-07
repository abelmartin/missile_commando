class TurretView < ActorView
  def draw(target, x_off, y_off, z)
    # Big box
    target.draw_box(
      actor.x,
      actor.y,
      actor.x + actor.default_width,
      actor.y + actor.default_height,
      [255, 153, 0, 255], z
    )

    # Small box on top
    reduction = 50
    target.draw_box(
      actor.x + reduction,
      actor.y - reduction + 20,
      actor.x + actor.default_width - reduction,
      actor.y + actor.default_height - reduction,
      [255, 153, 0, 255], z
    )
  end
end

class Turret < Actor
  attr_reader :default_width, :default_height

  def setup
    @default_width = (screen.width/DENOMINATOR)
    @default_height = 50
    self.y = screen.height - 80
  end
end
