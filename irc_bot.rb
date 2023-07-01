# customize the name of your bot on the following line
@name = "EquineVetBot"

@tree_level = 0
@tree_level_lameness = 0

@repetition_lameness = 0
@horse_general_information
@lameness_diagnostic_program = 0
# This method gets called, whenever a message is sent to our IRC channel. In it you can react to
# the users' inputs in whatever way you like...
def handle_message_colic(message)
  irc_send("PRIVMSG #rubymonstas :Here's further information on colics.")
  irc_send("PRIVMSG #rubymonstas :This is the definition of colic in the horse from wikipedia:")
  irc_send("PRIVMSG #rubymonstas :Colic in horses is defined as abdominal pain, but it is a clinical symptom rather than a diagnosis. The term colic can encompass all forms of gastrointestinal conditions which cause pain as well as other causes of abdominal pain not involving the gastrointestinal tract.")
  irc_send("PRIVMSG #rubymonstas :Does your horse show any of the following symptoms: Enter yes or no")
  irc_send("PRIVMSG #rubymonstas :sweating, elevated heart rate, pawing, frequent change of position e.g. lying down & getting back up, flehmen")
  irc_send("PRIVMSG #rubymonstas :If you want to return to the start, enter return")
end
def colic_likely(message)
  irc_send("PRIVMSG #rubymonstas :Your horse is likely to be experiencing a bout of colic. As colic is a severe and potentially deadly syndrome, you should get a veterinarian involved to asses the gravity of the situation and initiate diagnostics so a treatment plan can be established.")
  irc_send("PRIVMSG #rubymonstas :Here is the number of the equine clinic of the Tierspital Zurich: 044 635 81 15.")
  irc_send("PRIVMSG #rubymonstas :If you're interested in further information on the topic, here is a website containing info about the examination of the colic patient:")
  irc_send("PRIVMSG #rubymonstas :https://www.tierspital.uzh.ch/pferde/magen-darm/kolikuntersuchung/")
  irc_send("PRIVMSG #rubymonstas :Once you have called your veterinarian: would you like to learn more about the possible treatments for colic while your waiting for him to arrive? Answer therapy for more information or return to begin anew")
end
def colic_unlikely(message)
  irc_send("PRIVMSG #rubymonstas :Your horse might not be experiencing a bout of colic. Even though it currently is not showing any of these symptoms, it is still possible that it is in the early stages of colic. In the next few hours, your horse should be supervised. In case of any irregular behaviour, your veterinarian should be contacted and informed immediately.")
  irc_send("PRIVMSG #rubymonstas :If you're interested in learning more about the possible light and severe symptoms of colic and the examinations that can be performed to find the cause, visit this website:")
  irc_send("PRIVMSG #rubymonstas :https://www.tierspital.uzh.ch/pferde/magen-darm/kolikuntersuchung/")
  @tree_level = 0
  irc_send("PRIVMSG #rubymonstas :You will now return to the start.")
end
def colic_therapy(message)
  irc_send("PRIVMSG #rubymonstas :Most colics can be solved conservatively, without the need of surgery. Typical treatments include intravenous fluids, administration of fluids and laxatives via nasogastric tube, walking and spasmolytic as well as analgesic drugs. Here is a website with further information on conservative treatment of colic:")
  irc_send("PRIVMSG #rubymonstas :https://www.tierspital.uzh.ch/pferde/magen-darm/koliktherapie-konservativ/")
  irc_send("PRIVMSG #rubymonstas :More severe colics sometimes call for colic surgery. In colic surgery, the cause for the symptoms is intended to be found and resolved. Colic surgery bears a certain risk - depending on the source, a survival rate of between 50 and 80% is assumed - but often it is the only alternative to euthanasia. Here is a website providing further information on colic surgery and its risks: ")
  irc_send("PRIVMSG #rubymonstas :https://www.tierspital.uzh.ch/pferde/magen-darm/kolikoperationen/")
  irc_send("PRIVMSG #rubymonstas :If you want to return to the start, enter return")
  
end

