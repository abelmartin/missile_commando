class TurretView < ActorView
  def draw(target, x_off, y_off, z)
    # Big box
    target.draw_box(
      actor.x,
      actor.y,
      actor.x + actor.default_width,
      actor.y + actor.default_height,
      actor.color, z
    )

    # Small box on top
    reduction = 50
    target.draw_box(
      actor.x + reduction,
      actor.y - reduction + 20,
      actor.x + actor.default_width - reduction,
      actor.y + actor.default_height - reduction,
      actor.color, z
    )
  end
end

class Turret < Actor
  has_behaviors :updatable
  attr_reader :default_width, :default_height, :color

  def setup
    @shots = []
    @default_width = (screen.width/DENOMINATOR)
    @default_height = 50
    @color = [255, 153, 0, 255]
    self.y = screen.height - 80

    @ms_click = false
    stage.input_manager.reg :down, MsLeft do
      shoot
    end
  end

  def update(time)
    #debug on click and reset
    #debugger if @ms_click
    #@ms_click = false if @ms_click

    #shot_count = @shots.length

    @shots.delete_if{ |shot| !shot.alive? }

    #debugger if @shots.length != shot_count
    #dummy = 1
  end

  private

  def shoot
    #@ms_click = true
    if @shots.length <= 5
      origin = {
        x: x + 60,
        y: y - 60,
      }

      target = {
        x: input_manager.window.mouse_x.to_i,
        y: input_manager.window.mouse_y.to_i,
      }

      bullet = spawn :bullet,
                      color: @color,
                      origin: origin,
                      target: target,
                      shooter: self

      @shots.push bullet
    end
  end
end
