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
  include DelayedActions

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
    reset_stats_and_info
    @color = [255,255,255,255]
    @font = stage.resource_manager.load_font 'Abel-Regular.ttf', 50

    @alien_label = spawn :alien_label,
                          x: (screen.width - 100),
                          y: 0,
                          text: "Aliens Left: 0"
  end

  def alien_limit
    @current_wave + 1
  end

  def aliens_left
    alien_limit - aliens.select{|alien| !alien.alive?}.length
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

  def reset_stats_and_info
    @text = "Wave #{@current_wave}"
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

  def next_wave
    @current_wave += 1
    @aliens = []
    reset_stats_and_info
    show
  end

  def update(time)
    @time_pool ||= 0
    @time_pool += time
    wave_info
    alien_wave

    show if aliens_left == 0
  end

  def alien_wave
    # Releasing the hounds
    if !visible?
      start_point = Random.rand(screen.width)

      delayed_action('alien' ,10) do
        @aliens.push( spawn :alien,  x: start_point, y: 50, speed: @current_wave )
      end if (@aliens.length <= @current_wave)

      if @aliens.empty?
        @aliens.push( spawn :alien,  x: start_point, y: 50 )
      end
    end

    # Updating the label
    @alien_label.text = "Aliens Left: #{aliens_left}"
  end

  def wave_info
    delayed_action('text_fade' ,0.025) do
      #fade to black
      @color[0] -= 5
      @color[1] -= 5
      @color[2] -= 5
    end if visible?

    if @color[0] <= 0
      hide
      @color = [255,255,255]

      if aliens_left == 0
        next_wave
      end
    end
  end
end
