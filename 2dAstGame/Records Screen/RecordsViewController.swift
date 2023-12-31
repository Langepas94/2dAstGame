//
//  RecordsViewController.swift
//  2dAstGame
//
//  Created by Артём Тюрморезов on 02.10.2023.
//

import UIKit

final class RecordsViewController: UIViewController {
    
    private var db = DataBase()
    private var records: [ScoreModel]?
    
    private var tableView: UITableView = {
        let table = UITableView()
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        return table
    }()
    
    private let backgroundImage: UIImageView = {
        let bg = UIImageView(image: UIImage(named: AppResources.UniqueConstants.ColorsImages.backgroundSecondImage))
        return bg
    }()
    
    // MARK: view lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        records = db.read(dataType: .records)
    }
    
    // MARK: - Flow
    func setupUI() {
        view.addSubview(tableView)
        tableView.backgroundView = backgroundImage
        tableView.register(RecordTableViewCell.self, forCellReuseIdentifier: RecordTableViewCell.reuseID)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = view.frame
    
    }

    func blurEffect() {
        let blurEffect = UIBlurEffect(style: .systemThinMaterialLight)
        let viewEffect = UIVisualEffectView(effect: blurEffect)
        viewEffect.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        viewEffect.frame = tableView.frame
        backgroundImage.addSubview(viewEffect)
    }
}

extension RecordsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        records?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecordTableViewCell.reuseID, for: indexPath) as? RecordTableViewCell else { return UITableViewCell() }
        guard let records = records else { return UITableViewCell() }
        let sorted = records.sorted(by: {$0.score > $1.score })
        cell.configure(sorted[indexPath.row])
      return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 100, width: tableView.frame.size.width, height: AppResources.Screens.RecordsScreen.ConstraintsAndSizes.Table.heightForHeader))
        let label = UILabel(frame: headerView.bounds)
        label.textAlignment = .center
        label.text = "Score"
        label.font = AppResources.UniqueConstants.Fonts.pixelUsernameFont
        label.textColor = .white
        headerView.addSubview(label)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        AppResources.Screens.RecordsScreen.ConstraintsAndSizes.Table.heightForHeader
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        AppResources.Screens.RecordsScreen.ConstraintsAndSizes.Table.heightRow
    }
}

