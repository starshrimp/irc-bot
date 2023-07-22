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
  attr_accessor :current_state
  def initialize(current_state)
   @current_state = current_state
  end
end