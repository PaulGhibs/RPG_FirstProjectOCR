//
//  Game.swift
//  
//
//  Created by Paul Ghibeaux on 17/05/2021.
// swiftlint:disable all



import Foundation

class Game {
    // Tab Player 1ļøā£ & 2ļøā£ / Instances for stats
    let pOne = Player()
    let pTwo = Player()
    // damage
    var damageDone = 0
    // life
    var lifeTook = 0
    var lifeWins = 0
    var lifeGive = 0
    // Magic weapon
    var magicWeaponTrigger = 0
    // players turn
    var turnPlayers = 0
    // Dead characters
    var numberOfCharactersDead = 0
    
    static let characters = [Warrior(charName: "Warrior"), Sorcerer(charName: "Sorcerer "), Knight(charName: "Knight "), Dwarf(charName: "Dwarf"), Fairy(charName: "Fairy"), Evil(charName: "Evil")]
    
    // Welcoming
    func welcomePrint() {
        print("""
                    \nš Welcome On RPGCommand š² āļø š²
                    \nTo begin you will be prompt to select 3ļøā£ characters in the list by typing a number.
                    \nWhen you'll choose one we will ask you a name for the character.
                    \n\nāļø If you attend to use the same name for each it's not possible āļø
                    \nIf you choose a sorcerer š§āāļø  or Fairy š§āāļø you can heal others people of your team at some point
            
            """
            )
    }
    // Present Character to Player 1ļøā£
     func characterPresentation() {
      
        
        for (index, character) in Game.characters.enumerated() {
            print("\(index+1) \(character.name ) \(character.emoji) a life of \(character.life) and a the weapon \(character.weapon.name) \( character.weapon.emoji) \(character.weapon.hitGiven) and of hit damages")
        }
    }
    // Choose character player : 1ļøā£ & 2ļøā£
    func playerTeamsSetUp() {
        print("\n\n\n--- Player 1ļøā£, š You can go ---\n")
        // Player 1ļøā£ team
        let pOneFightersNameList = pOne.createTeam(listCharactersName: [""])
        print("\n\n\n--- Player 2ļøā£, š You can go ---\n")
        // Player 2ļøā£ team
        _ = pTwo.createTeam(listCharactersName: pOneFightersNameList)
        print("\n\n\n\n--- Player 1ļøā£ and Player 2ļøā£ teams are setšØāš¦āš¦ --- \n\n!!! šÆ You're going to fight now š¹āļø !!!\n\n")
    }
    // Random Weapon Magic
     func randomChest(for character: Character) {
        let randomChestOnGame = Int(arc4random_uniform(6))
        let specialWeaponList = [SpecialWeapon]()
        if randomChestOnGame == 3 {
        for _ in specialWeaponList {
                character.specialWeapon = SpecialWeapon(hitGiven: 0)
        }
            print("\n\n\n š š A special chest Appeared š š  \n\nYour weapon has now a \(character.weapon.hitGiven) attack points āļø")
          // Variable for game statistics
          magicWeaponTrigger += 1
        }
    }
    // Trigger the chest for magic weapon š¹
     func triggerRandomChest(_ character: Character) -> Bool {
        if character.specialWeapon != nil {
          return true
        }
        return false
    }
    // cure others ā¤ļø characters from the team šØāš¦āš¦
    func cureOthers(with character: Character, on teamMember: Character) {
        // Giving life points trigger
        character.giveLife(character: teamMember)
        print("\n\n2 \(teamMember.name) feels a bit better. \(teamMember.name) life points\(teamMember.life) is now remaining.")

        // Variables for game stats
        lifeGive += character.weapon.hitGiven
        lifeWins += 1

    }
    // Attack ennemy š¤ŗ
    func attack(with character: Character, on opp: Character) {
       // Attack on the ennemie trigger
       character.giveLife(character: opp)
       // Life points stick to zero after an attack instead of going negative
       if opp.life > 0 {
         print("\n \(opp.name) has been attacked.š¤ŗ \(opp.name) lifeā¤ļø \(opp.life) points is now remaining.")
       } else {
         opp.life = 0
         print("\n \(opp.name) has 0ļøā£ lifeš point remaining.")
       }
       // Variables for statistics
        lifeTook += character.weapon.hitGiven
       damageDone += 1

       if opp.life <= 0 {
         print("\n!!! \(opp.name.uppercased()) is in ā°ļø!!!")
         // Variable for game statistics
         numberOfCharactersDead += 1
       }
   }

