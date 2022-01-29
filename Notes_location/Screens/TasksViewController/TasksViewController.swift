//
//  TasksViewController.swift
//  Notes_location
//
//  Created by admin on 11/1/22.
//

import UIKit

class TasksViewController: UIViewController {
    @IBOutlet weak var addLocationLabel: UILabel!
    @IBOutlet weak var addMessageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addLocationLabel.isUserInteractionEnabled = true
        addLocationLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openLocationBtn)))
        
        addMessageLabel.isUserInteractionEnabled = true
        addMessageLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openMessageBtn)))
        
    }
}

extension TasksViewController {
    @objc func openLocationBtn() {
        let mapViewController = MapViewController()
        navigationController?.pushViewController(mapViewController, animated: true)
    }
    
    @objc func openMessageBtn() {
        
    }
}
