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
    @speed = opts[:speed] || 100
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
  end

  def lowest_point
    y + bullet_size
  end

  def update(time)
    @time_pool ||= 0

    #debugger
    @time_pool += time

    if (0..35).include?(@time_pool % @speed)
      delta_x = (@target[ :x ] - @origin[ :x ]).to_f
      delta_y = ((-1 * @target[ :y ]) - (-1 * @origin[ :y ])).to_f
      slope =  delta_x / delta_y
      #debugger
      #stage.status_label.text = slope

      #Once we have the slope, we can figure out movement.
      #when adding the simple number make sure to keep the pos/neg of the equation.
      #in a whole number slope (ex:4/1), do the following
      if slope >= 1
        numerator = slope.finite? ? slope : 
        self.x += (slope * 10).to_i
        self.y += (delta_y >=0) ? -10 : 10
      else
        #in a fraction slope (ex:1/4), do the following
        denominator = 10000 / (slope * 10000)
        self.x += (delta_x >=0) ? 10 : -10
        self.y += (delta_y >=0) ? denominator * -10 : denominator * 10
      end
    end

    #if stage.shield.hit?(self)
      #stage.status_label.text = "collide"
    #end
  end

end
