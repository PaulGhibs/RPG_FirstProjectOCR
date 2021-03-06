//
//  Fairy.swift
//  
//
//  Created by Paul Ghibeaux on 17/05/2021.
//

import Foundation

// Fairy 🧚‍♀️ character

internal class Fairy: Character {
    override init(charName fighterName: String) {
        super.init(charName: fighterName)
      life = 70
        self.emoji = "🧚‍♀️"
      self.weapon = IceJet()
    }
    override func cureOthers() -> Bool {
        _ = Fairy(charName: "")
        return true
    }
}
