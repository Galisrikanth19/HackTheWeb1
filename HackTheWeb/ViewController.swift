//
//  ViewController.swift
//  HackTheWeb
//
//  Created by Srikanth Gali on 27/04/21.
//

import UIKit
import WebKit
import SwiftSoup

class ViewController: UIViewController {

    let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Project entry here")
        
//        let url = URL(string: "https://www1.nseindia.com/marketinfo/companyTracker/mtOptionKeys.jsp?companySymbol=INFY&indexSymbol=NIFTY&series=EQ&instrument=OPTSTK&date=-")!
//        let request = URLRequest(url: url)
//        webView.frame = self.view.bounds
//        var frame = webView.frame
//        frame.origin.y = 100
//        webView.frame = frame
//        webView.load(request)
//        view.addSubview(webView)
        
        
        let session = URLSession.shared
        let url = URL(string: "https://www1.nseindia.com/marketinfo/companyTracker/mtOptionKeys.jsp?companySymbol=INFY&indexSymbol=NIFTY&series=EQ&instrument=OPTSTK&date=-")!
            
        
        let task = session.dataTask(with: url) { data, response, error in
                // Check whether data is not nil
                guard let loadedData = data else { return }
//                // Load HTML code as string
                let contents = String(data: loadedData, encoding: .utf8)
               //let gmailResponse =  GmailResponse(contents)
            
            do {
                let gmailResponse = try GmailResponse(contents)
                
                
                var switchS = false
                for gmail in gmailResponse.emails {
                    if gmail.title == "1,347,600" {
                        switchS = true
                    }
                    
                    print(gmail.title)
                    if switchS {
                        print(gmail.title)
                        
                    }
                }
               // self.performSegue(withIdentifier: "ShowEmails", sender: gmailResponse.emails)
            } catch {}
            
            
//
//                print(gmailResponse.emails)
            }
            task.resume()
        
    }
    
    
    @IBAction func webclick(_ sender: Any) {
//        //var sree = "srikanth"
//       //sree = webView.evaluateJavaScript("\('sree') = document.getElementById('Email').value")
//
//        checkTitle(forWebView: webView, title: "Email", completion: { str in
//            print(str)
//        })
        
        
        webView.evaluateJavaScript("document.getElementsByTagName('html')[0].innerHTML", completionHandler: { (innerHTML, error) in
            do {
                
                print(innerHTML)
                let gmailResponse = try GmailResponse(innerHTML)
                
                print(gmailResponse.emails)
                //self.performSegue(withIdentifier: "ShowEmails", sender: gmailResponse.emails)
            } catch {}
        })
        
    }
    
    func checkTitle (forWebView webView: WKWebView, title: String, completion: @escaping (_ titleString: String?) -> Void) {

       webView.evaluateJavaScript("document.getElementById('Email').value", completionHandler: { (innerHTML, error ) in

            // Logic here
            completion(innerHTML as? String)
        })
    }
    
    
}
