class DemoStage < Stage
  require 'debugger'

  attr_reader :score, :shield, :shield_status

  def setup
    super
    @score = spawn :score, x: 10, y: 10
    @shield = spawn :shield
    @shield_status = spawn :shield_status, z: 3

    width = @config_manager[:screen_resolution][0]
    height = @config_manager[:screen_resolution][1]

    screen_segment = width / DENOMINATOR
    turret_height = height - 80

    @turret1 = spawn :turret, x: screen_segment*1, y: turret_height
    @turret2 = spawn :turret, x: screen_segment*3, y: turret_height
    @turret3 = spawn :turret, x: screen_segment*5, y: turret_height

    #@my_actor = spawn :my_actor, x: 50, y: 50
    #@sound_manager.play_sound :laser
  end

  def draw(target)
    super
  end

  def turrets
    [@turret1,@turret2,@turret3]
  end
end