    // turn to turn š
    func playersLoop(playerTurn: Player, opp: Player) {
        print("\n\n--- With what characters š¤ŗ you want to play ? ---\n")
        // Players see the characters chosen
        playerTurn.presentCharacter()
        // Switch to choose the character to attack  š¤ŗ or heal
        let character = playerTurn.changeCaracter()
        
        print("\n\nYou have chosen \(character.name) with a \(character.weapon.hitGiven)  attack points and this weapon  : \(character.weapon.emoji).")
        
        // When the lucky chest is thrown in game to randomly get a stronger weapon
        if triggerRandomChest(character) == false {
          randomChest(for: character)
        }
        // If the Sorcerer was pick, the player chooses one of his characters to give life points back to
        if character.cureOthers() {
          print("\n\n--- Which one of your characters you want to give life ā¤ļø points back to? ---")
          playerTurn.presentCharacter()
            cureOthers(with: character, on: playerTurn.changeCaracter())
        }
          // If not the sorcerer, the player chooses a character to š¤ŗ
        else {
          print("\n\n--- Which one of your ennemies you want to attack? š¹ ---")
          opp.presentCharacter()
            attack(with: character, on: opp.changeCaracter())
        }
    }
    // š turn loop until characters are dead šŖ¦
     func gameLoop() {
        var isPlayerOneTurn = true
        while pOne.checkAlives() && pTwo.checkAlives() {
          if isPlayerOneTurn {
            print("\n\n--- Player 1ļøā£ ,š Your turn ! ---")
            playersLoop(playerTurn: pOne, opp: pTwo)
          } else {
            print("\n\n--- Player 2ļøā£, š Your turn! ---")
            playersLoop(playerTurn: pTwo, opp: pOne)
          }
          isPlayerOneTurn = !isPlayerOneTurn
          turnPlayers += 1
        }
    }
     // func to congrats the winner š„
    fileprivate func endgame() {
      if pOne.checkAlives() {
        print("\n\n š Congratulations Player 1ļøā£ š„! You win š„š„š„! \n\n")
      } else {
        print("\n\n š Congratulations Player 2ļøā£ š„! You winš„š„š„! \n\n")
      }
    }

    // This is where the game statistics š are grouped to be displayed at the end
    fileprivate func printstats() {
      var player1TotalTurn = 0
      var player2TotalTurn = 0
      // Calculate the time each player has played a turn
      if pOne.checkAlives() {
        player1TotalTurn = turnPlayers / 2 + 1
      } else {
        player1TotalTurn = turnPlayers / 2
      }
      if pTwo.checkAlives() {
        player2TotalTurn = turnPlayers / 21
      } else {
        player2TotalTurn = turnPlayers / 2
      }

      print("""
        -- Stats š --
                - 1ļøā£ Turns:   \(player1TotalTurn)
                - 2ļøā£ Turns:   \(player2TotalTurn)
                - āļøAttacks :            \(damageDone)
                - ā¤ļø Life Given ā :      \(lifeGive)
                - š§āāļøSorcerers Heals points used:  \(lifeTook)
                - ā¤ļø Life Back:   \(lifeWins)
                - š£š§ØšŖMagic Weapon Triggers:   \(magicWeaponTrigger)
                - šŖ¦ deadsPeople:    \(numberOfCharactersDead)
        """)
    }

    // Game beginning š®
    func launch() {
        welcomePrint()
        playerTeamsSetUp()
        gameLoop()
        endgame()
        printstats()
        print("Game Over š®")
    }
}
