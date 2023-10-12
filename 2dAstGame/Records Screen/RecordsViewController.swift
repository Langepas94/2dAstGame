//
//  RecordsViewController.swift
//  2dAstGame
//
//  Created by Артём Тюрморезов on 02.10.2023.
//

import UIKit

class MockData {
    static let records = [RecordModel(name: "Ivan", score: 223),RecordModel(name: "Vasya", score: 13),RecordModel(name: "Misha", score: 65),RecordModel(name: "Kolya", score: 123), RecordModel(name: "Dazdraperma", score: 123),RecordModel(name: "SuperLongImyaMuhidinFurtaz", score: 123)]
}


class RecordsViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        

    }
    
    // MARK: - Flow
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MockData.records.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecordTableViewCell.reuseID, for: indexPath) as? RecordTableViewCell else { return UITableViewCell() }
        let sorted = MockData.records.sorted(by: {$0.score > $1.score})
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

