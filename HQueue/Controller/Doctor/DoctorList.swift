//
//  DoctorList.swift
//  HQueue
//
//  Created by Yosia on 19/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class DoctorList: UIViewController {
    
    var networkManager: NetworkManager!
    
    var currentPoli: Poli!
    var doctors: [Doctor] = []
    
    var namaPoli = UILabel()
    var descriptionLbl = UILabel()
    var searchBar = UISearchController()
//    var underline = UIView()
    var doctorListTable = UITableView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doctorListTable.delegate = self
        doctorListTable.dataSource = self
        
        self.networkManager = NetworkManager()
        self.doctorListTable.refreshControl = refreshControler
        
        doctorListTable.rowHeight = 70
        doctorListTable.register(DoctorListCell.self, forCellReuseIdentifier: doctorListCellIdentifier)
        doctorListTable.separatorStyle = .none
        searchBar = ({
            let controller = UISearchController(searchResultsController: nil)
            //controller.dimsBackgroundDuringPresentation = false // iOS 12
            controller.obscuresBackgroundDuringPresentation = false
            controller.hidesNavigationBarDuringPresentation = false
//            controller.searchBar.sizeToFit()
            controller.searchBar.placeholder = "Cari dokter favoritmu"
            controller.delegate = self
            controller.searchBar.delegate = self
            controller.searchResultsUpdater = self
            doctorListTable.tableHeaderView = controller.searchBar

            return controller
        })()
        self.setupConstraints()

        self.fetchingData()
        
        // Data Poli
        namaPoli.text = currentPoli.name
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DoctorDetail()
        vc.setupView(doctors[indexPath.row])
        vc.currentHospitalId = currentPoli.hospitalId
        vc.currentDoctor = doctors[indexPath.row]
        self.navigationController?.pushViewController(vc, animated:true)
    }
    
    // MARK: - Refresh Controll
    lazy var refreshControler: UIRefreshControl = {
        let refreshControler = UIRefreshControl()
        refreshControler.addTarget(self, action: #selector(hadleRefresh), for: .valueChanged)
        
        return refreshControler
    }()
    
    @objc private func hadleRefresh(_ sender: Any) {
        self.fetchingData(true)
    }
}
// MARK: - Table View Delegate & Data Source
extension DoctorList: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.doctors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: doctorListCellIdentifier, for: indexPath) as! DoctorListCell
        cell.doctorImg.image = UIImage(named: "15ED3323-1B89-4A25-80B9-44D102558994")
        cell.doctorName.text = doctors[indexPath.row].name
        cell.labelJadwal1.text = doctors[indexPath.row].schedule[0].time
        return cell
    }
}

// MARK: - UI Search Result
extension DoctorList: UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        //
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(fetchingData), object: nil)
        
        self.perform(#selector(fetchingData), with: nil, afterDelay: 0.8)
    }
    
    // reset pencarian
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        self.fetchingData()
    }
    
}


// MARK: Fetch Doctor
extension DoctorList {
    @objc func fetchingData(_ isPullRefresh: Bool = false) {
        guard let poli = self.currentPoli else { return }
        
        let searchText = self.searchBar.searchBar.text
        
        self.networkManager.getDoctor(search: searchText, poli: poli, page: 1) { (data, error) in
            if error != "" {
                print(#function, error)
            }
        
            if let data = data {
                self.doctors = data
                DispatchQueue.main.async {
                    self.doctorListTable.reloadData()
                }
            }
            
            if isPullRefresh {
                 DispatchQueue.main.async {
                     self.refreshControler.endRefreshing()
                 }
            }
        }
    }
}
