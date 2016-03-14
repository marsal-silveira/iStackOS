//
//  DataSource.swift
//  iStackOS
//
//  Created by Marsal on 13/03/16.
//  Copyright © 2016 Marsal Silveira. All rights reserved.
//

import Alamofire
import Gloss

// ****************************** //
// MARK: StackOverflowTag
// ****************************** //

enum StackOverflowTag : String
{
    case iPhone = "iphone"
    case CocoaTouch = "cocoa-touch"
    case UiKit = "uikit"
    case ObjectiveC = "objective-c"
    case Swift = "swift"
}

// ****************************** //
// MARK: DataSource
// ****************************** //

final class DataSource
{
    // ****************************** //
    // MARK: Singleton
    // ****************************** //
    
    private static let singleton = DataSource()
    static func sharedInstance() -> DataSource
    {
        return singleton
    }
    
    // this prevents others from using the default '()' initializer for this class
    private init() {}
    
    // ****************************** //
    // MARK: Properties
    // ****************************** //

//    private let STACK_OVERFLOW_API_QUESTIONS_BASE_URL = "https://api.stackexchange.com/2.2/questions?pagesize=20&order=desc&sort=activity&site=stackoverflow&filter=withbody&tagged="
    private let STACK_OVERFLOW_API_QUESTIONS_BASE_URL = "https://api.stackexchange.com/2.2/questions?pagesize=50&page=4&order=desc&sort=creation&site=stackoverflow&tagged="
    
    // ********************************** //
    // MARK: Load Data using some filters
    // ********************************** //
    
    // filters
    // - site = stackoverflow
    // - pageSize = 20
    // - order = desc
    // - sort = activity
    // - filter = withbody
    // - tagged = ??
    func loadDataWithTag(tag: StackOverflowTag, successBlock:((questions: [Question]) -> Void), failureBlock:((error: NSError) -> Void))
    {
        Logger.log(tag.rawValue)
        
        Alamofire.request(.GET, STACK_OVERFLOW_API_QUESTIONS_BASE_URL + tag.rawValue).responseJSON {
            response in
            
//            print(response.request)  // original URL request
//            print(response.response) // URL response
//            print(response.data)     // server data
//            print(response.result)   // result of response serialization
//            debugPrint(response)
//            
//            if let JSON = response.result.value {
//                print("JSON: \(JSON)")
//            }
            
            if (response.result.isFailure) {
                failureBlock(error: response.result.error!)
            }
            else {
                
                var questions: [Question] = []
                if let json = response.result.value, let jsonQuestions = json["items"] as? NSArray {
                    
                    for jsonQuestion in jsonQuestions {
//                        print(jsonQuestion)
                        
                        if let question = Question(json: jsonQuestion as! Gloss.JSON) {
                            questions.append(question)
                        }
                        // TODO: check this context... maybe return failureBlock with custom error...
//                        else {
//                            print("Error...")
//                            abort()
//                        }
                    }
                }
                else {
                    // TODO: check this context... maybe return failureBlock with custom error...
                }
                successBlock(questions: questions)
            }
        }
    }
    
}