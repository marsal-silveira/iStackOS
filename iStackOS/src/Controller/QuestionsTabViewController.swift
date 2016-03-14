//
//  QuestionsTabViewController.swift
//  iStackOS
//
//  Created by Marsal on 13/03/16.
//  Copyright © 2016 Marsal Silveira. All rights reserved.
//

import UIKit

class QuestionsTabViewController: UITableViewController {
    
    // ********************************** //
    // MARK: Properties
    // ********************************** //
    
    //! Question TableViewCell Identifier
    private let CELL_IDENTIFIER_Question = "QuestionCell"
    
    private var _questions:[Question] = []

    // ********************************** //
    // MARK: <UIViewController> Lifecycle
    // ********************************** //

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.clearsSelectionOnViewWillAppear = false
        self.title = self.parentViewController?.title
        
        //
        self.loadData()
    }
    
    // ********************************** //
    // MARK: <UITableViewDataSource>
    // ********************************** //

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return _questions.count
    }
    
    // ********************************** //
    // MARK: UITableViewDelegate
    // ********************************** //
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 110
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var result: QuestionTableViewCell
        if let cell = tableView.dequeueReusableCellWithIdentifier(CELL_IDENTIFIER_Question) as? QuestionTableViewCell {
            result = cell
        }
        else {
            result = QuestionTableViewCell()
        }
        result.configureCellWithQuestion(_questions[indexPath.row])
        
        return result
    }
    
    // ********************************** //
    // MARK: Load Data
    // ********************************** //
    
    private func loadData()
    {
        // get tag filter using parentViewController... Each view controller is associated to one tag filter value...
        if let restorationIdentifier = self.parentViewController?.restorationIdentifier, let tagFilter = StackOverflowTag(rawValue: restorationIdentifier) {
            
            DataSource.sharedInstance().loadDataWithTag(tagFilter,  successBlock: {
                questions in

                // update questions internal list and refresh data
                self._questions = questions
                self.tableView.reloadData()
                },
                failureBlock: {
                    errro in
                    
                    // TODO: check error type to handle it accordlly
                    self._questions = []
            })
        }
        else {
            let tagValue = self.parentViewController?.restorationIdentifier
            showSimpleAlertWithTitle("Opps", message: String.localizedStringWithFormat(NSLocalizedString("[Invalid Tag]", comment: ""), tagValue!), viewController: self)
        }
    }
    
    // ********************************** //
    // MARK: Navigation
    // ********************************** //

    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}