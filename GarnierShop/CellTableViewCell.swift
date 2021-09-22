//
//  CellTableViewCell.swift
//  GarnierShop
//
//  Created by Anand Baid on 8/20/21.
//

import UIKit

class CellTableViewCell: UITableViewCell, UINavigationControllerDelegate {
    
    var imgdata = [Images]()
    var categorydata = [Categories]()
    var arrdata = [jsonstruct]()
    
    var detailInfo: jsonstruct?
    var cartArray = [CartStruct]()
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSHDesc: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet var buyBtn: UIButton!
    
    @IBOutlet weak var lblimg: UILabel!
    @IBOutlet weak var lblhrt: UILabel!
    @IBOutlet weak var lblbuy: UILabel!
    @IBOutlet var cellContentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblimg.layer.cornerRadius = 15
        lblimg.clipsToBounds = true
        
        lblhrt.layer.cornerRadius = lblhrt.frame.width / 2
        lblhrt.layer.cornerRadius = lblhrt.frame.height / 2
        lblhrt.layer.masksToBounds = true
        
        lblbuy.layer.cornerRadius = 15
        lblbuy.clipsToBounds = true
        
        img.layer.cornerRadius = 15
        img.clipsToBounds = true
        
        //cellContentView.layer.cornerRadius = 15
        //cellContentView.clipsToBounds = true
        
        CellTableViewCell().layer.cornerRadius = 100
        CellTableViewCell().clipsToBounds = true
    }
    
    @IBAction func buyBtnTapped(_ sender: Any) {
        showAction()
    }
    
    func showAction() {
        if let vc = self.next(ofType: UIViewController.self) {
            let actionsheet = UIAlertController(title: "Select Payment Method", message: nil, preferredStyle: .actionSheet)

            actionsheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            let action1 = UIAlertAction(title: "Paypal", style: .default, handler: { action1 in print("tapped Dismiss")
            })
            let image1 = UIImage(named: "Image 18.png")
            action1.setValue(image1?.withRenderingMode(.alwaysOriginal), forKey: "image")
            actionsheet.addAction(action1)
            
            let action2 = UIAlertAction(title: "Credit or Debit Card", style: .default, handler: { action2 in //print("tapped Dismiss")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let paymentVC = storyboard.instantiateViewController(withIdentifier: "PaymentViewController") as! PaymentViewController
                paymentVC.receivedString = self.lblPrice.text!
                vc.navigationController?.pushViewController(paymentVC, animated: true)
            })
            let image2 = UIImage(named: "Image 20.png")
            action2.setValue(image2?.withRenderingMode(.alwaysOriginal), forKey: "image")
            actionsheet.addAction(action2)
            
            let action3 = UIAlertAction(title: "Apple Pay", style: .default, handler: { action3 in print("tapped Dismiss")
            })
            let image3 = UIImage(named: "Image 19.png")
            action3.setValue(image3?.withRenderingMode(.alwaysOriginal), forKey: "image")
            actionsheet.addAction(action3)
         
            actionsheet.view.backgroundColor = .white
            
            actionsheet.view.layer.cornerRadius = 15
            actionsheet.view.clipsToBounds = true
            
            vc.present(actionsheet, animated: true, completion: nil)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension UIResponder {
    func next<T:UIResponder>(ofType: T.Type) -> T? {
        let r = self.next
        if let r = r as? T ?? r?.next(ofType: T.self) {
            return r
        } else {
            return nil
        }
    }
}
