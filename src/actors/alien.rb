class AlienView < ActorView
  def draw(target, x_off, y_off, z)
    target.draw_circle_filled(
    #target.draw_circle(
      actor.opts[:x],
      actor.opts[:y],
      50,
      actor.color,
      z,
    )
  end
end

class Alien < Actor
  attr_accessor :health, :color

  has_behaviors :updatable

  def setup
    @color = [0, 255, 0, 255]
    @time_pool = 0
    @catalyst = 1
    reset_health
  end

  def reset_health
    @health = 100
  end

  def shoot
    bullet = spawn :bullet
    bullet.warp vec2(self.x,self.y)+vec2(self.body.rot.x,self.body.rot.y).normalize*30
    bullet.body.a += self.body.a
    bullet.dir = vec2(self.body.rot.x,self.body.rot.y)
    play_sound :laser
  end

  def update(time)
    # Add a little pulsing to the alien
    @time_pool += time
    case @color[1]
    when 245..255
      @catalyst = 5
    when 123..128
      @catalyst = -5
    end
    @color[1] -= @catalyst
  end
end
