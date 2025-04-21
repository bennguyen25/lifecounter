//
//  LifeCounterViewController.swift
//  lifecounter
//
//  Created by Ben Nguyen on 4/21/25.
//

import UIKit

class LifeCounterViewController: UIViewController {
    @IBOutlet weak var lifeLabel1: UILabel!
    @IBOutlet weak var lifeLabel2: UILabel!
    @IBOutlet weak var losesLabel: UILabel!


    private var life1 = 20
    private var life2 = 20

    @IBAction func p1Minus5(_ sender: UIButton) { update(&life1, by: -5, label: lifeLabel1) }
    @IBAction func p1Minus1(_ sender: UIButton) { update(&life1, by: -1, label: lifeLabel1) }
    @IBAction func p1Plus1 (_ sender: UIButton) { update(&life1, by:  1, label: lifeLabel1) }
    @IBAction func p1Plus5 (_ sender: UIButton) { update(&life1, by:  5, label: lifeLabel1) }

    @IBAction func p2Minus5(_ sender: UIButton) { update(&life2, by: -5, label: lifeLabel2) }
    @IBAction func p2Minus1(_ sender: UIButton) { update(&life2, by: -1, label: lifeLabel2) }
    @IBAction func p2Plus1 (_ sender: UIButton) { update(&life2, by:  1, label: lifeLabel2) }
    @IBAction func p2Plus5 (_ sender: UIButton) { update(&life2, by:  5, label: lifeLabel2) }

    private func update(_ life: inout Int, by delta: Int, label: UILabel) {
      life += delta
      label.text = "\(life)"
      
      if life <= 0 {
        let player = (label === lifeLabel1) ? "Player 1" : "Player 2"
        losesLabel.text = "\(player) LOSES!"
        losesLabel.isHidden = false
      }
    }

    private func showLoseAlert(for player: String) {
    let alert = UIAlertController(title: "\(player) LOSES!", message: nil, preferredStyle: .alert)
    alert.addAction(.init(title: "OK", style: .default))
    present(alert, animated: true)
    }
}

