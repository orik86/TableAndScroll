//
//  ScrollController.swift
//  TableAndScroll
//
//  Created by Aleksandr Gazizov on 26/07/2019.
//  Copyright © 2019 Aleksandr Gazizov. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imageInfoView: imageOptions!
    var myImage: UIImage?
    
    
    
    @IBOutlet weak var imageFull: UIImageView!
    @IBOutlet weak var width: UILabel!
    
    @IBOutlet weak var downloadUrl: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var height: UILabel!
   
    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        getImage()
        imageFull.isUserInteractionEnabled = true
        fillAll()
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
    }
    
    private func fillAll() {
        author.text = imageInfoView.author
        width.text = imageInfoView.stringWidth
        height.text = imageInfoView.stringHeight
        button.setTitle(imageInfoView.url, for: .normal)
        
    }
    
    
    @IBAction func goToUrl(_ sender: UIButton) {
        
        let url = URL(string: imageInfoView.url)
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    
    private func getImage() {
        guard let url = URL(string: imageInfoView.download_url) else { return }
            
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                    print(error)
                    return
                }
                
            if let response = response {
                    print(response)
                }
                
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imageFull.image = image
                    self.indicator.stopAnimating()
                    }
                }
                }.resume()
    }
    

    
    @IBAction func picker(_ sender: Any) {
    
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
 

    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
       // if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            //self.imageFull.image = image
            let imageMyUrl = info[UIImagePickerController.InfoKey.imageURL] as! NSURL
            let urlString: String = imageMyUrl.absoluteString!
            imageInfoView.download_url = urlString
            picker.dismiss(animated: true, completion: nil)
        getImage()
      }

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}

