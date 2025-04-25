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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "ShowHistory",
         let histVC = segue.destination as? HistoryViewController {
          print("🔸 Passing history:", history)
        histVC.history = self.history
      }
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
  func playerDidUpdate(_ cell: PlayerCell, delta: Int) {
    gameStarted = true
    addPlayerButton.isEnabled = false

    guard let indexPath = tableView.indexPath(for: cell) else { return }
    let id = players[indexPath.row].id
    players[indexPath.row].life = cell.player.life

    let verb = delta > 0 ? "gained" : "lost"
    let amount = abs(delta)
    history.append("Player \(id) \(verb) \(amount) life.")
  }
}
