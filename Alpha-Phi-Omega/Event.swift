//
//  Event.swift
//  Alpha-Phi-Omega
//
//  Created by CheckoutUser on 3/19/18.
//  Copyright © 2018 Juan Ramirez. All rights reserved.
//

import UIKit

class Event {
    var name : String
    var date : String
    var time : String
    var location : String
    var summary : String
    var photo : UIImage?
    
    init?(name: String, date: String, time: String, location: String, summary: String, photo: UIImage?) {
        if name.isEmpty {
            return nil
        }
        
        self.name = name
        self.date = date
        self.time = time
        self.location = location
        self.summary = summary
        self.photo = photo
    }
}
