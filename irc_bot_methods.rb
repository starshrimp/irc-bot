def handle_message_colic
  irc_send("PRIVMSG #rubymonstas :Here's further information on colics.")
  irc_send("PRIVMSG #rubymonstas :This is the definition of colic in the horse from wikipedia:")
  irc_send("PRIVMSG #rubymonstas :Colic in horses is defined as abdominal pain, but it is a clinical symptom rather than a diagnosis. The term colic can encompass all forms of gastrointestinal conditions which cause pain as well as other causes of abdominal pain not involving the gastrointestinal tract.")
  irc_send("PRIVMSG #rubymonstas :Does your horse show any of the following symptoms: Enter yes or no")
  irc_send("PRIVMSG #rubymonstas :sweating, elevated heart rate, pawing, frequent change of position e.g. lying down & getting back up, flehmen")
  irc_send("PRIVMSG #rubymonstas :If you want to return to the start, enter start")
  @chosen_problem = :colic
end
def colic_likely(message)
  irc_send("PRIVMSG #rubymonstas :Your horse is likely to be experiencing a bout of colic. As colic is a severe and potentially deadly syndrome, you should get a veterinarian involved to asses the gravity of the situation and initiate diagnostics so a treatment plan can be established.")
  irc_send("PRIVMSG #rubymonstas :Here is the number of the equine clinic of the Tierspital Zurich: 044 635 81 15.")
  irc_send("PRIVMSG #rubymonstas :If you're interested in further information on the topic, here is a website containing info about the examination of the colic patient:")
  irc_send("PRIVMSG #rubymonstas :https://www.tierspital.uzh.ch/pferde/magen-darm/kolikuntersuchung/")
  irc_send("PRIVMSG #rubymonstas :Once you have called your veterinarian: would you like to learn more about the possible treatments for colic while your waiting for him to arrive? Answer therapy for more information or start to begin anew")
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
  irc_send("PRIVMSG #rubymonstas :If you want to return to the start, enter start")
  
end

def handle_message_lameness(message)
  if @repetition_lameness == 0
    irc_send("PRIVMSG #rubymonstas :You entered lameness. ")
    irc_send("PRIVMSG #rubymonstas :This is the definition of lameness by the american college of equine surgeons: ")
    irc_send("PRIVMSG #rubymonstas :Lameness refers to an abnormality of a horse’s gait or stance. It can be caused by pain, a mechanical problem, or a neurological condition. 'Lameness, most commonly results from pain in the musculoskeletal system (muscles, tendons, ligaments, bones, or joints) leading to abnormal movement at the walk, trot, or canter.' ")
    irc_send("PRIVMSG #rubymonstas :Would you like to start the lameness diagnostic program or would you prefer to just be given some further information to read up on lameness?")
    @state = Diagnostic_state.new(0)
  end
  @chosen_problem = :lameness
end

def lameness_information_quiz(message)
  irc_send("PRIVMSG #rubymonstas :There are three different causes for lameness:")
  irc_send("PRIVMSG #rubymonstas :Pain: due to pain, the horse can alter the load on the injured leg and this can cause irregularity in the gait.")
  irc_send("PRIVMSG #rubymonstas :Mechanical lameness: This is not caused by pain but rather by mechanical issues. Examples for this are patellar fixation or abnormal gait due to scar tissue. ")
  irc_send("PRIVMSG #rubymonstas :Neurological lameness: Nerval damage hinders the horse from moving in a normal way.")
  irc_send("PRIVMSG #rubymonstas :What do you think, which cause is the most common?")
end
def lameness_pain(message)
  irc_send("PRIVMSG #rubymonstas :You are correct, pain is the most common cause of lameness. ")
  irc_send("PRIVMSG #rubymonstas :The severity of the symptoms in lameness can vary: in severe cases, horses often refrain from bearing any weight on the affected limbs, while in light cases, sometimes a slight head bobbing in trot can be the only visible sign.")
  
  
end

def lameness_wrong_answer(message)
  irc_send("PRIVMSG #rubymonstas :You are incorrect, this is not the most common cause of lameness.")
  irc_send("PRIVMSG #rubymonstas :You should give it another try!")
  lameness_information_quiz(message)
end

def program_lameness_diagnostic(message)
  if @state.corrector == 1
    irc_send("PRIVMSG #rubymonstas :Please re-enter the following general informations about your horse: Name, Type, Age, Usage (Sport/Leisure)")
    @state.corrector = 2
  else
    irc_send("PRIVMSG #rubymonstas :Welcome to the lameness diagnostic program.")
    irc_send("PRIVMSG #rubymonstas :The first step towards any diagnostic in veterinary medicine is taking a thorough anamnesis.")
    irc_send("PRIVMSG #rubymonstas :Please enter the following general informations about your horse: Name, Type, Age, Usage (Sport/Leisure)")
  end
