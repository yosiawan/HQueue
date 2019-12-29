//
//  PatientList.swift
//  HQueue
//
//  Created by Faridho Luedfi on 13/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class PatientList: UITableViewController {
    
    var networkManager: NetworkManager!
    var patients: [Patient] = []
    var perviousController: PatientListPerviousControllerDelegate?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Data Pasien"
        self.networkManager = NetworkManager()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addDataAction))
        
        tableView.register(UINib(nibName: "PatientCell", bundle: nil), forCellReuseIdentifier: "PatientCell")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.fetchData()
    }
    
    @objc func addDataAction() {
        
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return patients.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PatientCell", for: indexPath) as! PatientCell
        print("Fetch data patient", patients[indexPath.row])
        // Configure the cell...
        cell.patientLabel.text = patients[indexPath.row].fullName
        return cell
    }
    
    func handleModalDismissed() {
        print("okokok")
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    //}
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let prvController = self.perviousController {
            prvController.didPatientSelected(patient: patients[indexPath.row])
            self.navigationController?.popViewController(animated: true)
        }else{
            let vc = PatientDetail()
            vc.patient = patients[indexPath.row]
            vc.delegate = self
            let nav = UINavigationController(rootViewController: vc)
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    // MARK: - Fetching Data
    func fetchData() {
        networkManager.getPatient { data, error in
            if error != "" {
                print(#function, error)
            }

            if let data = data {
                self.patients = data
                print(#function, data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }

            }
        }
    }
}

protocol PatientListPerviousControllerDelegate {
    func didPatientSelected(patient: Patient) -> Void
}
