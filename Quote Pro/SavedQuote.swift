//
//  SavedQuote.swift
//  Quote Pro
//
//  Created by Will Chew on 2018-07-18.
//  Copyright © 2018 Will Chew. All rights reserved.
//

import UIKit

class SavedQuote {
    var quote: Quote
    var picture: Data
    
    init(quote: Quote, picture: Data) {
        self.quote = quote
        self.picture = picture
    }
}
