class TurretView < ActorView
  def draw(target, x_off, y_off, z)
    target.draw_box(
      @actor.x,
      @actor.y,
      @actor.x + actor.turret_width,
      @actor.y + 50,
      [20,20,255,255], z
    )
  end
end

class Turret < Actor
  attr_reader :turret_width

  def setup
    @turret_width = (screen.width/DENOMINATOR)
  end
end
