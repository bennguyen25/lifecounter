//
//  LifeCounterViewController.swift
//  lifecounter
//
//  Created by Ben Nguyen on 4/21/25.
//

import UIKit

class LifeCounterViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var addPlayerButton: UIButton!

  var players = [Player]()
  var gameStarted = false
  var history = [String]()

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 80

    for i in 1...4 {
      players.append(Player(id: i))
    }
  }

  @IBAction func addPlayerTapped(_ sender: UIButton) {
    guard !gameStarted, players.count < 8 else { return }
    let newID = players.count + 1
    players.append(Player(id: newID))
    tableView.insertRows(
      at: [IndexPath(row: newID - 1, section: 0)],
      with: .automatic
    )
  }
}

extension LifeCounterViewController: UITableViewDataSource {
  func tableView(_ tv: UITableView, numberOfRowsInSection section: Int) -> Int {
    return players.count
  }

  func tableView(
    _ tv: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = tv.dequeueReusableCell(
      withIdentifier: "PlayerCell",
      for: indexPath
    ) as! PlayerCell
    cell.player = players[indexPath.row]
    cell.delegate = self
    return cell
  }
}

extension LifeCounterViewController: PlayerCellDelegate {
  func playerDidUpdate(_ cell: PlayerCell) {
    gameStarted = true
    addPlayerButton.isEnabled = false

    if let row = tableView.indexPath(for: cell)?.row {
      let p = players[row]
      history.append("Player \(p.id) is now at \(p.life) life.")
    }
  }
}
