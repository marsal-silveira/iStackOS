//
//  QuestionDetailsTableViewController.swift
//  iStackOS
//
//  Created by Marsal on 15/03/16.
//  Copyright © 2016 Marsal Silveira. All rights reserved.
//

import UIKit

class QuestionDetailsTableViewController: UITableViewController
{
    // ********************************** //
    // MARK: Properties
    // ********************************** //
    
    private var _answers = [Answer]()
    
    private var _question: Question!
    var question: Question {
        get { return _question }
        set(newValue) { _question = newValue }
    }
    
    // ********************************** //
    // MARK: <UIViewController> Lifecycle
    // ********************************** //
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // update title with selected question title
        self.navigationItem.title = "\(_question.title)"
        
        self.loadData()
    }
    
    // ********************************** //
    // MARK: <UITableViewDataSource>
    // ********************************** //
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        // section 1) Details
        // section 2) Answers
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (section == 0) ? 1 : _question.answerCount
    }
    
    // ********************************** //
    // MARK: UITableViewDelegate
    // ********************************** //
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        if (indexPath.section == 0) {
            return 180
        }
        else {
            return 120
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if indexPath.section == 0 {
            return self.cellForDetails()
        }
        else {
            return self.cellForAnswerAtIndexPath(indexPath)
        }
    }
    
    private func cellForDetails() -> QuestionDetailsTableViewCell
    {
        var result: QuestionDetailsTableViewCell!
        if let cell = tableView.dequeueReusableCellWithIdentifier(CELL_IDENTIFIER_Question_Details) as? QuestionDetailsTableViewCell {
            result = cell
        }
        else {
            result = QuestionDetailsTableViewCell()
        }
        result.configureCellWithQuestion(_question)
        return result
    }
    
    private func cellForAnswerAtIndexPath(indexPath: NSIndexPath) -> AnswerTableViewCell
    {
        var result: AnswerTableViewCell!
        if let cell = tableView.dequeueReusableCellWithIdentifier(CELL_IDENTIFIER_Answer) as? AnswerTableViewCell {
            result = cell
        }
        else {
            result = AnswerTableViewCell()
        }
//        result.configureCellWithQuestion(<#T##question: Question##Question#>)(<#T##question: Question##Question#>)(_club.parties![indexPath.row])
        return result
    }

    // ********************************** //
    // MARK: @IBOutlet
    // ********************************** //
    
    @IBOutlet weak var btnRefresh: UIBarButtonItem!
    
    // ********************************** //
    // MARK: @IBAction
    // ********************************** //
    
    @IBAction func btnRefreshTap(sender: UIBarButtonItem)
    {
        self.loadData()
    }

    // ********************************** //
    // MARK: Load Data
    // ********************************** //

    private func loadData()
    {
        // only continue if device has network connection...
        if (isConnectedToNetwork()) {
            
            DataSource.sharedInstance().fetchAnswersFromQuestion(question,  successBlock: {
                answers in
                    
                // update answers internal list and refresh data
                self._answers = answers
                self.tableView.reloadData()
                },
                failureBlock: {
                    errro in
                        
                    // TODO: check error type to handle it accordlly
                    self._answers = []
            })
        }
        else {
            showSimpleAlertWithTitle("Opps!", message: NSLocalizedString("[Internet Connection Not Found]", comment: ""), viewController: self)
        }
    }
    
}