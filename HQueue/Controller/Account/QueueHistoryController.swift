//
//  QueueHistoryController.swift
//  HQueue
//
//  Created by Yosia on 11/12/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class QueueHistoryController: UIViewController {
    
    var networkManager: NetworkManager!

    var titleLbl = UILabel()
    var tableView = UITableView()
    
    var queueList: [QueueEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.networkManager = NetworkManager()
        
        self.tableView.refreshControl = refreshControler
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.setConstraints()
        
        self.tableView.rowHeight = 143
        self.tableView.register(QueueHistoryCell.self, forCellReuseIdentifier: queueHistoryCellIdentifier)
        self.tableView.separatorStyle = .none
        
        self.fetchData()
    }
    
    //MARK: Refresh Controll
    
    lazy var refreshControler: UIRefreshControl = {
        let refreshControler = UIRefreshControl()
        refreshControler.addTarget(self, action: #selector(hadleRefresh), for: .valueChanged)
        
        return refreshControler
    }()
    
    @objc private func hadleRefresh(_ sender: Any) {
        self.fetchData()
    }
    
    //MARK: Fetch Queue Index
    func fetchData() {
        networkManager.getHistoryQueue { data, error in
            if error != nil {
                DispatchQueue.main.async {
                    self.presentAlert(
                        alert: .init(
                            title: "Info",
                            message: error,
                            preferredStyle: .alert),
                        actions: nil,
                        comletion: nil
                    )
                }
            }
            
            if let queueEntities = data {
                self.queueList = queueEntities
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
            DispatchQueue.main.async {
                self.refreshControler.endRefreshing()
            }
        }
    }
    
}


extension QueueHistoryController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.queueList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: queueHistoryCellIdentifier, for: indexPath) as! QueueHistoryCell

        // Configure the cell...
        cell.hospitalName.text = self.queueList[indexPath.row].hospital.name
        cell.dateLbl.text = self.queueList[indexPath.row].submitTime.changeToString(format: "dd/MM/YYYY")
        cell.poliName.text = self.queueList[indexPath.row].poliName
        cell.doctorName.text = self.queueList[indexPath.row].doctor.name
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
