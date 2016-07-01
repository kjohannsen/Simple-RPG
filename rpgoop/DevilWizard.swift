//
//  DevilWizard.swift
//  rpgoop
//
//  Created by Kyle Johannsen on 6/9/16.
//  Copyright © 2016 Kyle Johannsen. All rights reserved.
//

import Foundation

class DevilWizard: Enemy {
    override var loot: [String] {
        return ["Magic Wand","Dark Amulet","Salted Pork"]
    }
    
    override var type: String {
        return "Devil Wizard"
    }
}