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
  #has_behaviors :actor_hit, :updatable
  #has_behaviors :collidable, :updatable

  has_behaviors collidable: {
    shape: :polygon, points: [
      [ 5, 650 ],
      [ 5, 700 ],
      [ 1019, 650 ],
      [ 1019, 700 ],
    ]
  }

  attr_accessor :color, :dimensions

  def setup
    #debugger
    @color = [255, 255, 255, 255]
    @dimensions = {
      x1: 5,
      y1: screen.height - 150,
      x2: screen.width - 5,
      y2: screen.height - 100,
    }
  end

end
