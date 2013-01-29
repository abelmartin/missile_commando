module DelayedActions
  def delayed_action(uid, delay)
    current_tick = Time.now
    _tick = "@#{uid}_last_tick"
    eval("#{_tick} ||= current_tick")

    if eval("current_tick - #{_tick} > delay")
      yield
      eval("#{_tick} = current_tick")
    end
  end
end