end

def program_ld_history(message)
  delimiter ="#rubymonstas :"
  split_string = message.split(delimiter, 2)
  if @state.corrector != 1 
    @patient = Horse.new(split_string[1])
  #@patient.signalement(split_string[1])
    irc_send("PRIVMSG #rubymonstas :You entered:")
    irc_send("PRIVMSG #rubymonstas :#{@patient.signalement}")
    irc_send("PRIVMSG #rubymonstas :(if this information is incorrect, type back to correct it.)") 
    @state.corrector = 0
  elsif @state.corrector ==1
    irc_send("PRIVMSG #rubymonstas :Please re-enter the following information: medical history, previous lameness issues, and any recent changes in management, exercise routine, or diet")
    @state.corrector = 2
  end
  if @state.corrector == 0
    irc_send("PRIVMSG #rubymonstas :Now it is time for some specific information on the lameness of your horse. Let's get started on your horse's history.")
    irc_send("PRIVMSG #rubymonstas :Please enter the following information: medical history, previous lameness issues, and any recent changes in management, exercise routine, or diet")
  end
end

def program_ld_duration(message)
  delimiter ="#rubymonstas :"
  split_string = message.split(delimiter, 2)
  if @state.corrector != 1
    @patient.history= split_string[1]
    irc_send("PRIVMSG #rubymonstas :You entered:")
    irc_send("PRIVMSG #rubymonstas :#{@patient.history}")
    irc_send("PRIVMSG #rubymonstas :(if this information is incorrect, type back to correct it.)") 
    @state.corrector = 0 
  elsif @state.corrector ==1
    irc_send("PRIVMSG #rubymonstas :Please re-enter information on the onset and duration of the current lameness. When did the current bout of lameness start and did it start gradually or suddenly?")
    @state.corrector = 2
  end
  if @state.corrector == 0
    irc_send("PRIVMSG #rubymonstas :Let's continue with some information on the onset and duration of the current lameness.")
    irc_send("PRIVMSG #rubymonstas :When did the current bout of lameness start and did it start gradually or suddenly?")
  end
end

def program_ld_severity(message)
  delimiter ="#rubymonstas :"
  split_string = message.split(delimiter, 2)
  if @state.corrector != 1
    @patient.duration= split_string[1]
    irc_send("PRIVMSG #rubymonstas :You entered:")
    irc_send("PRIVMSG #rubymonstas :#{@patient.duration}")
    irc_send("PRIVMSG #rubymonstas :(if this information is incorrect, type back to correct it.)") 
    @state.corrector = 0 
  elsif @state.corrector ==1
    irc_send("PRIVMSG #rubymonstas :Please re-enter the severity of lameness, its progress over time, as well as possible activities or circumstances that exacerbate or alleviate the lameness.")
    @state.corrector = 2
  end
  if @state.corrector == 0
    irc_send("PRIVMSG #rubymonstas :I'd like to know some information on the severity of the current lameness.")
    irc_send("PRIVMSG #rubymonstas :Can you rate the severity of lameness? How did it progress over time? Are there any activities or circumstances that exacerbate or alleviate the lameness?")
  end
end
def program_ld_location(message)
  delimiter ="#rubymonstas :"
  split_string = message.split(delimiter, 2)
  if @state.corrector != 1
    @patient.severity = split_string[1]
    irc_send("PRIVMSG #rubymonstas :You entered:")
    irc_send("PRIVMSG #rubymonstas :#{@patient.severity}")
    irc_send("PRIVMSG #rubymonstas :(if this information is incorrect, type back to correct it.)") 
    @state.corrector = 0 
  elsif @state.corrector ==1
    irc_send("PRIVMSG #rubymonstas :Please re-enter the suspected location of the current lameness. Can you identify which leg the horse is lame on? To do this, you can walk or trot your horse up. Do you notice abnormal limb placement, irregular gait or even reduced load of a limb while standing?")
    @state.corrector = 2
  end
  if @state.corrector == 0
    irc_send("PRIVMSG #rubymonstas :Let's continue with some details on the location of the current lameness. Can you identify which leg the horse is lame on? To do this, you can walk or trot your horse up. Do you notice abnormal limb placement, irregular gait or even reduced load of a limb while standing?")
  end
