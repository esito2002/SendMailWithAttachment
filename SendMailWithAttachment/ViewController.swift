//
//  ViewController.swift
//  SendMailWithAttachment
//
//  Created by Subodh Jena on 18/05/15.
//  Copyright (c) 2015 Owl. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var sendMailButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didTapSendMail(sender: AnyObject) {
        if( MFMailComposeViewController.canSendMail() ) {
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self
            
            //Set the subject and message of the email
            mailComposer.setSubject("This is the Subject")
            mailComposer.setMessageBody("This is the body, Yo!", isHTML: false)
            
            // This is the attachment
            if let filePath = NSBundle.mainBundle().pathForResource("swifts", ofType: "wav") {
                println("File path loaded.")
                
                if let fileData = NSData(contentsOfFile: filePath) {
                    println("File data loaded.")
                    mailComposer.addAttachmentData(fileData, mimeType: "audio/wav", fileName: "swifts")
                }
            }
            
            self.presentViewController(mailComposer, animated: true, completion: nil)
        }
        
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

