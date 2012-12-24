class ShieldView < ActorView
  def draw(target, x_off, y_off, z)
    target.draw_box(
      5,
      target.screen.height - 150,
      target.screen.width - 5,
      target.screen.height - 100,
      [255,255,255,255], z
    )

    font = @stage.resource_manager.load_font 'Asimov.ttf', 50
    font.draw(
      'Shield 100%',
      (target.screen.width/2) - 120,
      target.screen.height - 150,
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
