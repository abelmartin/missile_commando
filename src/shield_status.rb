class ShieldStatusView < ActorView
  def draw(target, x_off, y_off, z)
    font = @stage.resource_manager.load_font 'Asimov.ttf', 50
    font.draw(
      "Shield #{actor.strength}%",
      (target.screen.width/2) - 120,
      target.screen.height - 150,
      z,
      1,
      1,
      target.convert_color(actor.color)
    )
  end
end

class ShieldStatus < Actor
  attr_reader :strength, :color

  def setup
    reset_strength
    @color = [255,255,255,255]
    input_manager.reg :down, KbSpace do
      self - 15
      #play_sound :laser
    end
  end

  def -(amount)
    @strength -= amount
    @color = [255, @color[1]-50, @color[2]-50, 255 ]
    @strength = 0 if @strength < 0
  end

  def reset_strength
    @strength = 100
  end
end