end
def program_ld_routine(message)
  delimiter ="#rubymonstas :"
  split_string = message.split(delimiter, 2)
  if @state.corrector != 1
    @patient.location = split_string[1]
    irc_send("PRIVMSG #rubymonstas :You entered:")
    irc_send("PRIVMSG #rubymonstas :#{@patient.location}")
    irc_send("PRIVMSG #rubymonstas :(if this information is incorrect, type back to correct it.)") 
    @state.corrector = 0 
  elsif @state.corrector ==1
    irc_send("PRIVMSG #rubymonstas :Please provide your horse's correct exercise routine, elaborating on the following information: type, duration, and frequency of exercise, as well as the amount of rest provided?")
    @state.corrector = 2
  end
  if @state.corrector == 0
    irc_send("PRIVMSG #rubymonstas :What about your horse's exercise routine? Elaborate on the following information: type, duration, and frequency of exercise, as well as the amount of rest provided?")
  end
end
def program_ld_environment(message)
  delimiter ="#rubymonstas :"
  split_string = message.split(delimiter, 2)
  if @state.corrector != 1
    @patient.routine = split_string[1]
    irc_send("PRIVMSG #rubymonstas :You entered:")
    irc_send("PRIVMSG #rubymonstas :#{@patient.routine}")
    irc_send("PRIVMSG #rubymonstas :(if this information is incorrect, type back to correct it.)") 
    @state.corrector = 0 
  elsif @state.corrector ==1
    irc_send("PRIVMSG #rubymonstas :Please provide us with correct information on the footing your horse is regularly excised on. Were there any changes?")
    @state.corrector = 2
  end
  if @state.corrector == 0
    irc_send("PRIVMSG #rubymonstas :The type of footing your horse is regularly exercised on can be very important factors in lameness development. On what ground is your horse typically being ridden on? Were there any recent changes in the environment?")
  end
end
def program_ld_hoofcare(message)
  delimiter ="#rubymonstas :"
  split_string = message.split(delimiter, 2)
  if @state.corrector != 1
    @patient.environment = split_string[1]
    irc_send("PRIVMSG #rubymonstas :You entered:")
    irc_send("PRIVMSG #rubymonstas :#{@patient.environment}")
    irc_send("PRIVMSG #rubymonstas :(if this information is incorrect, type back to correct it.)") 
    @state.corrector = 0 
  elsif @state.corrector ==1
    irc_send("PRIVMSG #rubymonstas :Please enter your horse's hoof care routine. Are they shoed or barefoot, how often does the farrier come to trim the hooves or replace the shoeing and were there any recent changes in hoof care?") 
    @state.corrector = 2
  end
  if @state.corrector == 0
    irc_send("PRIVMSG #rubymonstas :What is your horse's hoof care routine? Are they shoed or barefoot? How often does the farrier come to trim the hooves or replace the shoeing? Were there any recent changes in hoof care?")
  end
end
def program_ld_recentinjuries(message)
  delimiter ="#rubymonstas :"
  split_string = message.split(delimiter, 2)
  if @state.corrector != 1
    @patient.hoofcare = split_string[1]
    irc_send("PRIVMSG #rubymonstas :You entered:")
    irc_send("PRIVMSG #rubymonstas :#{@patient.hoofcare}")
    irc_send("PRIVMSG #rubymonstas :(if this information is incorrect, type back to correct it.)") 
    @state.corrector = 0 
  elsif @state.corrector ==1
    irc_send("PRIVMSG #rubymonstas :Did your horse experience any recent injuries, falls, or other traumatic events that may be related to the lameness?")
    @state.corrector = 2
  end
  if @state.corrector == 0
    irc_send("PRIVMSG #rubymonstas :Did your horse experience any recent injuries, falls, or other traumatic events that may be related to the lameness?")
  end
end
def program_ld_previoustherapy(message)
  delimiter ="#rubymonstas :"
  split_string = message.split(delimiter, 2)
  if @state.corrector != 1
    @patient.recentinjuries = split_string[1]
    irc_send("PRIVMSG #rubymonstas :You entered:")
    irc_send("PRIVMSG #rubymonstas :#{@patient.recentinjuries}")
    irc_send("PRIVMSG #rubymonstas :(if this information is incorrect, type back to correct it.)") 
    @state.corrector = 0 
  elsif @state.corrector ==1
    irc_send("PRIVMSG #rubymonstas :Did your horse receive any previous treatments, medications, or therapies for the lameness? If so, how did your horse react to them?")
    @state.corrector = 2
  end
  if @state.corrector == 0
    irc_send("PRIVMSG #rubymonstas :Did your horse receive any previous treatments, medications, or therapies for the lameness? If so, how did your horse react to them?")
  end
