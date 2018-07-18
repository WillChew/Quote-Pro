//
//  ViewController.swift
//  Quote Pro
//
//  Created by Will Chew on 2018-07-18.
//  Copyright © 2018 Will Chew. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var requestManager: RequestManager!
    var quote: Quote!

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        requestManager = RequestManager()
          quoteLabel.numberOfLines = 0
        
        
        
        

        
       
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func getQuoteButtonPressed(_ sender: UIButton) {
        
        requestManager.getQuote {receivedQuote in
            self.quote = receivedQuote
           
            DispatchQueue.main.async {
              

                self.quoteLabel.text = receivedQuote.quote

                self.authorLabel.text = receivedQuote.author
            }
           
        }

        
        
    }
    
}

