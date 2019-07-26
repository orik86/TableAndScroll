//
//  ViewController.swift
//  TableAndScroll
//
//  Created by Aleksandr Gazizov on 26/07/2019.
//  Copyright © 2019 Aleksandr Gazizov. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    
    @IBOutlet weak var numbersOfImage: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sliderOfNumbers.value = 1
        numbersOfImage.text = "1"
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        numbersOfImage.text = String(Int(round(sender.value)))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startSegue" {
            let tableView = segue.destination as? TableViewController
            tableView?.urlString = "https://picsum.photos/v2/list?page=2&limit=" + numbersOfImage.text!
        }
    }

}

