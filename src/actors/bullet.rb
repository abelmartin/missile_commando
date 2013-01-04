class BulletView < ActorView
  def draw(target, x_off, y_off, z)
    target.draw_circle_filled(
      actor.x + x_off,
      actor.y + y_off,
      actor.bullet_size,
      actor.color,
      z,
    )

    stage.status_label.text = "Mouse { X:#{actor.x} Y:#{actor.y} }"

  end
end

class Bullet < Actor
  has_behaviors :updatable, collidable: {
    shape: :polygon, points: [
      [ 5, 650 ],
      [ 5, 700 ],
      [ 1019, 650 ],
      [ 1019, 700 ],
    ]
  }

  attr_accessor :dir, :color
  attr_reader :speed, :power, :bullet_size

  def setup
    @speed = opts[:speed] || 400
    @power = opts[:power] || 10
    @color = [255,0,0,255]
    @time = 0
    @bullet_size = 5
  end

  def update(time)
    #physical.body.apply_impulse(@dir*time*@speed, ZERO_VEC_2) if physical.body.v.length < 400
    #super time
    @time += time
    if @time % 500 == 0
      if visible?
        self.show
      else
        self.hide
      end

      @time = 0
    end
  end

end
