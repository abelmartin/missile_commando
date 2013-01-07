class AlienView < ActorView
  def draw(target, x_off, y_off, z)
    target.draw_circle_filled(
    #target.draw_circle(
      actor.opts[:x],
      actor.opts[:y],
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
    reset_health
  end

  def reset_health
    @health = 100
  end

  def shoot
    bullet = spawn :bullet
    play_sound :laser
  end

  def hit?(bullet)
    bullet.x^2 + bullet.y^2 < radius^2
  end

  def update(time)
    update_color
  end

  private

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
