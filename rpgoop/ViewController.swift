//
//  ViewController.swift
//  rpgoop
//
//  Created by Kyle Johannsen on 6/9/16.
//  Copyright © 2016 Kyle Johannsen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var printLbl: UILabel!
    
    @IBOutlet weak var playerHpLbl: UILabel!
    
    @IBOutlet weak var enemyHpLbl: UILabel!
    
    @IBOutlet weak var enemy1Img: UIImageView!
    
    @IBOutlet weak var enemy2Img: UIImageView!
    
    @IBOutlet weak var chestBtn: UIButton!
    
    @IBOutlet weak var attackBtn: UIButton!
    
    @IBOutlet weak var attackLbl: UILabel!
    
    
    var player: Player!
    var enemy: Enemy!
    var chestMessage: String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player = Player(name: "SirLancelot", hp: 120, attackPwr: 20)
        
        generateRandomEnemy()
        
        playerHpLbl.text = "\(player.hp) HP"
        
        
    }
    
    func generateRandomEnemy() {
    let rand = Int(arc4random_uniform(2))
        
        if rand == 0 {
            enemy = Kimara(startingHp: 50, attackPwr: 12)
            enemy1Img.hidden = false
            enemy2Img.hidden = true
        } else {
            enemy = DevilWizard(startingHp: 60, attackPwr: 15)
            enemy1Img.hidden = true
            enemy2Img.hidden = false
        }
        
        enemyHpLbl.text = "\(enemy.hp) HP"
        printLbl.text = "An enemy \(enemy.type) is attacking!"
        attackBtn.hidden = false
        attackLbl.hidden = false
        
        
    }

    
    
    
    @IBAction func onChestTapped(sender: AnyObject) {
        chestBtn.hidden = true
        printLbl.text = chestMessage
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(ViewController.generateRandomEnemy), userInfo: nil, repeats: false)
    }

    @IBAction func attackTapped(sender: AnyObject) {
        
        if enemy.attemptAttack(player.attackPower) {
            printLbl.text = "Attacked \(enemy.type) for \(player.attackPower) HP!"
            enemyHpLbl.text = "\(enemy.hp) HP"
        } else {
            printLbl.text = "Attack was unsuccessful!"
        }
        
        if let loot = enemy.dropLoot() {
            player.addItemToInventory(loot)
            chestMessage = "\(player.name) found \(loot)!"
            chestBtn.hidden = false
            attackBtn.hidden = true
            attackLbl.hidden = true
        }
        
        if !enemy.isAlive {
            enemyHpLbl.text = ""
            printLbl.text = "Killed \(enemy.type)!"
            enemy1Img.hidden = true
            enemy2Img.hidden = true
            
        }
        
    }
}

