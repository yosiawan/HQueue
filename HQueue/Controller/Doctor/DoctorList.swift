//
//  DoctorList.swift
//  HQueue
//
//  Created by Yosia on 19/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class DoctorList: UIViewController {

    var namaPoli = UILabel()
    var descriptionLbl = UILabel()
    var searchBar = UISearchController()
//    var underline = UIView()
    var doctorListTable = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doctorListTable.delegate = self
        doctorListTable.dataSource = self
        
        doctorListTable.rowHeight = 70
        doctorListTable.register(DoctorListCell.self, forCellReuseIdentifier: doctorListCellIdentifier)
        doctorListTable.separatorStyle = .none
        searchBar = ({
            let controller = UISearchController(searchResultsController: nil)
//            controller.searchResultsUpdater = doctorListTable
            //controller.dimsBackgroundDuringPresentation = false // iOS 12
            controller.searchBar.sizeToFit()
            controller.searchBar.placeholder = "Cari dokter favoritmu"
            doctorListTable.tableHeaderView = controller.searchBar

            return controller
        })()
        self.setupConstraints()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
// MARK: - Table View Delegate & Data Source
extension DoctorList: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: doctorListCellIdentifier, for: indexPath) as! DoctorListCell
        cell.doctorImg.image = UIImage(named: "15ED3323-1B89-4A25-80B9-44D102558994")
        cell.doctorName.text = "Dokter Faridho"
//        cell?.textLabel?.text = "Title Text"
//        cell?.detailTextLabel?.text = "Detail Text"
        return cell
    }
}

// MARK: - UI Search Result
extension DoctorList: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = self.searchBar.searchBar.text!
        
        print(searchText)
        // Ambil data dari endpoint berdasarkan pencarian.
        // Code.
        
        self.doctorListTable.reloadData()
    }
}