def handle_message_lameness(message)
  if @repetition_lameness == 0
    irc_send("PRIVMSG #rubymonstas :You chose lameness. ")
    irc_send("PRIVMSG #rubymonstas :This is the definition of lameness by the american college of equine surgeons: ")
    irc_send("PRIVMSG #rubymonstas :Lameness refers to an abnormality of a horse’s gait or stance. It can be caused by pain, a mechanical problem, or a neurological condition. 'Lameness, most commonly results from pain in the musculoskeletal system (muscles, tendons, ligaments, bones, or joints) leading to abnormal movement at the walk, trot, or canter.' ")
  end
  irc_send("PRIVMSG #rubymonstas :There are three different causes for lameness:")
  irc_send("PRIVMSG #rubymonstas :Pain: due to pain, the horse can alter the load on the injured leg and this can cause irregularity in the gait.")
  irc_send("PRIVMSG #rubymonstas :Mechanical lameness: This is not caused by pain but rather by mechanical issues. Examples for this are patellar fixation or abnormal gait due to scar tissue. ")
  irc_send("PRIVMSG #rubymonstas :Neurological lameness: Nerval damage hinders the horse from moving in a normal way.")
  irc_send("PRIVMSG #rubymonstas :What do you think, which cause is the most common?")
  
end

def lameness_pain(message)
  irc_send("PRIVMSG #rubymonstas :You are correct, pain is the most common cause of lameness. ")
  irc_send("PRIVMSG #rubymonstas :The severity of the symptoms in lameness can vary: in severe cases, horses often refrain from bearing any weight on the affected limbs, while in light cases, sometimes a slight head bobbing in trot can be the only visible sign.")
  irc_send("PRIVMSG #rubymonstas :Would you like to start the lameness diagnostic program or would you prefer to just be given some further information to read up on lameness?")
  
end

def lameness_wrong_answer(message)
  irc_send("PRIVMSG #rubymonstas :You are incorrect, this is not the most common cause of lameness.")
  irc_send("PRIVMSG #rubymonstas :You should give it another try!")
  handle_message_lameness(message)
end












def handle_channel_message(message)
  if message.include?("return")
    @tree_level = 0
  end
  if @tree_level == 0
    p message.split[3]
    irc_send("PRIVMSG #rubymonstas :Hello and welcome to the EquineVetBot. What is your emergency?")
    irc_send("PRIVMSG #rubymonstas :I can help you with the following frequent issues in equine medicine: Colic, Lameness, Wounds ")
    irc_send("PRIVMSG #rubymonstas :Enter your issue")
    irc_send("PRIVMSG #rubymonstas :If at any point of the program you want to start over, enter return.")
    @tree_level = 1
    @tree_level_lameness = 1
  end


  #colic
  if @tree_level ==1 && message.include?("colic")
    handle_message_colic(message)
    @tree_level = 2
  end
  if @tree_level ==2 && message.include?("yes")
    colic_likely(message)
    @tree_level = 3
  end
  if @tree_level ==2 && message.include?("no")
    colic_unlikely(message)
  end
  if @tree_level ==3 && message.include?("therapy")
    colic_therapy(message)
  end
  
  #lameness
  if @tree_level_lameness ==1 && message.include?("lameness")
    handle_message_lameness(message)
    @tree_level_lameness = 2
    @repetition_lameness = 1
  end
  if @tree_level_lameness ==2 && message.include?("pain")
    lameness_pain(message)
    @tree_level_lameness = 3
  end
  if @tree_level_lameness ==2 && (message.include?("mechanical") || message.include?("neurological"))
    lameness_wrong_answer(message)
    @tree_level_lameness = 3
  end
  if @tree_level_lameness ==3 && (message.include?("program") || message.include?("diagnostic"))
    irc_send("PRIVMSG #rubymonstas :Welcome to the lameness diagnostic program.")
    irc_send("PRIVMSG #rubymonstas :The first step towards any diagnostic in veterinary medicine is taking a thorough anamnesis.")
    irc_send("PRIVMSG #rubymonstas :Please enter the following general informations about your horse: Name, Type, Age, Usage (Sport/Leisure)")
    @tree_level_lameness = 4
    @lameness_diagnostic_program = 1
    
  end
  if @tree_level_lameness ==4 && @lameness_diagnostic_program == 1
    @horse_general_information = "#{message.split[3]}  #{message.split[4]} #{message.split[5]} #{message.split[6]}"
    irc_send("PRIVMSG #rubymonstas :#{@horse_general_information}")
    
  end







  # Implement your ideas here. 
  # The string in `message` will look something like this: 
  # ":nerdinand!b2c5e1f5@gateway/web/freenode/ip.178.197.225.245 PRIVMSG #rubymonstas :Look at me, I'm here!"
  
  

  # You can use the method `irc_send` to send strings to the IRC server, e.g.
  
end


require_relative './irc_magic.rb'




