class Game {
    
    var whoseTurn: Bool = true // whoseTurn is initialized at 0 so Team First will start choosing action either fighting or healing
    
    init(whoseTurn: Bool) {
        self.whoseTurn = whoseTurn
    }
    
    let teamFactory = TeamFactory()
    
    
    
    //=========================
    // MARK: - CONVERSATION   =
    //=========================
    
    func gameStartMenu() {
        var correctAnswer: Bool = true
        repeat {
            print("           **************************************************************************************"
                + "\n           *                              The Return Of The Wizard                              *"
                + "\n           **************************************************************************************"
                + "\n           *                                                                                    *"
                + "\n           *                                 WELCOME TO THE GAME                                *"
                + "\n           *                                                                                    *"
                + "\n           **************************************************************************************"
                + "\n"
                + "\n Would you like to start playing ? "
                + "\n Yes(y) / No(n)"
                + "\n 👉 Your choice:❓")
            
            if let choicePlayer = readLine() {
                
                correctAnswer = game.controAnswerLetters(choicePlayer: choicePlayer)
                
                switch choicePlayer {
                case "y": // If the users answer is Yes(y) then he can start creating the first Team
                    
                    print("\n"
                        + "\n           **********************************"
                        + "\n           *      Lets start the game       *"
                        + "\n           **********************************")
                    
                    createTeamMenu()
                    
                case "n": // If the users answer is No(N) then we get back to the start Menu
                    
                    print("\n"
                        + "\n           **************************"
                        + "\n           *    Maybe next time     *"
                        + "\n           **************************")
                    
                    game.gameStartMenu()
                    
                default: // as far the answer is not correct either Yes(Y) or No(n) the start menu will be on screen
                    
                    print(" 🤔 I don't understand")
                }
            }
        }while correctAnswer == false
    }
    
    func createTeamMenu() { /* the game will create with the two teams with that method
                               We get the answer of the player // testing if the answer is acceptable */
        
        //playerTurn = "First" // property for the roll of the game
        
        var teamAlias = 0 // teamAlias will block the team creation at 2, set at begin at 0
        var teamNameAlias = "First" /* teamNameAlias is having two states -> First for the first Team
                                                                          -> Second for the Second Team*/
        print("\n             ▶️ Description of the game ◀️"
           + "\n\n"
           + "\n ⚠️ At the beginning of the game, each player will build his team by choosing from these types of possible characters."
           + "\n Fighter: The classic attacker."
           + "\n Wizard: The Savior."
           + "\n Colossus: Imposing and very resistant."
           + "\n Dwarf: His axe is powerful."
           + "\n"
           + "\n ⚠️ Each team must have 3 characters (no matter the type)."
           + "\n"
           + "\n Then the game will start. Each player will be able to fight against another chosen opponent, or he can heal someone of his team."
           + "\n ⚠️ To heal, you must have at least one wizard in your team."
           + "\n"
           + "\n\n Fight well, but always with honor."
           + "\n\n           ***************************** ")
        
        repeat{ // will create two teams
            var playerAnswer: String? // that is the player answer
            var numberOfHeroes : Int = 1
            let maxHeroes = 4
            
            repeat { // loop allowing to create the two teams
                print("\n"
                    + "\n 👉 \(teamNameAlias) Team"
                    + "\n"
                    + "\n You have to choose three heroes.")
                
                repeat {
                    
                    game.heroesChoice() // printing the possible choice of heroes
                  
                    playerAnswer = game.choicePlayer(maxValue: 4) // checking if the answer is in betwwen 1 and 4
                    
                } while playerAnswer == nil
                
                var heroName: String  // that will be the name of the hero chose by the Player
                
                repeat {
                    
                    print(" 👉 How do you want to name your heroe?") // Asking the name of the Team
                    heroName = teamFactory.getHeroeName()
                    
                    
                } while heroName.isEmpty // check if no input of name which is forbidden
                
                teamFactory.composeTeam(heroeName: heroName, heroesInt: playerAnswer! ,teamNameAlias: teamNameAlias) // adding the Heroes
                print("\n"
                    + "\n 👋 hero n°\(numberOfHeroes) is created") // printing how many heroes are created
                
                numberOfHeroes += 1 // accounting one hero added
                
                
            } while numberOfHeroes < maxHeroes // check that there are only 3 heroes by team

            game.statusTeam(whoseTurn: true,wizard: false) // shows the status of Team two (all the heroes and not only the wizard)
            teamAlias += 1
            teamNameAlias = "Second"
            whoseTurn.toggle() // give the hand to player Two
            
            
        } while teamAlias != 2 // teamAlias is checked if the teams are already created
        
        //print("\nThank You, the Second team is created")
        game.statusTeam(whoseTurn: false,wizard: false) // shows the status of team Two (all the heroes and not only the wizard)
        whoseTurn.toggle() // give the hand to player One
        
        game.actionMenu(whoseTurn: true) //
    }
    
    
    
