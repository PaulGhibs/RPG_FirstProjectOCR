//
//  Dwarf.swift
//  
//
//  Created by Paul Ghibeaux on 14/05/2021.
//

import Foundation

// Dwarf 👹 character

internal class Dwarf: Character {
    override init(charName fighterName: String) {
        super.init(charName: fighterName)
      life = 40
        self.emoji = "👹"
       self.weapon = Knife()
    }
}
