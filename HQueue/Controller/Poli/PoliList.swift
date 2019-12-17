//
//  PoliList.swift
//  HQueue
//
//  Created by Faridho Luedfi on 17/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class PoliList: UITableViewController {
    
    var networkManager: NetworkManager!
    
    var hospital: Hospital!
    
    var currentPage = 1
    
    @IBOutlet var headerView: UIView!
    
    var poliList: [Poli] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.networkManager = NetworkManager()
        
        tableView.register(UINib(nibName: "PoliCell", bundle: nil), forCellReuseIdentifier: "PoliCell")
        
        self.fetchingData()
        
        self.title = "Poliklinik Tersedia"
        
        self.navigationItem.largeTitleDisplayMode = .always
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.poliList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PoliCell", for: indexPath) as! PoliCell
        
        cell.setPoli(poli: poliList[indexPath.row] )
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        return headerView
//    }


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

    
    // MARK: - Navigation

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DoctorList()
        vc.currentPoli = poliList[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // MARK: - Fetching Data
    func fetchingData() {
        
        networkManager.getPoli(hospitalId: self.hospital.id, search: nil, page: self.currentPage) { (data, error) in
            if let error = error {
                print("Fetching poli data - error", error)
            }
            
            if let data = data {
                print("Fetching poli data", data)
                self.poliList = data.data
                DispatchQueue.main.async {
                 self.tableView.reloadData()
                }
            }
            
            /* if use refresh controller
            if isPullRefresh {
                 DispatchQueue.main.async {
                     self.refreshControler.endRefreshing()
                 }
            }
            */
        }
    }
    
}