end
def program_ld_othersigns(message)
  delimiter ="#rubymonstas :"
  split_string = message.split(delimiter, 2)
  if @state.corrector != 1
    @patient.previoustherapy = split_string[1]
    irc_send("PRIVMSG #rubymonstas :You entered:")
    irc_send("PRIVMSG #rubymonstas :#{@patient.previoustherapy}")
    irc_send("PRIVMSG #rubymonstas :(if this information is incorrect, type back to correct it.)") 
    @state.corrector = 0 
  elsif @state.corrector ==1
    irc_send("PRIVMSG #rubymonstas :Did you notice any additional signs or symptoms the horse has been exhibiting, such as swelling, heat, changes in behavior, or changes in appetite?")
    @state.corrector = 2
  end
  if @state.corrector == 0
    irc_send("PRIVMSG #rubymonstas :Did you notice any additional signs or symptoms the horse has been exhibiting, such as swelling, heat, changes in behavior, or changes in appetite?")
  end
end

def program_ld_finished(message)
  delimiter ="#rubymonstas :"
  split_string = message.split(delimiter, 2)
  if @state.corrector != 1
    @patient.othersigns = split_string[1]
    irc_send("PRIVMSG #rubymonstas :You entered:")
    irc_send("PRIVMSG #rubymonstas :#{@patient.othersigns}")
    irc_send("PRIVMSG #rubymonstas :If this information is incorrect, type back to correct it. If it's correct: are you ready for a summary of the information you entered?") 
    @state.corrector = 0 
  end
end
def program_ld_summary(message)
  sleep(1)
  irc_send("PRIVMSG #rubymonstas :Here is a summary of the information you entered:")
  irc_send("PRIVMSG #rubymonstas :1: General information on your horse: #{@patient.signalement}")
  irc_send("PRIVMSG #rubymonstas :2: Your horse's medical history: #{@patient.history}")
  sleep(1)
  irc_send("PRIVMSG #rubymonstas :3: The duration of the lameness: #{@patient.duration}")
  irc_send("PRIVMSG #rubymonstas :4: The severity of the lameness: #{@patient.severity}")
  irc_send("PRIVMSG #rubymonstas :5: The location of the lameness: #{@patient.location}")
  sleep(1)
  irc_send("PRIVMSG #rubymonstas :6: Your horse's exercise routine: #{@patient.routine}")
  irc_send("PRIVMSG #rubymonstas :7: The environment your horse is ridden in: #{@patient.environment}")
  irc_send("PRIVMSG #rubymonstas :8: Your horse's hoofcare: #{@patient.hoofcare}")
  sleep(1)
  irc_send("PRIVMSG #rubymonstas :9: Recent injuries or trauma: #{@patient.recentinjuries}")
  irc_send("PRIVMSG #rubymonstas :10: Previous therapy administered: #{@patient.previoustherapy}")
  irc_send("PRIVMSG #rubymonstas :11: Other signs and symptoms: #{@patient.othersigns}")
  sleep(1)
  #irc_send("PRIVMSG #rubymonstas :If you'd like to correct one of your answers, enter the number of the incorrect information to correct it.") 
  irc_send("PRIVMSG #rubymonstas :The lameness diagnostic program is now finished. Type start to go back to the start of the EquineBotProgram.")
  @state.finished = true
end

##
def check_for_corrections(message)
  delimiter ="#rubymonstas :"
  split_string = message.split(delimiter, 2)
  @to_be_corrected = split_string[1]
  if @to_be_corrected.include?("1") && (message.include?("01") == false) && (message.include?("11")== false)
    @state.current_state = -1
  elsif @to_be_corrected.include?("2") 
    @state.current_state = 0
  elsif @to_be_corrected.include?("3") 
    @state.current_state = 1
  elsif @to_be_corrected.include?("4") 
    @state.current_state = 2
  elsif @to_be_corrected.include?("5") 
    @state.current_state = 3
  elsif @to_be_corrected.include?("6") 
    @state.current_state = 4
  elsif @to_be_corrected.include?("7") 
    @state.current_state = 5
  elsif @to_be_corrected.include?("8") 
    @state.current_state = 6
  elsif @to_be_corrected.include?("9") 
    @state.current_state = 7
  elsif @to_be_corrected.include?("10") 
    @state.current_state = 8
  elsif @to_be_corrected.include?("11") 
    @state.current_state = 9
  end 
  irc_send("PRIVMSG #rubymonstas :works") #to do: either enter something here or call on another method so it will happen straight after without any additional input or enter
  
  
  
  #next step: implementing that after entering corrections goes straight back to the end
end
# ###
# #irc_send("PRIVMSG #rubymonstas :")