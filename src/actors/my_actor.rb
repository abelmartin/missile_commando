class MyActorView < ActorView
  def draw(target, x_off, y_off, z)
    target.draw_box @actor.x,@actor.y, 120, 120, [240,45,45,255], 1
  end
end

class MyActor < Actor

  def setup
    # TODO setup stuff here
    # subscribe for an event or something?
    input_manager.reg :down, KbSpace do
      play_sound :laser
    end
  end

end
