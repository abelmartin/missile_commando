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
    @color = [0, 255, 0, 255]
    @time_pool = 0
    @catalyst = 1
    @radius = 40
    @bullets = []
    reset_health
  end

  def reset_health
    @health = 100
  end

  def shoot
    # bullet's are fired from actor's xy
    @bullets.push( spawn :bullet, x:x, y:y )
    stage.sound_manager.play_sound :laser
  end

  def hit?(bullet)
    bullet.x^2 + bullet.y^2 < radius^2
  end

  def update(time)
    update_color
    movement

    @time_pool += time
    shoot if (10...25).include?(@time_pool % 5000)
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
