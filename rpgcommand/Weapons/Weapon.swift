//
//  Weapon.swift
//  
//
//  Created by Paul Ghibeaux on 14/05/2021.
//

import Foundation

// Weapon capabilities name and hit

internal class Weapon {

  var hitGiven: Int
  var name: String = ""
  var emoji = ""
  init(hitGiven: Int) {
    self.hitGiven = hitGiven
    self.emoji = ""
  }
}

internal class SpecialWeapon {

  var hitGiven: Int
  var name: String?

  init(hitGiven: Int) {
    self.hitGiven = hitGiven
    self.name = ""
  }
}