    func actionMenu(whoseTurn: Bool) {  // give access to the main menu and will dispatch either actionFirstTeamMenu or actionSecondTeamMenu
        // based on whoseTurn(boolean true Team First/ false team Second)
        self.whoseTurn = whoseTurn
        
        print("           ***************************"
            + "\n           ⚡️  THE GAME: ACTION MENU *"
            + "\n           ***************************")
        
        if whoseTurn == true { // if that is the roll of team First, then will go on actionFirstTeamMenu
            
            actionTeamMenu(whoseTurn: true)
                    }
        if whoseTurn == false { // if that is the roll of team Second, then will go on actionSecondTeamMenu
            
            actionTeamMenu(whoseTurn: false)
            
        }
        
    }
    //==============================
    // MARK: - CONVERSATION  TEAM  =
    //==============================
    
    func actionTeamMenu(whoseTurn: Bool) {  // managing either fight or heal action for the First Team
        var playerAnswer: String? // that is the player answer
        var choiceGiven: Int = 0
        //var correctAnswer: Bool = true
        
        if whoseTurn == true {
            
            game.statusTeam(whoseTurn: true, wizard: false) // will shows status of team One (all the heroes and not only the wizard)
            //game.statusTeam(whoseTurn: false,wizard: false) // will shows status of team Two (all the heroes and not only the wizard)
            
            repeat {
                print("\n"
                    + "\n What Would you like to do:"   // the game should propose First team to play with an action to do
                    + "\n 1. Would you like to fight?"
                    + "\n 2. Would You like to heal someone?"
                    + "\n"
                    + "\n 👉 Your choice:❓")
                
                //if let choicePlayer = Int(readLine()!) { // control correct answer, here either 1 or 2 no letters accepted
                    playerAnswer = (game.choicePlayer(maxValue: 2)) // control if answer is correct 1 or 2 and no letters
                    //choiceGiven = choicePlayer
                //}
            }while playerAnswer == nil // not correct answer
            choiceGiven = Int(playerAnswer!)!
            if choiceGiven == 1 { // will show the Fight menu for First Team
                fightTeamMenu(whoseTurn: true)
            }
            if choiceGiven == 2 { // will show the Heal menu for first Team
                healTeamMenu(whoseTurn: true)
            }
        }
        if whoseTurn == false {
            
            game.statusTeam(whoseTurn: false, wizard: false) // will shows status of team Two (all the heroes and not only the wizard)
            //game.statusTeam(whoseTurn: true, wizard: false) // will shows status of team One (all the heroes and not only the wizard)
            
            repeat {
                print("\n"
                    + "\n What Would you like to do:"   // the game should propose Second team to play with an action to do
                    + "\n 1. Would you like to fight?"
                    + "\n 2. Would You like to heal someone?"
                    + "\n"
                    + "\n 👉 Your choice:❓")
                
                //if let choicePlayer = Int(readLine()!) { // control correct answer, here either 1 or 2 no letters accepted
                    playerAnswer = (game.choicePlayer(maxValue: 2)) // control if answer is correct 1 or 2 and no letters
                    choiceGiven = Int(playerAnswer!)!
              // }
            }while playerAnswer == nil // not correct answer
            
            if choiceGiven == 1 { // will show the Fight menu for Second Team
                fightTeamMenu(whoseTurn: false)
                
            }
            if choiceGiven == 2 { // will show the Heal menu for Second Team
                healTeamMenu(whoseTurn: false)
            }
        }
    }
    
    
    func fightTeamMenu(whoseTurn: Bool) {  /* menu for fight action for the Teams
                                            this menu will give him the choice of which hero he ll like to use and the opportunity to choose which hero of the opposite
                                            team, he ll like to attack.that menu will give him also before taking a decision the status of his team and the status of the
                                            opposite team */
        
        var playerAnswer: String? // the answer of the user
        var dispenserRow: Int = 0 // this is the dispenser heros row
        var recipientRow: Int = 0 // this is the recipient heros row
        var maxValueDispenser: Int = 0 // Value max for showing the heroes of dispenser team
        var maxValueRecipient: Int = 0 // Value max for showing the heroes of recipient team
       
        if whoseTurn == true {
            maxValueDispenser = game.statusTeam(whoseTurn: true, wizard: false) // so will start our possible choice by 1 for the dispensers possibility
                                                                                // (all the heroes and not only the wizard)
            
            maxValueRecipient = game.statusTeam(whoseTurn: false, wizard: false) // so will start our possible choice by 1 for the recipients possibility
                                                                                // (all the heroes and not only the wizard)
            
            
            print(" ▶️ TEAM ONE ◀️"
                + "\n 👉 Choose you hero: ❓")
            repeat {
                playerAnswer = ((game.choicePlayer(maxValue: maxValueDispenser)))
                dispenserRow = (Int(playerAnswer!)! - 1) // correcting the index for the array // index starts at 0
                print("dispenser row = \(dispenserRow)")
            }while playerAnswer == nil
            
            print(" ▶️ TEAM ONE ◀️"
                + "\n 👉 Choose your opponent: ❓")
            
            repeat {
                playerAnswer = (game.choicePlayer(maxValue: maxValueRecipient))
                recipientRow = (Int(playerAnswer!)! - 1) // correcting the index for the array // index starts at 0
                print("recipient row = \(recipientRow)")
            }while playerAnswer == nil
            
            teamFactory.teamAttacking(dispenser: dispenserRow, recipient: recipientRow, whoseTurn: whoseTurn)
            game.actionTeamMenu(whoseTurn: false)
        }
        
        if whoseTurn == false {
            maxValueDispenser = game.statusTeam(whoseTurn: false, wizard: false) // so will start our possible choice by 1 for the dispensers possibility
                                                                                 // (all the heroes and not only the wizard)
           
            maxValueRecipient = game.statusTeam(whoseTurn: true, wizard: false) // so will start our possible choice by 1 for the recipients possibility
                                                                                // (all the heroes and not only the wizard)
            
        }
        print(" ▶️ TEAM TWO ◀️"
            + "\n 👉 choose you hero: ❓")
        repeat {
            playerAnswer = ((game.choicePlayer(maxValue: maxValueDispenser))) // checks answer rightness
            dispenserRow = (Int(playerAnswer!)! - 1) // correcting the index for the array // index starts at 0
        }while playerAnswer == nil
        
        print(" ▶️ TEAM TWO ◀️"
            + "\n 👉 Choose your opponent: ❓")
        repeat {
            playerAnswer = (game.choicePlayer(maxValue: maxValueRecipient)) // checks answer rightness
            recipientRow = (Int(playerAnswer!)! - 1) // correcting the index for the array // index starts at 0
        }while playerAnswer == nil
        
        teamFactory.teamAttacking(dispenser: dispenserRow, recipient: recipientRow, whoseTurn: whoseTurn)
        game.actionMenu(whoseTurn: true)
    }


