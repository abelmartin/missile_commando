class TurretView < ActorView
  def draw(target, x_off, y_off, z)
    target.draw_box @actor.x, @actor.y, 90, 90, [20,20,255,255], 1
  end
end

class Turret < Actor
  def setup

  end
end
