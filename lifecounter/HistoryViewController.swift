//
//  HistoryViewController.swift
//  lifecounter
//
//  Created by Ben Nguyen on 4/25/25.
//

import UIKit

class HistoryViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  var history = [String]()

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 44
  }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
      }
}

extension HistoryViewController: UITableViewDataSource {
  func tableView(_ tv: UITableView, numberOfRowsInSection section: Int) -> Int {
    return history.count
  }

  func tableView(_ tv: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tv.dequeueReusableCell(
      withIdentifier: "HistoryCell",
      for: indexPath
    )
    cell.textLabel?.text = history[indexPath.row]
    return cell
  }
}
