class ActorHit < Behavior

  attr_accessor :hit_color, :original_color, :duration

  def setup
  end

  # rotate
  def update(time_delta)
    @count %= @rot_array.size
    @rotation = @rot_array[@count]
    @count += 3
  end
end
