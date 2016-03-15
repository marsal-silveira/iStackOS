//
//  Answer.swift
//  iStackOS
//
//  Created by Domsys on 15/03/16.
//  Copyright © 2016 Marsal Silveira. All rights reserved.
//

import Foundation
import Gloss

public struct Answer: Decodable
{
    // ****************************** //
    // MARK: Properties
    // ****************************** //
    
    private var _id: Int
    public var id: Int {
        return _id
    }
    
    private var _body: String
    public var body: String {
        return _body
    }
    
    // ****************************** //
    // MARK: Init
    // ****************************** //
    
    public init?(json: JSON)
    {
        guard let id: Int = "question_id" <~~ json,
            let body: String = "title" <~~ json else {
                return nil
        }
        
        _id = id
        _body = body
    }


}