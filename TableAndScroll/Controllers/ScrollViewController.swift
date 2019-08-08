//
//  ScrollController.swift
//  TableAndScroll
//
//  Created by Aleksandr Gazizov on 26/07/2019.
//  Copyright © 2019 Aleksandr Gazizov. All rights reserved.
//
import MessageUI
import UIKit

class ScrollViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imageInfoView: imageOptions!
    var myImage: UIImage?
    var emailAdressF: String = ""
    var emailSubjectF: String = ""
    var emailTextF: String = ""
    
    
    
    @IBOutlet weak var imageFull: UIImageView!
    @IBOutlet weak var width: UILabel!
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
    
    @IBAction func sendEmail(_ sender: Any) {
        guard MFMailComposeViewController.canSendMail() else {
            print(#line, #function, "Can't send e-mail")
            return
        }
        allertForEmail()

    }
    
    
    @IBAction func sendSMS(_ sender: Any) {
        guard MFMessageComposeViewController.canSendText() else {
            print(#line, #function, "Can't send message")
            return
        }
        allertForSms()
    }
    
    @IBAction func goToUrl(_ sender: UIButton) {
        
        let url = URL(string: imageInfoView.url)
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        
    }
    
    func allertForEmail() {
         let alert = UIAlertController(title: title, message: "Куда отправим?", preferredStyle: .alert)
        
        //E-mail adress
        var emailAdress: UITextField!
        //E-mail subject
        var subjectEmail: UITextField!
        //E-mail text
        var textEmail: UITextField!
        
         let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
    
         alert.addTextField { textField in
            emailAdress = textField
            emailAdress.placeholder = "Input E-mail"
        }
        
        alert.addTextField { textField in
            subjectEmail = textField
            subjectEmail.placeholder = "Input subject"
        }
            
        alert.addTextField { textField in
            textEmail = textField
            textEmail.placeholder = "Input Text"
        }
         
            let sendAction = UIAlertAction(title: "Send Email", style: .default) { _ in
                if emailAdress.text! != "" {
                    self.emailAdressF = emailAdress.text ?? ""
                    print("EMAIL ADRES>>>>> ", self.emailAdressF)
                    self.emailSubjectF = subjectEmail.text ?? ""
                    self.emailTextF = textEmail.text ?? ""
                    let mailComposer = MFMailComposeViewController()
                    mailComposer.mailComposeDelegate = self
                    mailComposer.setToRecipients([self.emailAdressF])
                    mailComposer.setSubject(self.emailSubjectF)
                    mailComposer.setMessageBody(self.emailTextF, isHTML: false)
                    let imageData: NSData = self.imageFull.image!.pngData()! as NSData
                    mailComposer.addAttachmentData(imageData as Data, mimeType: "image/jpeg", fileName: self.imageInfoView.download_url)
                    self.present(mailComposer, animated: true)
                } else { emailAdress.text = "INPUT EMAIL"}
            }
        alert.addAction(cancelAction)
        alert.addAction(sendAction)
        
        present(alert, animated: true)
    }
    
    func allertForSms() {
        let alert = UIAlertController(title: title, message: "Куда отправим?", preferredStyle: .alert)
        //var imageData: NSData?
        var telNumber: UITextField!
        var textSMS: UITextField!
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        alert.addTextField { textField in
            telNumber = textField
            telNumber.placeholder = "Input number"
        }
        
        alert.addTextField { textField in
            textSMS = textField
            textSMS.placeholder = "Input text"
        }
        let sendAction = UIAlertAction(title: "Send SMS", style: .default) { _ in
            let smsComposer = MFMessageComposeViewController()
            smsComposer.messageComposeDelegate = self
            let numbersTel = telNumber.text ?? ""
            smsComposer.recipients = [numbersTel]
            let message = textSMS.text ?? ""
            smsComposer.body = message
            let imageData: NSData = self.imageFull.image!.jpegData(compressionQuality: 1)! as NSData
            smsComposer.addAttachmentData(imageData as Data, typeIdentifier: "image/jpeg", filename: self.imageInfoView.download_url + ".jpg")
            self.present(smsComposer, animated: true)
        }
        
        alert.addAction(cancelAction)
        alert.addAction(sendAction)
        
        present(alert, animated: true)
        
    }
    
    func getImage() {
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
}

extension ScrollViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true)
    }
}
extension ScrollViewController: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        dismiss(animated: true)
    }
    
    
}
