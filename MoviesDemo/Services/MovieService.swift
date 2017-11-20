//
//  MovieService.swift
//  MoviesDemo
//
//  Created by Shrimant Nikate on 18/11/17.
//  Copyright © 2017 Shrimant Nikate. All rights reserved.
//

import UIKit
import Alamofire.Swift
import SwiftyJSON
class MovieService: NSObject {
    static func fetchData(fromSavedUrl url: String, callback: ((JSON?, Error?) -> Void)?)
    {
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                callback?(json,nil)
            case .failure(let error):
                print(error)
                callback?(nil,error)
            }
        }
    }
}
