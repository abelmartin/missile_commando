class CursorView < ActorView
  def draw(target, x_off, y_off, z)
    #Draw a cross-hair to show cursor position

    target.draw_line(
      actor.x - actor.cursor_size,
      actor.y,
      actor.x + actor.cursor_size,
      actor.y,
      actor.color,
      z,
    )

    target.draw_line(
      actor.x,
      actor.y - actor.cursor_size,
      actor.x,
      actor.y + actor.cursor_size,
      actor.color,
      z,
    )
  end
end

class Cursor < Actor
  #has_behaviors :updatable

  attr_accessor :color
  attr_reader :cursor_size

  def setup
    @color = [255,0,0,255]
    @cursor_size = 15
  end
end