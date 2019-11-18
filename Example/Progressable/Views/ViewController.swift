//
//  ViewController.swift
//  Progressable
//
//  Created by Matthew Pierce on 11/15/2019.
//  Copyright (c) 2019 Matthew Pierce. All rights reserved.
//

import UIKit
import Progressable

class ViewController: BaseTableViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private var data = [ControlConfig]()
    private var views = [UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        setupViews()
        setupTableView()
    }
    
    // MARK: - Private functions
    
    private func setupData() {
        let controlOne = ControlConfig(progress: Progress(totalUnitCount: 100),
                                       animate: true,
                                       showPercentage: true,
                                       clearOnComplete: true)
        let controlTwo = ControlConfig(progress: Progress(totalUnitCount: 100),
                                       animate: false,
                                       showPercentage: true,
                                       clearOnComplete: true)
        let controlThree = ControlConfig(progress: Progress(totalUnitCount: 100),
                                         animate: false,
                                         showPercentage: false,
                                         clearOnComplete: true)
        let controlFour = ControlConfig(progress: Progress(totalUnitCount: 100),
                                        animate: false,
                                        showPercentage: false,
                                        clearOnComplete: false)
        data = [controlOne, controlTwo, controlThree, controlFour]
    }
    
    private func setupViews() {
        let viewOne = UIView(frame: .zero)
        viewOne.backgroundColor = .purple
        let label = UILabel(frame: CGRect(x: 8, y: 8, width: 150, height: 44))
        label.text = "UIView"
        viewOne.addSubview(label)
        let viewTwo = UIButton(frame: .zero)
        viewTwo.backgroundColor = .green
        viewTwo.setTitle("UIButton", for: .normal)
//        let viewTwo = UIView(frame: .zero)
//        viewTwo.backgroundColor = .blue
        let viewThree = UITextField(frame: .zero)
        viewThree.text = "This is a text field"
        viewThree.backgroundColor = .blue
        let viewFour = UILabel(frame: .zero)
        viewFour.text = "UILabel"
        viewFour.backgroundColor = .red
        views = [viewOne, viewTwo, viewThree, viewFour]
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        registerCell(ControlCell.self, in: tableView)
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueCell(ControlCell.self, at: indexPath, in: tableView)
        cell.setup(with: data[indexPath.row], view: views[indexPath.row])
        return cell
    }
    
}

