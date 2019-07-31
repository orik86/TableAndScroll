//
//  AddTableViewControllers.swift
//  TableAndScroll
//
//  Created by Aleksandr Gazizov on 01/08/2019.
//  Copyright © 2019 Aleksandr Gazizov. All rights reserved.
//

import UIKit

class AddTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var addImage = imageOptions()
    
    @IBOutlet var loadAuthor: UITextField!
    @IBOutlet var loadWidth: UILabel!
    @IBOutlet var loadHeight: UILabel!
    @IBOutlet var imageView: UIImageView!

    @IBOutlet var saveButton: UIBarButtonItem!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
       let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddTableViewController.tappedImage))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        saveButton.isEnabled = false
    }

 
    @objc func tappedImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        imageView.image = image
        let imageMyUrl = info[UIImagePickerController.InfoKey.imageURL] as! NSURL
        let urlString: String = imageMyUrl.absoluteString!
        addImage.download_url = urlString
        if let size = image?.size {
            saveButton.isEnabled = true
            loadWidth.text = String(Int(size.width))
            addImage.width = Int(size.width)
            loadHeight.text = String(Int(size.height))
            addImage.height = Int(size.height)
            let username = UIDevice.current.name
            loadAuthor.text = username
            addImage.author = loadAuthor.text!
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
