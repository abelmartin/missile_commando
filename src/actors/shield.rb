class ShieldView < ActorView
  def draw(target, x_off, y_off, z)
    target.draw_box(
      actor.dimensions[:x1],
      actor.dimensions[:y1],
      actor.dimensions[:x2],
      actor.dimensions[:y2],
      target.convert_color(actor.color), z
    )
  end
end

class Shield < Actor
  #has_behaviors :actor_hit

  attr_reader :dimensions
  attr_accessor :color

  def setup
    @shield_status = spawn :shield_status, z: 3, x: screen.width

    @color = [255, 255, 255, 255]
    @dimensions = {
      x1: 5,
      y1: screen.height - 175,
      x2: screen.width - 5,
      y2: screen.height - 125,
    }

    self.x = @dimensions[:x1]
    self.y = @dimensions[:y1]
  end

  def hit?(bullet)
    bullet.lowest_point > dimensions[:y1] + 5
  end

end
