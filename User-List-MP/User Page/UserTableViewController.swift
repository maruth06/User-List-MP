//
//  UserTableViewController.swift
//  Users-Miho
//
//  Created by Mac on 9/10/20.
//  Copyright © 2020 Miho. All rights reserved.
//

import UIKit

//  List of followers and following

class UserTableViewController: UITableViewController {

    private var viewModel : UserTableViewModel!
    
    convenience init(_ users: [User]) {
        self.init()
        self.viewModel = UserTableViewModel(users)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    
    // MARK: - UI Methods
    private func configureView() {
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        tableView.register(nib: [UserTableViewCell.self])
        tableView.reloadData()
        
        let barItemCancel = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissView))
        self.navigationItem.rightBarButtonItem = barItemCancel
    }
    
    // MARK: - Action Methods
    @objc private func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.viewModel.dataSource
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UserTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let model = viewModel.getUser(row: indexPath.row)
        cell.userNameLabel.text = model.login
        cell.userDescriptionLabel.text = model.type
        cell.userProfileImageView.downloadImage(model.avatarUrl, UIImage(named: "icon-user"), nil)
        cell.noteImageView.isHidden = true
        return cell
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
