class BulletView < ActorView
  def draw(target, x_off, y_off, z)
    target.draw_circle_filled(
      actor.x + x_off,
      actor.y + y_off,
      actor.bullet_size,
      actor.color,
      z,
    )
  end
end

class Bullet < Actor
  has_behaviors :updatable

  attr_reader :speed, :power, :color, :bullet_size, :origin, :target

  def setup
    @speed = opts[:speed] || 1000
    @power = opts[:power] || 10
    @color = opts[:color] || [255,0,0,255]
    @bullet_size = opts[:bullet_size] || 5

    #If you don't give a origin or target,
    #the bullet will just race across the top of the screen
    @origin = opts[:origin] || {x: 0, y: 0}
    @target = opts[:target] || {x: screen.width, y: 0}

    #Set the starting point against the origin
    self.x = @origin{:x}
    self.y = @origin{:y}
  end

  def lowest_point
    y + bullet_size
  end

  def update(time)
    @time ||= 0

    @time += time
    if (0..25).include?(@time_pool % @speed)
      self.x += origin{:x} - target{:x}
      self.y += origin{:y} - target{:y}
    end

    #if stage.shield.hit?(self)
      #stage.status_label.text = "collide"
    #end
  end

end
