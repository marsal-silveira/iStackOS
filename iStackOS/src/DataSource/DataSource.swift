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
    
    // ******************************** //
    // MARK: Properties and Constants
    // ******************************** //
    
    // params with default value
    private static let PARAM_page_size = 20
    private static let PARAM_page = 50
    private static let PARAM_order = "desc"
    private static let PARAM_sort = "creation"
    private static let PARAM_site = "stackoverflow"
    private static let PARAM_filter = "withbody"
    
    // URL base
//    private let STACK_OVERFLOW_API_QUESTIONS_BASE_URL = "https://api.stackexchange.com/2.2/questions?pagesize=20&order=desc&sort=activity&site=stackoverflow&filter=withbody&tagged="
    private static let STACK_OVERFLOW_API_QUESTIONS_BASE_URL = "https://api.stackexchange.com/2.2/questions?pagesize=\(PARAM_page_size)&page=\(PARAM_page)&order=\(PARAM_order)&sort=\(PARAM_sort)&site=\(PARAM_site)&tagged="
    
    // ********************************** //
    // MARK: Load Data using some filters
    // ********************************** //
    
    func loadDataWithTag(tag: StackOverflowTag, successBlock:((questions: [Question]) -> Void), failureBlock:((error: NSError) -> Void))
    {
        Logger.log("tag: \(tag.rawValue)")
        
        let url = DataSource.STACK_OVERFLOW_API_QUESTIONS_BASE_URL + tag.rawValue
        Alamofire.request(.GET,  url).responseJSON {
            response in

            if (response.result.isFailure) {
                failureBlock(error: response.result.error!)
            }
            else {
                
                var questions: [Question] = []
                if let json = response.result.value, let jsonQuestions = json["items"] as? NSArray {
                    
                    for jsonQuestion in jsonQuestions {
                        
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