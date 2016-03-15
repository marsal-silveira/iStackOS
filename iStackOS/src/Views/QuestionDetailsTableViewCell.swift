//
//  QuestionDetailsTableViewCell.swift
//  iStackOS
//
//  Created by Marsal on 15/03/16.
//  Copyright © 2016 Marsal Silveira. All rights reserved.
//

import UIKit
import Haneke

class QuestionDetailsTableViewCell: UITableViewCell
{
    // *********************************** //
    // MARK: @IBOutlet
    // *********************************** //
    
    @IBOutlet private weak var _lblAnswersCount: UILabel!
    @IBOutlet private weak var _lblScore: UILabel!
    
    @IBOutlet private weak var _lblTitle: UILabel!

    @IBOutlet private weak var _lblCreationDate: UILabel!
    @IBOutlet private weak var _imgUserAvatar: UIImageView!
    @IBOutlet private weak var _lblUserDisplay: UILabel!

    // *********************************** //
    // MARK: Load
    // *********************************** //

    override func prepareForReuse()
    {
        // just clear all ui fields
        _lblAnswersCount.text = ""
        _lblScore.text = ""
        
        _lblTitle.text = ""
        
        _lblCreationDate.text = ""
        _imgUserAvatar.image = UIImage(imageLiteral: "default-avatar")
        _lblUserDisplay.text = ""
    }

    func configureCellWithQuestion(question: Question)
    {
        // load labels and image view with club properties
        _lblAnswersCount.text = "\(question.answerCount)"
        _lblScore.text = "\(question.score)"
        
        _lblTitle.text = question.title
        
        _lblCreationDate.text = self.decodeCreationDate(question.creationDate)
        _imgUserAvatar.hnk_setImageFromURL(question.owner.avatarURL)
        _lblUserDisplay.text = question.owner.displayName
    }
    
    private func decodeCreationDate(creationDate: NSDate) -> String?
    {
        var result: String? = nil;
        
        // if asked today = "Asked XX hours ago"
        if (creationDate.dateToString() == NSDate().dateToString()) {
            
            let calendar = NSCalendar.currentCalendar()
            
            // get creation and current hour and minute
            var components = calendar.components([NSCalendarUnit.Hour, NSCalendarUnit.Minute], fromDate: creationDate)
            let creationHour = components.hour
            let creationMinute = components.minute
            components = calendar.components([NSCalendarUnit.Hour, NSCalendarUnit.Minute], fromDate: NSDate())
            let currentHour = components.hour
            let currentMinute = components.minute
            
            //
            var period = 0
            var periodStr: String! = nil
            if (creationHour != currentHour) {
                period = currentHour-creationHour
                periodStr = "\(period) \(period == 1 ? NSLocalizedString("[hour]", comment: "") : NSLocalizedString("[hours]", comment: ""))"
            }
            else {
                period = currentMinute-creationMinute
                periodStr = "\(period) \(period == 1 ? NSLocalizedString("[minute]", comment: "") : NSLocalizedString("[minutes]", comment: ""))"
            }
            result = String.localizedStringWithFormat(NSLocalizedString("[Asked Today]", comment: ""), periodStr)
        }
        // if asked yesterday = "Asked yesterday at hh:mm:ss"
        else if (creationDate.dateToString() == self.getYesterday().dateToString()) {
            result = String.localizedStringWithFormat(NSLocalizedString("[Asked Yesterday]", comment: ""), creationDate.timeToString())
        }
        // otherwise = "Asked at dd de MMMM de yyyy"
        else {
            let formatter = NSDateFormatter()
            formatter.dateStyle = NSDateFormatterStyle.MediumStyle
            formatter.timeStyle = NSDateFormatterStyle.ShortStyle
            result = String.localizedStringWithFormat(NSLocalizedString("[Asked Month]", comment: ""), formatter.stringFromDate(creationDate))
        }
        return result;
    }
    
    private func getYesterday() -> NSDate
    {
        let now = NSDate()
        let components = NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: now)
        components.day = -1
        
        // create a calendar and return yesterday NSDate value
        let gregorian = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        return (gregorian?.dateByAddingComponents(components, toDate: now, options:NSCalendarOptions(rawValue: 0)))!
    }

}