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

    @ms_click = false

    input_manager.reg :down, MsLeft do
      @bullet ||= spawn :bullet
      @bullet.x = input_manager.window.mouse_x.to_i
      @bullet.y = input_manager.window.mouse_y.to_i

      stage.status_label.text = "Mouse { X:#{@bullet.x} Y:#{@bullet.y} }"
      @ms_click = true
    end
  end

  def update(time)
    #debug on click and reset
    #debugger if @ms_click
    @ms_click = false if @ms_click

    #Move the cursor crosshair with mouse position
    self.x = input_manager.window.mouse_x.to_i
    self.y = input_manager.window.mouse_y.to_i
  end
end
