//
//  PlayerCell.swift
//  lifecounter
//
//  Created by Ben Nguyen on 4/25/25.
//

import UIKit

protocol PlayerCellDelegate: AnyObject {
    func playerDidUpdate(_ cell: PlayerCell, delta: Int)
}

class PlayerCell: UITableViewCell {
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var lifeLabel: UILabel!
  @IBOutlet weak var deltaField: UITextField!

  weak var delegate: PlayerCellDelegate?
  var player: Player! {
    didSet {
      nameLabel.text = "Player \(player.id)"
      lifeLabel.text = "\(player.life)"
    }
  }

    @IBAction func changeTapped(_ sender: UIButton) {
        let rawDelta = Int(deltaField.text ?? "") ?? 5
        let change = sender.tag * rawDelta

        player.life += change
        lifeLabel.text = "\(player.life)"
        deltaField.text = ""

        delegate?.playerDidUpdate(self, delta: change)
    }
    
    @IBAction func decrementOneTapped(_ sender: UIButton) {
      player.life -= 1
      lifeLabel.text = "\(player.life)"
      delegate?.playerDidUpdate(self, delta: -1)
    }

    @IBAction func incrementOneTapped(_ sender: UIButton) {
      player.life += 1
      lifeLabel.text = "\(player.life)"
      delegate?.playerDidUpdate(self, delta: 1)
    }
}
