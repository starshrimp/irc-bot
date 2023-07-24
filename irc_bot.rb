# customize the name of your bot on the following line
require_relative './irc_bot_methods.rb'
require_relative './irc_bot_classes.rb'

@name = "EquineVetBot"

@chosen_problem = :none
@tree_level = 0
@repetition_lameness = 0
@lameness_diagnostic_program = 0
@state = Diagnostic_state.new(0)


def handle_channel_message(message)
  if message.include?("start")
    @tree_level = 0
    @chosen_problem = :none
    @repetition_lameness = 0
  end

  if @tree_level == 0
    p message.split[3]
    irc_send("PRIVMSG #rubymonstas :Hello and welcome to the EquineVetBot. What is your emergency?")
    irc_send("PRIVMSG #rubymonstas :I can help you with the following frequent issues in equine medicine: Colic, Lameness, Wounds ")
    irc_send("PRIVMSG #rubymonstas :Enter your issue")
    irc_send("PRIVMSG #rubymonstas :If at any point of the program you want to start over, enter start.")
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
      
    elsif @tree_level ==3 && message.downcase.include?("pain")
      lameness_pain(message)
      @tree_level = 4
    elsif @tree_level ==3 && (message.downcase.include?("mechanical") || message.downcase.include?("neurological"))
      lameness_wrong_answer(message)
      @tree_level = 2
      @repetition_lameness = 2
    
    elsif @lameness_diagnostic_program == 1 && @tree_level ==3
      if @state.current_state == 0 #left off here, implementing class state feature
        program_ld_history(message)
        @state.next
        sleep(1)
      elsif message.downcase.include?("back")
        @state.back
        @state.corrector =1
        if @state.current_state == -1
          program_lameness_diagnostic(message)
          @tree_level = 3
          @lameness_diagnostic_program = 1
          @state = Diagnostic_state.new(0)
        elsif @state.current_state == 1
          program_ld_duration(message)
          @state.next
        elsif  @state.current_state == 2
          program_ld_severity(message)
          @state.next
        elsif  @state.current_state == 3
          program_ld_location(message)
          @state.next
        elsif  @state.current_state == 4
          program_ld_routine(message)
          @state.next
        elsif  @state.current_state == 5
          program_ld_environment(message)
          @state.next
        elsif  @state.current_state == 6
          program_ld_hoofcare(message)
          @state.next
        elsif  @state.current_state == 7
          program_ld_recentinjuries(message)
          @state.next
        elsif  @state.current_state == 8
          program_ld_previoustherapy(message)
          @state.next
        elsif  @state.current_state == 9
          program_ld_othersigns(message)
          @state.next
        elsif  @state.current_state == 10
          program_ld_finished(message)
          @state.next 
        end
      elsif @state.current_state == 1
        program_ld_duration(message)
        @state.next
      elsif  @state.current_state == 2
        program_ld_severity(message)
        @state.next
      elsif  @state.current_state == 3
        program_ld_location(message)
        @state.next
      elsif  @state.current_state == 4
        program_ld_routine(message)
        @state.next
      elsif  @state.current_state == 5
        program_ld_environment(message)
        @state.next
      elsif  @state.current_state == 6
        program_ld_hoofcare(message)
        @state.next
      elsif  @state.current_state == 7
        program_ld_recentinjuries(message)
        @state.next
      elsif  @state.current_state == 8
        program_ld_previoustherapy(message)
        @state.next
      elsif  @state.current_state == 9
        program_ld_othersigns(message)
        @state.next
      elsif  @state.current_state == 10
        program_ld_finished(message)
        @state.next
      elsif  @state.current_state == 11 
        program_ld_summary(message)
        @state.next
      elsif @state.finished == true 
        @state.corrector =1 #run test whether this works!
        check_for_corrections(message)
      end
    end
  end

  # ":nerdinand!b2c5e1f5@gateway/web/freenode/ip.178.197.225.245 PRIVMSG #rubymonstas :Look at me, I'm here!"
end


require_relative './irc_magic.rb'



