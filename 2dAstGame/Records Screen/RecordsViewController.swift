//
//  RecordsViewController.swift
//  2dAstGame
//
//  Created by Артём Тюрморезов on 02.10.2023.
//

import UIKit

class RecordsViewController: UITableViewController {
    
    private var db = DataBase()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }
    
    // MARK: - Flow
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let records: [ScoreModel] = db.read(dataType: .records) {
            return records.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecordTableViewCell.reuseID, for: indexPath) as? RecordTableViewCell else { return UITableViewCell() }
        
        guard let records: [ScoreModel] = db.read(dataType: .records) else { return UITableViewCell() }
        let sorted = records.sorted(by: {$0.score > $1.score})
        cell.configure(sorted[indexPath.row])

      return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        headerView.backgroundColor = .lightGray
        
        let label = UILabel(frame: headerView.bounds)
        label.textAlignment = .center
        label.text = "Score"
        headerView.addSubview(label)
        
        return headerView
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}

extension RecordsViewController {
    func setupUI() {
        view.backgroundColor = AppColors.backgroundColor
        tableView.register(RecordTableViewCell.self, forCellReuseIdentifier: RecordTableViewCell.reuseID)
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
    }
}

