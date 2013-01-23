class BulletView < ActorView
  def draw(target, x_off, y_off, z)
    target.draw_circle_filled(
      actor.x,
      actor.y,
      actor.bullet_size,
      actor.color,
      z,
    )
  end
end

class Bullet < Actor
  has_behaviors :updatable, physical: {
    shape: :circle,
    mass: 10,
    radius: 5
  }

  attr_reader :speed,
              :power,
              :color,
              :bullet_size,
              :origin,
              :target,
              :shooter

  def setup
    @speed = opts[:speed] || 20
    @power = opts[:power] || 10
    @color = opts[:color] || [255,0,0,255]
    @bullet_size = opts[:bullet_size] || 5
    @shooter = opts[:shooter]

    #If you don't give a origin or target,
    #the bullet will just race across the top of the screen
    @origin = opts[:origin] || {x: 0, y: 0}
    @target = opts[:target] || {x: screen.width, y: 0}

    #Set the starting point against the origin
    self.x = @origin[ :x ]
    self.y = @origin[ :y ]

    #A little "pew pew" for ya
    stage.sound_manager.play_sound :laser

    #Register the shot if it's from a turret
    stage.wave_manager.shot_fired if @shooter.class == Turret
  end

  def lowest_point
    y + bullet_size
  end

  def update(time)
    @dir ||= vec2(@target[:x] - @origin[:x], @target[:y] - @origin[:y])
    physical.body.apply_impulse(@dir*@speed, ZERO_VEC_2) if physical.body.v.length < 100
    super time

    self.remove_self if !still_on_screen? || hit?
  end

  def hit?
    hit = false

    if shooter.class == Turret
      stage.wave_manager.aliens.each do |alien|
        #hit = true if ((x-alien.x)**2 + (y-alien.y)**2 < alien.radius^2)
        #In an ideal world, the formula above would work.  It's how you find
        #a point in a circle.  Instead I'm wrapping the alien in a box and
        #detecting hits on that box

        hit_x = ((alien.x - alien.radius)..(alien.x + alien.radius)).include? x
        hit_y = ((alien.y - alien.radius)..(alien.y + alien.radius)).include? y
        hit = hit_x && hit_y

        if hit
          alien.recieved_hit(@power)
          stage.wave_manager.shot_hit
        end
      end
    elsif shooter.class == Alien
      hit = lowest_point > (stage.shield.y + bullet_size)
      stage.shield.recieved_hit(@power) if hit
    end

    hit
  end

  def still_on_screen?
    (0...screen.width).include?(x) && (0...screen.height).include?(y)
  end
end
