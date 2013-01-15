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

  attr_reader :speed, :power, :color, :bullet_size, :origin, :target

  def setup
    @speed = opts[:speed] || 20
    @power = opts[:power] || 10
    @color = opts[:color] || [255,0,0,255]
    @bullet_size = opts[:bullet_size] || 5

    #If you don't give a origin or target,
    #the bullet will just race across the top of the screen
    @origin = opts[:origin] || {x: 0, y: 0}
    @target = opts[:target] || {x: screen.width, y: 0}

    #Set the starting point against the origin
    self.x = @origin[ :x ]
    self.y = @origin[ :y ]

    # A little "pew pew" for ya
    stage.sound_manager.play_sound :laser
  end

  def lowest_point
    y + bullet_size
  end

  def update(time)

    @dir ||= vec2(@target[:x] - @origin[:x], @target[:y] - @origin[:y])
    physical.body.apply_impulse(@dir*@speed, ZERO_VEC_2) if physical.body.v.length < 100
    super time

    #if reached_target?(self)
      #stage.status_label.text = "collide"
    #end

    self.remove_self unless still_on_screen?
  end

  def still_on_screen?
    (0...screen.width).include?(x) && (0...screen.height).include?(y)
  end

end
