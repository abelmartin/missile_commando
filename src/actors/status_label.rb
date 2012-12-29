class StatusLabelView < ActorView
  def draw(target, x_off, y_off, z)
    actor.font.draw(
      "#{actor.text}",
      target.screen.width - actor.width - 50,
      actor.y,
      z,
      1,
      1,
      target.convert_color(actor.color)
    )
  end
end

class StatusLabel < Actor
  attr_reader :strength
  attr_accessor :text, :font, :color

  def setup
    reset_strength
    @text = opts[:text]
    @color = [255,255,255,255]
    @font = @stage.resource_manager.load_font 'Asimov.ttf', 50

    input_manager.reg :down, KbSpace do
      @text = "SPACE BAR HIT"
    end
  end

  def reset_strength
    @strength = 100
  end

  def width
    font.text_width(text)
  end

  def height
    [font.text_width(text),font.height]
  end

  def resize(size)
    @size = size
    resource_manager.load_font @font, @size
  end

end
