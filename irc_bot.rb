# customize the name of your bot on the following line
require_relative './irc_bot_methods.rb'

@name = "EquineVetBot"

@chosen_problem = :none
@tree_level = 0
@repetition_lameness = 0
@horse_general_information
@lameness_diagnostic_program = 0
# This method gets called, whenever a message is sent to our IRC channel. In it you can react to
# the users' inputs in whatever way you like...





def handle_channel_message(message)
  if message.include?("return")
    @tree_level = 0
    @chosen_problem = :none
  end
  if @tree_level == 0
    p message.split[3]
    irc_send("PRIVMSG #rubymonstas :Hello and welcome to the EquineVetBot. What is your emergency?")
    irc_send("PRIVMSG #rubymonstas :I can help you with the following frequent issues in equine medicine: Colic, Lameness, Wounds ")
    irc_send("PRIVMSG #rubymonstas :Enter your issue")
    irc_send("PRIVMSG #rubymonstas :If at any point of the program you want to start over, enter return.")
    @tree_level = 1
    @tree_level = 1
  end


  #colic
  
  if @tree_level ==1 && message.downcase.include?("colic")
    @chosen_problem = :colic
  end
  
  if @chosen_problem == :colic
    if @tree_level==1 && message.downcase.include?("colic")
      handle_message_colic(message)
      @tree_level = 2
    end
    if @tree_level ==2 && message.downcase.include?("yes")
      colic_likely(message)
      @tree_level = 3
    end
    if @tree_level ==2 && message.downcase.include?("no")
      colic_unlikely(message)
    end
    if @tree_level ==3 && message.downcase.include?("therapy")
      colic_therapy(message)
    end
  end

  #lameness
  if @tree_level ==1 && message.downcase.include?("lameness")
    @chosen_problem = :lameness
  end
  if @chosen_problem == :lameness
    if @tree_level ==1 && message.downcase.include?("lameness")
      handle_message_lameness(message)
      @tree_level = 2
      @repetition_lameness = 1
    end
    if @tree_level ==2 && message.downcase.include?("pain")
      lameness_pain(message)
      @tree_level = 3
    end
    if @tree_level ==2 && (message.downcase.include?("mechanical") || message.downcase.include?("neurological"))
      lameness_wrong_answer(message)
      @tree_level = 2
    end
    if @tree_level ==3 && (message.downcase.include?("program") || message.downcase.include?("diagnostic"))
      program_lameness_diagnostic(message)
      @tree_level = 4
      @lameness_diagnostic_program = 1
    end
    if @tree_level ==4 && @lameness_diagnostic_program == 1 && (message.include?("diagnostic") == false || message.include?("program") == false)
      program_ld_anamnesis(message)
    end
  end







  # Implement your ideas here. 
  # The string in `message` will look something like this: 
  # ":nerdinand!b2c5e1f5@gateway/web/freenode/ip.178.197.225.245 PRIVMSG #rubymonstas :Look at me, I'm here!"
  
  

  # You can use the method `irc_send` to send strings to the IRC server, e.g.
  
end


require_relative './irc_magic.rb'




