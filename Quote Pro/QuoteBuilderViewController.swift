//
//  QuoteBuilderViewController.swift
//  Quote Pro
//
//  Created by Will Chew on 2018-07-18.
//  Copyright © 2018 Will Chew. All rights reserved.
//

import UIKit

class QuoteBuilderViewController: UIViewController {
    var requestManager: RequestManager!
    var quote: Quote!
    var image: Image!
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        requestManager = RequestManager()
        quoteLabel.numberOfLines = 0
        view.backgroundColor = .black
        
        
        
        
        
        
        
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
    
    @IBAction func getImageButtonPressed(_ sender: UIButton) {
        
        requestManager.getImages { receivedImage in
            self.image = receivedImage
            
            DispatchQueue.main.async {
                print(#line, self.image)
                let url = URL(string: self.image.link)
                let data = try? Data(contentsOf: url!)
                self.imageView.image = UIImage(data: data!)
                
                
            }
            
            
        }
        
    }
    
}