    func healTeamMenu(whoseTurn: Bool) {  /* menu for heal action for the First Team
         if the owner of team First is having one or multiple wizzards in his team. This menu will give him the choice of which wizard he ll
         like to use and the opportunity to choose which hero, he ll like to heal.*/
        
        var playerAnswer: String? // the answer of the user
        var dispenserRow: Int = 0 // this is the dispenser heros row
        var recipientRow: Int = 0 // this is the recipient heros row
        var maxValueDispenser: Int = 0 // Value max for showing the wizard of dispenser team
        var maxValueRecipient: Int = 0 // Value max for showing all the heroes of dispenser team
        
        if whoseTurn == true {
            
            maxValueDispenser = game.statusTeam(whoseTurn: true,wizard: true) // so will start our possible choice by 1 for the dispensers(wizard Type only) possibility
            maxValueRecipient = game.statusTeam(whoseTurn: true, wizard: false) // so will start our possible choice by 1 for the dispensers(all heroes) possibility
            if maxValueDispenser == 0 {
                print("\n"                                               // print communications for team One -> no wizard
                    + "\n ⚠️ You don't have any wizard in you team")
                game.actionMenu(whoseTurn: true)
            }
            else {
                //maxValueRecipient = game.statusTeam(whoseTurn: true) // so will start our possible choice by 1 for the recipients possibility
                
                print(" 👉 First Team"
                    + "\n choose you wizard: ❓")
                repeat {
                    playerAnswer = ((game.choicePlayer(maxValue: maxValueDispenser)))    // checks answer rightness
                    dispenserRow = (Int(playerAnswer!)!-1) // correcting the index for the array // index starts at 0
                }while playerAnswer == nil
                maxValueRecipient = game.statusTeam(whoseTurn: true, wizard: false)// so will start our possible choice by 1 for the dispensers(all heroes as i decide they can heal theme self) possibility
                
                print(" 👉 First Team" // print communications for team One
                    + "\n Choose the hero to heal: ❓")
                
                repeat {
                    playerAnswer = (game.choicePlayer(maxValue: maxValueRecipient)) // checks answer rightness
                    recipientRow = (Int(playerAnswer!)!-1) // correcting the index for the array // index starts at 0
                }while playerAnswer == nil
                
                teamFactory.teamHealing(dispenser: dispenserRow, recipient: recipientRow, whoseTurn: true)
                game.actionMenu(whoseTurn: false)
            }
        }
        
        if whoseTurn == false {
            
            maxValueDispenser = (game.statusTeam(whoseTurn: false, wizard: true)) // so will start our possible choice by 1 for the dispensers(wizard Type only) possibility
            maxValueRecipient = game.statusTeam(whoseTurn: false, wizard: false) // so will start our possible choice by 1 for the dispensers(all heroes) possibility
            print(maxValueDispenser)
            if maxValueDispenser == 0 {
                print("\n"                                              // print communications for team Two -> no wizard
                    + "\n ⚠️ You don't have any wizard in you team")
                game.actionMenu(whoseTurn: false)
            }
               
            else {
                
                print(" 👉 Second Team"
                    + "\n choose you wizard: ❓")
                repeat {
                    playerAnswer = ((game.choicePlayer(maxValue: maxValueDispenser)))
                    dispenserRow = (Int(playerAnswer!)! - 1) // correcting the index for the array // index starts at 0
                }while playerAnswer == nil
                //game.statusTeam(whoseTurn: false, wizard: false)
                maxValueRecipient = game.statusTeam(whoseTurn: false, wizard: false) // so will start our possible choice by 1 for the dispensers(all heroes as i decide they can heal theme self) possibility
                print(" 👉 Second Team"
                    + "\n Choose the hero to heal: ❓")
                repeat {
                    playerAnswer = (game.choicePlayer(maxValue: maxValueDispenser))
                    recipientRow = (Int(playerAnswer!)! - 1) // correcting the index for the array // index starts at 0
                }while playerAnswer == nil
                
                teamFactory.teamHealing(dispenser: dispenserRow, recipient: recipientRow, whoseTurn: false)
                game.actionMenu(whoseTurn: true)
            }
        }
        
    }
    
