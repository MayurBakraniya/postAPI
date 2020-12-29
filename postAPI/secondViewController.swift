//
//  secondViewController.swift
//  postAPI
//
//  Created by MAC on 22/12/20.
//

import UIKit


class secondViewController: UIViewController {
    
    

    @IBOutlet weak var lbIid: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblbody: UILabel!
    
    var uid:String = ""
    var utitle:String = ""
    var ubody:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbIid.text = uid
        lblTitle.text! = utitle
        lblbody.text! = ubody
        
        
        // Do any additional setup after loading the view.
    }

}
