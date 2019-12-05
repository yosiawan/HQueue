//
//  HospitalList.swift
//  HQueue
//
//  Created by Faridho Luedfi on 15/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class HospitalList: UITableViewController {
    
    var networkManager: NetworkManager!
    var currentPage = 1
    
    @IBOutlet var viewCardHandler: UIView!
    @IBOutlet weak var btnCardHandler: UIButton!
    
    var hospitals: [Hospital] = []
    
    var searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.networkManager = NetworkManager()
        
        self.tableView.refreshControl = refreshControler
        
        self.title = "Hospitals"
        self.tableView.register(UINib(nibName: "HospitalCell", bundle: nil), forCellReuseIdentifier: "HospitalCell")
        self.btnCardHandler.layer.cornerRadius = self.btnCardHandler.frame.height / 2
        
        
        setUpSearchControll()
        
        fetchDataHospital( isPullRefresh: false)
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
        
        cell.setHospitalCard(hospitals[indexPath.row])
        
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
        vc.hospital = hospitals[indexPath.row]
        vc.title = hospitals[indexPath.row].name
        vc.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Refresh Controll
    
    lazy var refreshControler: UIRefreshControl = {
        let refreshControler = UIRefreshControl()
        refreshControler.addTarget(self, action: #selector(hadleRefresh), for: .valueChanged)
        
        return refreshControler
    }()
    
    @objc private func hadleRefresh(_ sender: Any) {
        self.fetchDataHospital( isPullRefresh: true)
    }
    
    
    // MARK: - Fetching hospital's data
    @objc private func fetchDataHospital(isPullRefresh:Bool = false) {
        
        let searchText = self.searchController.searchBar.text
        
        networkManager.getHospital(search: searchText, page: currentPage) { (data, error) in
            if let error = error {
                print("Fetching hospital data - error", error)
            }
            
            if let data = data {
                print("Fetching hospital data", data)
                self.hospitals = data.data
                DispatchQueue.main.async {
                 self.tableView.reloadData()
                }
            }
            
            if isPullRefresh {
                 DispatchQueue.main.async {
                     self.refreshControler.endRefreshing()
                 }
            }
        }
    }
    
   // MARK: - Search Controll
       
   fileprivate func setUpSearchControll() {
    searchController = ({
        let controller = UISearchController(searchResultsController: nil)
        controller.searchResultsUpdater = self
        controller.obscuresBackgroundDuringPresentation = false
        controller.hidesNavigationBarDuringPresentation = false
        controller.delegate = self
        controller.searchBar.delegate = self
        controller.searchBar.sizeToFit()
        controller.searchBar.placeholder = "Cari rumah sakit .."
        tableView.tableHeaderView = controller.searchBar
           
           return controller
    })()
   }
    
}

extension HospitalList: UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        //
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(fetchDataHospital), object: nil)
        
        self.perform(#selector(fetchDataHospital(isPullRefresh:)), with: nil, afterDelay: 0.8)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //
    }
    
    // reset pencarian
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        self.fetchDataHospital(isPullRefresh: false)
    }
}
