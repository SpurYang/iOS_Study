//
//  EventsDeatilViewController.swift
//  RioOlympics2016
//
//  Created by SpurYang on 15/11/27.
//  Copyright © 2015年 SpurYang. All rights reserved.
//

import UIKit

class EventsDeatilViewController: UIViewController {

    var event: Events!
    
    
    //---------iPhone------------
    @IBOutlet weak var imgEventIcon: UIImageView!
    @IBOutlet weak var lbEventName: UILabel!
    @IBOutlet weak var tvKeyInfo: UITextView!
    @IBOutlet weak var tvBasicInfo: UITextView!
    @IBOutlet weak var tvOlympicInfo: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    //---------iPad--------------
    @IBOutlet weak var imgEventIcon2: UIImageView!
    @IBOutlet weak var lbEventName2: UILabel!
    @IBOutlet weak var tvKeyInfo2: UITextView!
    @IBOutlet weak var tvBasicsInfo2: UITextView!
    @IBOutlet weak var tvOlympicInfo2: UITextView!
    @IBOutlet weak var scrollView2: UIScrollView!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgEventIcon.image = UIImage(named: event.EventIcon! as String)
        lbEventName.text = event.EventName! as String
        tvKeyInfo.text = event.KeyInfo! as String
        tvBasicInfo.text = event.BasicsInfo! as String
        tvOlympicInfo.text = event.OlympicInfo! as String
        scrollView.contentSize = CGSizeMake(self.view.frame.width, 1000)
        
        
        imgEventIcon2.image = UIImage(named: event.EventIcon! as String)
        lbEventName2.text = event.EventName! as String
        tvKeyInfo2.text = event.KeyInfo! as String
        tvBasicsInfo2.text = event.BasicsInfo! as String
        tvOlympicInfo2.text = event.OlympicInfo! as String
        scrollView2.contentSize = CGSizeMake(self.view.frame.width, 1000)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
