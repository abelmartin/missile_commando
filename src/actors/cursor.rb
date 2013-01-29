class CursorView < ActorView
  def draw(target, x_off, y_off, z)
    #Draw a cross-hair to show cursor position

    #[1] Draw horizontal line
    target.draw_line(
      actor.x - actor.cursor_size,
      actor.y,
      actor.x + actor.cursor_size,
      actor.y,
      actor.color,
      z,
    )

    #[2] Draw vertical line
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
  has_behaviors :updatable

  attr_accessor :color
  attr_reader :cursor_size

  def setup
    @color = [255,0,0,255]
    @cursor_size = 15
  end

  def update(time)
    #Move the cursor crosshair with mouse position
    self.x = input_manager.window.mouse_x.to_i
    self.y = input_manager.window.mouse_y.to_i
  end
end
