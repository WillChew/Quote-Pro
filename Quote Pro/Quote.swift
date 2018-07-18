//
//  Quote.swift
//  Quote Pro
//
//  Created by Will Chew on 2018-07-18.
//  Copyright © 2018 Will Chew. All rights reserved.
//

import UIKit

class Quote {
    var quote: String?
    var author: String?
    
    init(quote: String, author: String?) {
        self.quote = quote ?? "No Quote"
        self.author = author ?? "No author"
    }
}
