//
//  RecordsViewController.swift
//  2dAstGame
//
//  Created by Артём Тюрморезов on 02.10.2023.
//

import UIKit

class RecordsViewController: UIViewController {
    
    private var db = DataBase()
    var records: [ScoreModel]?
    
    private var tableView: UITableView = {
        let table = UITableView()
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        records = db.read(dataType: .records)
        setupUI()
    }
    
    // MARK: - Flow
    
    func setupUI() {
        view.backgroundColor = AppResources.AppScreenUIColors.backgroundColor
        view.addSubview(tableView)
        tableView.register(RecordTableViewCell.self, forCellReuseIdentifier: RecordTableViewCell.reuseID)
        tableView.dataSource = self
        tableView.frame = view.frame
    }

}

extension RecordsViewController: UITableViewDelegate, UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        records?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecordTableViewCell.reuseID, for: indexPath) as? RecordTableViewCell else { return UITableViewCell() }
        
        guard let records = records else { return UITableViewCell() }
        
        let sorted = records.sorted(by: {$0.score > $1.score })
        cell.configure(sorted[indexPath.row])

      return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: AppResources.AppConstraints.Table.heightForHeader))
        headerView.backgroundColor = .lightGray
        
        
        let label = UILabel(frame: headerView.bounds)
        label.textAlignment = .center
        label.text = "Score"
        headerView.addSubview(label)
        
        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        AppResources.AppConstraints.Table.heightForHeader
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        AppResources.AppConstraints.Table.heightRow
    }
}

