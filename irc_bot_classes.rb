class Horse
  attr_accessor :signalement, :history, :duration, :severity, :location, :routine, :environment, :hoofcare, :recentinjuries, :previoustherapy, :othersigns
 def initialize(signalement)
  @signalement = signalement
  @history
  @duration
  @severity
  @location
  @routine
  @environment
  @hoofcare
  @recentinjuries
  @previoustherapy
  @othersigns
 end

end

class Diagnostic_state
  attr_accessor :current_state, :corrector, :finished
  def initialize(current_state)
    @current_state = current_state
    @corrector = corrector
    @finished = finished
  end
  def next
    return @current_state += 1
  end
  def back
    return @current_state -= 2
  end

end
