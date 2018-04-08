//
//  TableViewController.swift
//  OnTheMap
//
//  Created by Sultan on 08/04/18.
//  Copyright © 2018 Sultan. All rights reserved.
//

import UIKit

class TableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var studentInfo = [StudentInformation]()
    
    @IBOutlet weak var detailTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        detailTableView.delegate = self
        detailTableView.dataSource = self
    }
    override func viewDidAppear(_ animated: Bool) {
        let mapVC = MapViewController()
        studentInfo = mapVC.studentInfo
        print(studentInfo)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentInfo.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let prototypeCell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        let studentInfoForCell = studentInfo[indexPath.row]
        prototypeCell.textLabel?.text = studentInfoForCell.firstName
        prototypeCell.detailTextLabel?.text = studentInfoForCell.mediaURL
        return prototypeCell
    }

}
