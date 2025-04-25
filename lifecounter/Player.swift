//
//  Player.swift
//  lifecounter
//
//  Created by Ben Nguyen on 4/25/25.
//

import Foundation

struct Player {
    let id: Int
    var life: Int

    init(id: Int, life: Int = 20) {
        self.id = id
        self.life = life
    }
}
