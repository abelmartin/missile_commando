class DemoStage < Stage
  attr_reader :score, :shield, :shield_status, :status_label

  def setup
    super

    @score = spawn :score, x: 10, y: 10
    @cursor = spawn :cursor, z: 10
    @shield = spawn :shield, z: 1
    @shield_status = spawn :shield_status, z: 3
    @status_label = spawn :status_label, x: (width - 100), y: 10, text: "TEST"

    screen_segment = width / DENOMINATOR
    turret_height = height - 80

    @alien1 = spawn :alien,  x: width / 2, y: 200

    @turret1 = spawn :turret, x: screen_segment*1, y: turret_height
    @turret2 = spawn :turret, x: screen_segment*3, y: turret_height
    @turret3 = spawn :turret, x: screen_segment*5, y: turret_height

    @ms_on = false

    input_manager.reg :down, MsLeft do
      @bullet ||= spawn :bullet
      @bullet.x = input_manager.window.mouse_x.to_i
      @bullet.y = input_manager.window.mouse_y.to_i
      @ms_click = true
    end
  end

  def draw(target)
    super
  end

  def width
    @config_manager[:screen_resolution][0]
  end

  def height
    @config_manager[:screen_resolution][1]
  end

  def turrets
    [@turret1, @turret2, @turret3]
  end

  def aliens
    [@alien1]
  end

  def update(time)
    #debugger if @ms_click
    @ms_click = false if @ms_click

    #if @bullet && @shield && collide?( @bullet, @shield )
      #@status_label.text = "collide"
    #end

    #Move the cursor crosshair with mouse position
    @cursor.x = input_manager.window.mouse_x.to_i
    @cursor.y = input_manager.window.mouse_y.to_i
  end
end

