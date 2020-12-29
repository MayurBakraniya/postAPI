//
//  ViewController.swift
//  postAPI
//
//  Created by MAC on 22/12/20.
//

import UIKit



class ViewController: UIViewController {

    @IBOutlet weak var txtId: UITextField!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtBody: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func postDataTapped(_ sender: UIButton) {
   
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detail:secondViewController = storyboard.instantiateViewController(withIdentifier: "secondViewController") as! secondViewController
        detail.uid = txtId.text!
        detail.utitle = txtTitle.text!
        detail.ubody = txtBody.text!
        self.navigationController?.pushViewController(detail, animated: true )
        
        postButtonSetup()
    }
    
    func postButtonSetup(){
        guard let uId = self.txtId.text else { return }
        guard let title = self.txtTitle.text else { return }
        guard let body = self.txtBody.text else { return }
   
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        let perameters: [String : Any] = [
            "userId": uId,
            "title": title,
            "body": body
        ]
        
        request.httpBody = perameters.percentEscaped().data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data else {
                
                if error == nil{
                    print("\(error?.localizedDescription) Unknown error")
                }
                return
            }
            
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            }catch let error{
                print(error.localizedDescription)
            }
            
            
        }.resume()
    }
    
}


extension Dictionary {
    func percentEscaped() -> String {
        return map { (key, value) in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}

