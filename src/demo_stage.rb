class DemoStage < Stage
  def setup
    super
    @score = spawn :score, :x => 10, :y => 10
    @shield = spawn :shield

    bounded_screen = SCREEN_WIDTH - 100
    screen_third = bounded_screen / 3
    turret_height= SCREEN_HEIGHT - 80
    @turret1 = spawn :turret, :x => screen_third, :y => turret_height
    @turret2 = spawn :turret, :x => screen_third*2, :y => turret_height
    @turret3 = spawn :turret, :x => screen_third*3, :y => turret_height

    #@my_actor = spawn :my_actor, :x => 50, :y => 50
    #@sound_manager.play_sound :laser
  end

  def draw(target)
    super
  end
end

