class WaveManagerView < ActorView
  def draw(target, x_off, y_off, z)
    #This info should be above everything else.
    z += 100
    y_offset = 0

    actor.font.draw(
      "#{actor.text}",
      (target.screen.width / 2) - (actor.width / 2),
      actor.y, z, 1, 1, target.convert_color(actor.color)
    )

    actor.stats.each do |key, val|
      next unless val
      y_offset += 35
      stat_line = "#{key}: #{val}"
      actor.font.draw(
        stat_line,
        (target.screen.width / 2) - (actor.font.text_width(stat_line) / 2),
        actor.y +  y_offset,
        z, 1, 1, target.convert_color(actor.color)
      )
    end

  end
end

class WaveManager < Actor
  attr_accessor :color
  attr_reader :title,
              :font,
              :text,
              :stats,
              :current_wave,
              :aliens

  has_behaviors :updatable

  def setup
    @aliens = []
    @current_wave = 1
    @text = "Wave #{@current_wave}"
    reset_stats
    @color = [255,255,255,255]
    @font = @stage.resource_manager.load_font 'Abel-Regular.ttf', 50
  end

  def shot_fired
    @stats[:shotsFired] ||= 0
    @stats[:shotsFired] += 1
  end

  def shot_hit
    @stats[:shotsHit] ||= 0
    @stats[:shotsHit] += 1
  end

  def alien_killed
    @stats[:aliensKilled] ||= 0
    @stats[:aliensKilled] += 1
  end

  def reset_stats
    @stats = {
      aliensKiled: nil,
      #shotsDeflected: nil,
      shotsFired: nil,
      shotsHit: nil,
    }
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

  def end_wave
    self.show
  end

  def next_wave
    @current_wave += 1
    reset_stats
    stage.reset_aliens
  end

  def update(time)
    @time_pool ||= 0
    @time_pool += time
    fade_text
    alien_wave
  end

  def alien_wave
    if !visible?
      start_point = Random.rand(screen.width)
      if (@aliens.length <= @current_wave) && (10..35).include?(@time_pool % 10000)
        @aliens.push( spawn :alien,  x: start_point, y: 50 )
      end

      if @aliens.empty?
        @aliens.push( spawn :alien,  x: start_point, y: 50 ) 
      end
    end
  end

  def fade_text
    if (10...50).include?(@time_pool % 100)
      #fade to black
      @color[0] -= 5
      @color[1] -= 5
      @color[2] -= 5
    end

    if @color[0] <= 0
      hide
      @color = [255,255,255]
      next_wave if @aliens.all?{|alien| !alien.visible?} && (@aliens.count == @current_wave + 1)
    end
  end
end
