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
    @clip_size = 2
    @default_width = (screen.width/DENOMINATOR)
    @default_height = 50
    @color = [255, 153, 0, 255]
    self.y = screen.height - 80

    stage.input_manager.reg :down, MsLeft do
      shoot
    end
  end

  def shots_available
    @clip_size - @shots.length
  end

  def update(time)
    @shots.delete_if{ |shot| !shot.alive? }
  end

  private

  def shoot
    #Don't allow shots that target below the shield line
    mouse_y = input_manager.window.mouse_y.to_i
    stage_y = stage.shield.dimensions[:y1]

    if (mouse_y < stage_y) && @shots.length < 2
      #Slightly magic numbers.
      #Fires the bullets from the end of the turret.
      origin = {
        x: x + 60,
        y: y - 50,
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
