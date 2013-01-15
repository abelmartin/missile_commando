class ShieldView < ActorView
  def draw(target, x_off, y_off, z)
    target.draw_box(
      actor.dimensions[:x1],
      actor.dimensions[:y1],
      actor.dimensions[:x2],
      actor.dimensions[:y2],
      target.convert_color(actor.color), z
    )

    label_zindex = 3
    shield_text = (actor.health > 0) ? "Shield #{actor.health}%" : "GAME OVER"
    font = @stage.resource_manager.load_font 'Abel-Regular.ttf', 50

    font.draw(
      shield_text,
      (target.screen.width/2) - (font.text_width(shield_text)/2),
      target.screen.height - 175,
      label_zindex, 1, 1,
      target.convert_color(actor.color)
    )
  end
end

class Shield < Actor
  #has_behaviors :actor_hit

  attr_reader :dimensions, :health
  attr_accessor :color

  def setup

    @color = [255, 255, 255, 255]
    @dimensions = {
      x1: 5,
      y1: screen.height - 175,
      x2: screen.width - 5,
      y2: screen.height - 125,
    }

    self.x = @dimensions[:x1]
    self.y = @dimensions[:y1]

    reset_health
  end

  def -(amount)
    @health -= amount
    @color = [255, @color[1]-50, @color[2]-50, 255 ]
    @health = 0 if @health < 0
    stage.sound_manager.play_sound :shield_hit if @health > 0
  end

  def recieved_hit(strength)
    self - strength
  end

  private

  def reset_health
    @health = 100
  end
end