    func statusTeam(whoseTurn: Bool,wizard: Bool) -> Int {
        var elementHeroe: Int = 0 // number of heroes in the array for each teams
        var wizardExist: Bool = wizard
        var array = [Heroes]()
        var emojy: String = ""
        if wizard == true {
            wizardExist = true
            
        }
        if wizard == false {
            wizardExist = false
            
        }
        if whoseTurn == true { // if team one has to play then we are accessing to the arrayFirstTeam
            print(""
                + "\n ▶️ TEAM ONE HEROES ◀️") // showing the correct communication sentences for team one
            array = teamFactory.statusFactoryTeam(whoseTurn: true)
            emojy = "🤺" // setting the emojy for team One
        }
        if whoseTurn == false { // if team one has to play then we are accessing to the arraySecondTeam
            print(""
                + "\n ▶️ TEAM TWO HEROES ◀️") // showing the correct communication sentences for team one
            array = teamFactory.statusFactoryTeam(whoseTurn: false)
            emojy = "🔱" // setting the emojy for team Two
        }
        
        for element in 0..<array.count {
            
            if wizardExist == true {
                
                if array[element].type == "Wizard" {
                    if array[element].alive == true { // print the alived heroes only
                        
                        print("\n\(emojy) Hero name : \(array[element].heroName)"
                            + " \(emojy) Hero Type : \(array[element].type)"
                            + "\n\(emojy) LifeStrenght : \(array[element].lifeStrength)"
                            + " \(emojy) ShotStrenght : \(array[element].shotStrength)"
                            + "\n\(emojy) ArmorStrength : \(array[element].armorStrength)"
                            + " \(emojy) Equipement : \(array[element].equipment)")
                        elementHeroe += 1
                    }
                    
                }
            }
            if wizardExist == false {
                
                    if array[element].alive == true { // print the alived heroes only
                        
                        print("\n\(emojy) Hero name : \(array[element].heroName)"
                            + " \(emojy) Hero Type : \(array[element].type)"
                            + "\n\(emojy) LifeStrenght : \(array[element].lifeStrength)"
                            + " \(emojy) ShotStrenght : \(array[element].shotStrength)"
                            + "\n\(emojy) ArmorStrength : \(array[element].armorStrength)"
                            + " \(emojy) Equipement : \(array[element].equipment)")
                        elementHeroe += 1
                    }
                }
        }
        return elementHeroe
    }
    func statusTeamWizard(whoseTurn: Bool) -> Int {
        
        var elementHeroe: Int = 0 // number of heroes in the array for each teams
        
        if whoseTurn == true {
           
            if teamFactory.getDispensersTeamWithoutWizardSelected(whoseTurn: true) == true {
                elementHeroe = game.statusTeamWizard(whoseTurn: true)
            }
            if teamFactory.getDispensersTeamWithoutWizardSelected(whoseTurn: true) == false {
                print(" 😢 You don't have any wizard in your team")
                game.actionMenu(whoseTurn: true) // return to the action Menu because no wizard
            }
        }
        
        if whoseTurn == false {
            if teamFactory.getDispensersTeamWithoutWizardSelected(whoseTurn: false) == true {
                elementHeroe = game.statusTeamWizard(whoseTurn: false)
            }
            if teamFactory.getDispensersTeamWithoutWizardSelected(whoseTurn: false) == false {
                print(" 😢 You don't have any wizard in your team")
                game.actionMenu(whoseTurn: false) // return to the action Menu because no wizard
            }
        }
        return elementHeroe
    }
//========================
//  MARK:  - PARAMETERS  =
//========================

func controAnswerLetters(choicePlayer: String) -> Bool { // verify that the player type the possible answer // here Two
    var correctTwo = true
    let choiceGiven = choicePlayer
    
    if choiceGiven != "y" && choiceGiven != "n" {
        correctTwo = false
    }
    return correctTwo
}

func choicePlayer(maxValue: Int) -> String? {
    
    let choicePlayer = readLine()!
    
    guard (choicePlayer.isInt) else {  // test if the answer is only Int no letters
        print("I don`t understand your answer")
        return nil
        
    }
    
    let control = controlAnswer(choicePlayer: Int(choicePlayer)!, maxValue: maxValue)
    if control { // if the answer is in between the gap of possible answers
        //print("all is perfect")
        return choicePlayer}
    else {
        print("I don`t understand your answer")
        return nil
    }
}

func controlAnswer(choicePlayer: Int,maxValue: Int) -> Bool {
    for num in 1...maxValue {
        if choicePlayer == num { // Answer must be contained between 1 and max for 2 possible answers then 1 or 2
            //print("Your value is in between the possible answers")
            return true
        }
        //return false
    }
    return false
}
  

    func heroesChoice() {
        
        print("\n Which hero would you like to choose?")
        print("\n 1. Fighter"
            + "\n 2. Wizard"
            + "\n 3. Colossus"
            + "\n 4. Dwarf"
            + "\n"
            + "\n 👉 Your choice: ❓")
    }

}
