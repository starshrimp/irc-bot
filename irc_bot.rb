# customize the name of your bot on the following line
require_relative './irc_bot_methods.rb'

@name = "EquineVetBot"

@chosen_problem = :none
@tree_level = 0
@repetition_lameness = 0
@lameness_diagnostic_program = 0
@lameness_diagnostic_state
@horse_general_information
@horse_history
@horse_duration
@horse_severity
@horse_location
@horse_routine
@horse_environment
@horse_hoofcare
@horse_recentinjuries
@horse_previoustherapy
@horse_othersigns
@corrector


def handle_channel_message(message)
  if message.include?("return")
    @tree_level = 0
    @chosen_problem = :none
    @repetition_lameness = 0
  end
  if @lameness_diagnostic_state==:corrections
    check_for_corrections(message)
  end
  if @tree_level == 0
    p message.split[3]
    irc_send("PRIVMSG #rubymonstas :Hello and welcome to the EquineVetBot. What is your emergency?")
    irc_send("PRIVMSG #rubymonstas :I can help you with the following frequent issues in equine medicine: Colic, Lameness, Wounds ")
    irc_send("PRIVMSG #rubymonstas :Enter your issue")
    irc_send("PRIVMSG #rubymonstas :If at any point of the program you want to start over, enter return.")
    @tree_level = 1
  end


  #colic
  
  if @tree_level ==1 && message.downcase.include?("colic")
    @chosen_problem = :colic
    handle_message_colic
    @tree_level = 2
  end
  
  if @chosen_problem == :colic
    if @tree_level ==2 && message.downcase.include?("yes")
      colic_likely(message)
      @tree_level = 3
    elsif @tree_level ==2 && message.downcase.include?("no")
      colic_unlikely(message)
    elsif @tree_level ==3 && message.downcase.include?("therapy")
      colic_therapy(message)
    end
  end

  #lameness
  if @tree_level ==1 && message.downcase.include?("lameness")
    @chosen_problem = :lameness
    handle_message_lameness(message)
    @tree_level = 2
    @repetition_lameness = 1
  end
  if @chosen_problem == :lameness
    if @tree_level ==2  && (message.downcase.include?("program") == false || message.downcase.include?("diagnostic") == false) && (message.include?("information") == true ||@repetition_lameness == 2)
      lameness_information_quiz(message)
      @tree_level = 3
    elsif @tree_level ==2 && (message.downcase.include?("program") || message.downcase.include?("diagnostic"))
      program_lameness_diagnostic(message)
      @tree_level = 3
      @lameness_diagnostic_program = 1
      @lameness_diagnostic_state= :start
    elsif @tree_level ==3 && message.downcase.include?("pain")
      lameness_pain(message)
      @tree_level = 4
    elsif @tree_level ==3 && (message.downcase.include?("mechanical") || message.downcase.include?("neurological"))
      lameness_wrong_answer(message)
      @tree_level = 2
      @repetition_lameness = 2
    
    elsif @lameness_diagnostic_program == 1 && @tree_level ==3
      if @tree_level ==3 && (message.include?("diagnostic") == false || message.include?("program") == false) && @lameness_diagnostic_state== :start
        program_ld_history(message)
        @lameness_diagnostic_state= :history
      elsif @lameness_diagnostic_program == 1 && message.include?("back")
        program_lameness_diagnostic(message)
      elsif @lameness_diagnostic_state==:history
      program_ld_duration(message)
      @lameness_diagnostic_state=:duration
      elsif @lameness_diagnostic_state==:duration
      program_ld_severity(message)
      @lameness_diagnostic_state= :severity
      elsif @lameness_diagnostic_state==:severity
      program_ld_location(message)
      @lameness_diagnostic_state= :location
      elsif @lameness_diagnostic_state==:location
      program_ld_routine(message)
      @lameness_diagnostic_state= :routine
      elsif @lameness_diagnostic_state==:routine
      program_ld_environment(message)
      @lameness_diagnostic_state= :environment
      elsif @lameness_diagnostic_state==:environment
      program_ld_hoofcare(message)
      @lameness_diagnostic_state= :hoofcare
      elsif @lameness_diagnostic_state==:hoofcare
      program_ld_recentinjuries(message)
      @lameness_diagnostic_state= :recentinjuries
      elsif @lameness_diagnostic_state==:recentinjuries
      program_ld_previoustherapy(message)
      @lameness_diagnostic_state= :previoustherapy
      elsif @lameness_diagnostic_state==:previoustherapy
      program_ld_othersigns(message)
      @lameness_diagnostic_state= :othersigns
      elsif @lameness_diagnostic_state==:othersigns
      program_ld_finished(message)
      @lameness_diagnostic_state= :finished
      elsif @lameness_diagnostic_state==:finished
      program_ld_summary(message)
      @lameness_diagnostic_state= :corrections

      end
    end
  end

  # ":nerdinand!b2c5e1f5@gateway/web/freenode/ip.178.197.225.245 PRIVMSG #rubymonstas :Look at me, I'm here!"
end


require_relative './irc_magic.rb'


#change if if if to elsif



