//
//  JSONContent.swift
//  RetroTechAppTests
//
//  Created by Evgeniy Uskov on 11.03.2020.
//  Copyright © 2020 Evgeniy Uskov. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

public class JSONStorage {
    
    func getItems() -> JSON {
        return getData(jsonString: getItemsString())
    }
    
    func getDetails() -> JSON {
        return getData(jsonString: getDetailsString())
    }
    
    func getLinks() -> JSON {
        return getData(jsonString: getLinksString())
    }
    
    func getData(jsonString: String) -> JSON {
        var json: JSON?
        if let dataFromString = jsonString.data(using: .utf8, allowLossyConversion: false) {
            do {
                json = try JSON(data: dataFromString)
            } catch {
                print("ERROR Parsing details JSON: \(error)")
            }
        }
        let jsonResponse: JSON = json!
        debugPrint("JSON Details RESPONSE: \(jsonResponse)")
        return jsonResponse
    }
    
    func getLinksString () -> String {
        return """
            [
                {
                    "id": 151,
                    "name": "Nintendo Entertainment System"
                },
                {
                    "id": 152,
                    "name": "Nintendo Entertainment System"
                },
                {
                    "id": 153,
                    "name": "Nintendo Entertainment System"
                },
                {
                    "id": 154,
                    "name": "Nintendo Entertainment System"
                },
                {
                    "id": 155,
                    "name": "Nintendo Entertainment System"
                }
            ]
        """
    }
    
    func getDetailsString() -> String {
    return """
        {
            "id": 152,
            "name": "Acorn Archimedes",
            "introduced": "1985-12-31T19:00:00Z",
            "discounted": "1989-12-31T19:00:00Z",
            "imageUrl": "https://images-na.ssl-images-amazon.com/images/I/51d-Cedv7%2BL.jpg",
            "company": {
                "id": "22",
                "name": "Acorn computer"
            },
            "description": "SMTHNG SMTHNG"
        }
        """
    }
        
    func getItemsString() -> String {
    return """
        {
        "items": [
            {
                "id": 151,
                "name": "Acorn Archimedes-1",
                "company": {
                    "id": 22,
                    "name": "Acorn computer"
                }
            },
            {
                "id": 152,
                "name": "Acorn Archimedes-2",
                "company": {
                    "id": 22,
                    "name": "Acorn computer"
                }
            },
            {
                "id": 153,
                "name": "Acorn Archimedes-3",
                "company": {
                    "id": 22,
                    "name": "Acorn computer"
                }
            },
            {
                "id": 154,
                "name": "Acorn Archimedes-4",
                "company": {
                    "id": 22,
                    "name": "Acorn computer"
                }
            },
            {
                "id": 155,
                "name": "Acorn Archimedes-5",
                "company": {
                    "id": 22,
                    "name": "Acorn computer"
                }
            }
        ],
        "page": 0,
        "offset": 0,
        "total": 574
    }
    """
    }
}
