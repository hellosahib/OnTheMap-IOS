//
//  TableViewController.swift
//  OnTheMap
//
//  Created by Sultan on 08/04/18.
//  Copyright © 2018 Sultan. All rights reserved.
//

import UIKit

class TableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var detailTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        detailTableView.delegate = self
        detailTableView.dataSource = self
    }
    override func viewDidAppear(_ animated: Bool) {
        MapViewController().populateStudentInfo { (infoStudent) in
            DispatchQueue.main.async {
                self.detailTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentDataSource.sharedInstance.studentData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let prototypeCell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        let studentInfoForCell = StudentDataSource.sharedInstance.studentData[indexPath.row]
        prototypeCell.textLabel?.text = studentInfoForCell.firstName
        prototypeCell.detailTextLabel?.text = studentInfoForCell.mediaURL
        return prototypeCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIApplication.shared.open(URL(string:StudentDataSource.sharedInstance.studentData[indexPath.row].mediaURL)!, options:[:] , completionHandler: nil)
    }

}
