//
//  Utils.swift
//  iStackOS
//
//  Created by Marsal on 13/03/16.
//  Copyright © 2016 Marsal Silveira. All rights reserved.
//

import UIKit

func showSimpleAlertWithTitle(title: String!, message: String, viewController: UIViewController)
{
    let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    let action = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
    alert.addAction(action)
    viewController.presentViewController(alert, animated: true, completion: nil)
}

//enum NoImageSingleton
//{
//    case noImage = UIImage(named: "no-image")
//}