class AlienView < ActorView
  def draw(target, x_off, y_off, z)
    target.draw_circle_filled(
    #target.draw_circle(
      actor.x,
      actor.y,
      actor.radius,
      actor.color,
      z,
    )
  end
end

class Alien < Actor
  attr_reader :health, :color, :radius

  has_behaviors :updatable
  #has_behaviors :actor_hit

  def setup
    @shots = []
    @color = [0, 255, 0, 255]
    @catalyst = 1
    @radius = 40
    reset_health
  end

  def reset_health
    @health = 100
  end

  def shoot
    # bullet's are fired from actor's xy
    origin = {
      x: x,
      y: y,
    }

    # alien target is somewhere on the shield
    target = {
      x: Random.rand(screen.width),
      y: stage.shield.y + 5,
    }

    #Only allow aliens to fire 2 bullets at any given time.
    @shots.push(
      spawn :bullet,
            color: @color,
            origin: origin,
            target: target,
            speed: 3,
            shooter: self
    ) unless @shots.length >= 2
  end

  #def hit?(bullet)
    #bullet.x^2 + bullet.y^2 < radius^2
  #end

  def update(time)
    @time_pool ||= 0

    update_color
    movement
    @shots.delete_if{ |shot| !shot.alive? }

    @time_pool += time
    shoot if (10...25).include?(@time_pool % 2000)

  end

  private

  def movement
    rate = 10
    @update_value ||= rate

    case x
    when (screen.width - radius)..screen.width
      @update_value = -1*rate
      self.y += rate
    when 0..radius
      @update_value = rate
      self.y += rate
    end

    self.x += @update_value
  end

  def update_color
    # Add a little pulsing to the alien
    case @color[1]
    when 245..255
      @catalyst = 5
    when 123..128
      @catalyst = -5
    end
    @color[1] -= @catalyst
  end

end
