//
//  QuestionTableViewCell.swift
//  iStackOS
//
//  Created by Marsal on 13/03/16.
//  Copyright © 2016 Marsal Silveira. All rights reserved.
//

import UIKit
import Haneke

class QuestionTableViewCell: UITableViewCell
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
    @IBOutlet private weak var _lblUserReputation: UILabel!

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
        _lblUserReputation.text = ""
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
        _lblUserReputation.text = "\(question.owner.reputation)"
    }
    
    private func decodeCreationDate(creationDate: NSDate) -> String?
    {
        var result: String? = nil;
        
        // if published today = "Publicado há XX horas"
        if (creationDate.dateToString() == NSDate().dateToString()) {
            
            let calendar = NSCalendar.currentCalendar()
            
            // activity hour and minute
            var components = calendar.components([NSCalendarUnit.Hour, NSCalendarUnit.Minute], fromDate: creationDate)
            let creationHour = components.hour
            let creationMinute = components.minute
            
            // current hour and minute
            components = calendar.components([NSCalendarUnit.Hour, NSCalendarUnit.Minute], fromDate: NSDate())
            let currentHour = components.hour
            let currentMinute = components.minute
            
            //
            if (creationHour != currentHour) {
                result = "há \(currentHour-creationHour) \(currentHour-creationHour == 1 ? "hora" : "horas")"
            }
            else {
                result = "há \(currentMinute-creationMinute) \(currentMinute-creationMinute == 1 ? "minuto" : "minutos")"
            }
        }
        // if published yesterday = "Publicado ontem as hh:mm:ss"
        else if (creationDate.dateToString() == self.getYesterday().dateToString()) {
            
            result = "Ontem as \(creationDate.timeToString())"
        }
        // otherwise = "Publicado em dd de MMMM de yyyy"
        else {
            let day = creationDate.dayToString()
            let month = self.translateMonth(Int(creationDate.monthNumberToString())!)
            let year = creationDate.yearToString()
            result = "\(day) de \(month) de \(year)"
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

    func translateMonth(month: Int) -> String
    {
        var result: String! = nil;
        if (month == 1) {
            result = "Janeiro";
        }
        else if (month == 2) {
            result = "Fevereiro";
        }
        else if (month == 3) {
            result = "Março";
        }
        else if (month == 4) {
            result = "Abril";
        }
        else if (month == 5) {
            result = "Maio";
        }
        else if (month == 6) {
            result = "Junho";
        }
        else if (month == 7) {
            result = "Julho";
        }
        else if (month == 8) {
            result = "Agosto";
        }
        else if (month == 9) {
            result = "Setembro";
        }
        else if (month == 10) {
            result = "Outubro";
        }
        else if (month == 11) {
            result = "Novembro";
        }
        else if (month == 12) {
            result = "Dezembro";
        }
        else {
            NSException(name: "translateMonthError", reason: "Invalid month int value: \(month)", userInfo: nil).raise()
        }
        return result;
    }

}