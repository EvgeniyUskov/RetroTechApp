//
//  DateUtils.swift
//  NaumenTestApp
//
//  Created by Evgeniy Uskov on 04.03.2020.
//  Copyright © 2020 Evgeniy Uskov. All rights reserved.
//

import UIKit

class DateUtils {
    static func stringToDate (dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: dateString)
    }
    
    static func stringToDateTime (dateString: String) -> Date? {
        if dateString != "" {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            
            let date = dateFormatter.date(from:dateString)
            return date
        }
        return nil
    }
    
    static func dateToString (date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        return dateFormatter.string(from: date)
    }
    
    static func dateToLiteralString (date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "dd MMM yyyy"
        
        return dateFormatter.string(from: date)
    }
    
    static func timeString (date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: date)
    }
    
    static func dateTimeToString (date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        
        return dateFormatter.string(from: date)
    }
}

