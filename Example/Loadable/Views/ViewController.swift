//
//  ViewController.swift
//  Loadable
//
//  Created by Matthew Pierce on 11/15/2019.
//  Copyright (c) 2019 Matthew Pierce. All rights reserved.
//

import UIKit
import Loadable

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

    private func addDoneButtonToKeyboard() -> UIToolbar {
        let doneToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        doneToolBar.items = [doneButton]
        doneToolBar.sizeToFit()
        return doneToolBar
    }
    
    private func setupData() {
        let controlOne = ControlConfig(title: "This is a UIView",
                                       progress: Progress(totalUnitCount: 100),
                                       animate: true,
                                       showPercentage: true,
                                       clearOnComplete: true)
        let controlTwo = ControlConfig(title: "This is a UIButton",
                                       progress: Progress(totalUnitCount: 100),
                                       animate: false,
                                       showPercentage: true,
                                       clearOnComplete: true)
        let controlThree = ControlConfig(title: "This is a UITextField",
                                         progress: Progress(totalUnitCount: 100),
                                         animate: false,
                                         showPercentage: false,
                                         clearOnComplete: true)
        let controlFour = ControlConfig(title: "This is a UISegmentControl",
                                        progress: Progress(totalUnitCount: 100),
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
        viewTwo.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        let viewThree = UITextField(frame: .zero)
        viewThree.text = "I'm a text field, edit me!"
        viewThree.textColor = .white
        viewThree.backgroundColor = .blue
        viewThree.inputAccessoryView = addDoneButtonToKeyboard()
        let viewFour = UISegmentedControl(items: ["One", "Two"])
        views = [viewOne, viewTwo, viewThree, viewFour]
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        registerCell(ControlCell.self, in: tableView)
    }

    // MARK: - Private actions

    @objc private func buttonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Button tapped", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    @objc private func doneButtonTapped(_ sender: Any) {
        view.endEditing(true)
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

