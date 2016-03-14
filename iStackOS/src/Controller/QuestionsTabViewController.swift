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

            // get tag filter using parentViewController... Each view controller is associated to one tag filter value...
            if let restorationIdentifier = self.parentViewController?.restorationIdentifier, let tagFilter = StackOverflowTag(rawValue: restorationIdentifier) {
                
                // disable refresh button to avoid exec more than one refresh process...
                btnRefresh.enabled = false
                
                DataSource.sharedInstance().loadDataWithTag(tagFilter,  successBlock: {
                    questions in
                    
                    // update questions internal list and refresh data
                    self._questions = questions
                    self.tableView.reloadData()
                    
                    // enabled refresh button again...
                    self.btnRefresh.enabled = true
                    },
                    failureBlock: {
                        errro in
                        
                        // TODO: check error type to handle it accordlly
                        self._questions = []
                        
                        // enabled refresh button again...
                        self.btnRefresh.enabled = true
                })
            }
            else {
                let tagValue = self.parentViewController?.restorationIdentifier
                showSimpleAlertWithTitle("Opps!", message: String.localizedStringWithFormat(NSLocalizedString("[Invalid Tag]", comment: ""), tagValue!), viewController: self)
            }
        }
        else {
            showSimpleAlertWithTitle("Opps!", message: NSLocalizedString("[Internet Connection Not Found]", comment: ""), viewController: self)
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