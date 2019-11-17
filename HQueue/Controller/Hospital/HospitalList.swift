//
//  HospitalList.swift
//  HQueue
//
//  Created by Faridho Luedfi on 15/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class HospitalList: UITableViewController {
    
    @IBOutlet var viewCardHandler: UIView!
    
    var hospitals: [Hospital] = [
        Hospital(id: 123, name: "RS Sumber Waras", address: "Jl. Cempaka 40, Jakarta Timur"),
        Hospital(id: 122, name: "RSIA Putra Mahkota", address: "Jl. Lumbung 40, Jakarta Timur"),
        Hospital(id: 121, name: "RSUD Cakung", address: "Jl. Cempaka 40, Bekasi")
    ]
    
    var searchController = UISearchController()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Hospitals"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.tableView.register(UINib(nibName: "HospitalCell", bundle: nil), forCellReuseIdentifier: "HospitalCell")
        
        searchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            //controller.dimsBackgroundDuringPresentation = false // iOS 12
            controller.searchBar.sizeToFit()
            controller.searchBar.placeholder = "Cari rumah sakit .."
            tableView.tableHeaderView = controller.searchBar

            return controller
        })()
        
        self.tableView.reloadData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return self.hospitals.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HospitalCell", for: indexPath) as! HospitalCell

        cell.titleLabel.text = hospitals[indexPath.row].name
        cell.addressLabel.text = hospitals[indexPath.row].address
        
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = HospitalDetail()
        vc.title = hospitals[indexPath.row].name
        vc.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension HospitalList: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = self.searchController.searchBar.text!
        
        print(searchText)
        // Ambil data dari endpoint berdasarkan pencarian.
        // Code.
        
        self.tableView.reloadData()
    }
}