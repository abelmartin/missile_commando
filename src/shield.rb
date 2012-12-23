class ShieldView < ActorView
  #require 'debugger'

  def draw(target, x_off, y_off, z)
    target.draw_box(
      5,
      SCREEN_HEIGHT - 150,
      SCREEN_WIDTH - 5,
      SCREEN_HEIGHT - 100,
      [255,255,255,255], z
    )

    font = @stage.resource_manager.load_font 'Asimov.ttf', 50
    font.draw( 
      'Shield 100%',
      (SCREEN_WIDTH/2) - 120,
      SCREEN_HEIGHT - 150,
      z,
    )
  end
end

class Shield < Actor
  def setup
  end

  def shield_shape
  end
end
