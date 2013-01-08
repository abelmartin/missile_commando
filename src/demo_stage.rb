class DemoStage < Stage
  attr_reader :score, :shield, :status_label, :bases, :aliens

  def setup
    super
    @bases = []
    @aliens = []

    @score = spawn :score, x: 10, y: 10
    @cursor = spawn :cursor, z: 10
    @shield = spawn :shield, z: 1
    @status_label = spawn :status_label, x: (width - 100), y: 0, text: "Debug Info"

    screen_segment = width / DENOMINATOR
    base_height = height - 80

    bases[ 0 ] = spawn :base, x: screen_segment*0 + 5
    bases[ 1 ] = spawn :base, x: screen_segment*2
    bases[ 2 ] = spawn :base, x: screen_segment*6
    bases[ 3 ] = spawn :base, x: screen_segment*8

    @turret = spawn :turret, x: screen_segment*4, y: base_height
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

  def update(time)
    super time

    #@time_pool ||= 0
    #@time_pool += time

    #if (10..35).include?(@time_pool % 10000)
      #aliens.push( spawn :alien,  x: width / 2, y: 50 )
    #end

    aliens.push( spawn :alien,  x: width / 2, y: 50 ) if aliens.empty?
  end
end

