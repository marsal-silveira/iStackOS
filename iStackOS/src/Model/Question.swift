//
//  Question.swift
//  iStackOS
//
//  Created by Marsal on 13/03/16.
//  Copyright © 2016 Marsal Silveira. All rights reserved.
//

import Foundation
import Gloss

public struct Question: Decodable
{
    // ****************************** //
    // MARK: Properties
    // ****************************** //

    private var _id: Int
    public var id: Int {
        return _id
    }
    
    private var _title: String
    public var title: String {
        return _title
    }
    
    private var _answerCount: Int
    var answerCount: Int {
        return _answerCount
    }
    
    private var _score: Int
    var score: Int {
        return _score
    }
    
    private var _link: String
    var link: String {
        return _link
    }
    
    private var _creationDate: NSDate
    var creationDate: NSDate {
        return _creationDate
    }
    
    private var _owner: User
    var owner: User {
        return _owner
    }

    // ****************************** //
    // MARK: Init
    // ****************************** //
    
    public init?(json: JSON)
    {
        guard let id: Int = "question_id" <~~ json,
              let title: String = "title" <~~ json,
              let answerCount: Int = "answer_count" <~~ json,
              let score: Int = "score" <~~ json,
              let link: String = "link" <~~ json,
              let creationDateTimeInterval: NSTimeInterval = "creation_date" <~~ json,
              let owner: User = "owner" <~~ json else {
            return nil
        }
        
        _id = id
        _title = title
        _answerCount = answerCount
        _score = score
        _link = link
        _creationDate = NSDate(timeIntervalSince1970: creationDateTimeInterval)
        _owner = owner
    }

}