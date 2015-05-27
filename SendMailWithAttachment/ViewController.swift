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
            
            //Attach the Image
            if let fileData = NSData(contentsOfFile: getAttachmentPath()){
                NSLog("Attachment loaded.")
                mailComposer.addAttachmentData(fileData, mimeType: "image/png", fileName: getAttachmentPath().lastPathComponent)
            }
            else{
                NSLog("Attachment not found.")
            }
            
            self.presentViewController(mailComposer, animated: true, completion: nil)
        }
        
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        switch result.value{
        case MFMailComposeResultCancelled.value:
            NSLog("Cancelled")
            break
        case MFMailComposeResultSaved.value:
            NSLog("Saved")
            break
        case MFMailComposeResultSent.value:
            NSLog("Sent")
            break
        case MFMailComposeResultFailed.value:
            NSLog("Failed")
            break
        default:
            NSLog("Status Unknown")
            break
        }

        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func getAttachmentPath() -> String{
        let attachmentFileName = "Owl.png"
        let attachmentPath = NSTemporaryDirectory().stringByAppendingPathComponent(attachmentFileName)
        
        return attachmentPath
    }
}

