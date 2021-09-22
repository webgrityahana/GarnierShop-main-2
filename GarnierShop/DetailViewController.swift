//
//  DetailViewController.swift
//  GarnierShop
//
//  Created by Anand Baid on 8/21/21.
//

import UIKit

struct CartStruct : Codable {
    var cartItems: jsonstruct
    var cartQuantity: Int
}

class DetailViewController: UIViewController {
    
    var arrdata = [jsonstruct]()
    var categorydata = [Categories]()
    var imgdata = [Images]()
    
    var detailInfo: jsonstruct?
    var cartArray = [CartStruct]()

    @IBOutlet weak var prodName: UILabel!
    @IBOutlet weak var probName2: UILabel!
    @IBOutlet weak var prodSHDesc: UILabel!
    @IBOutlet weak var prodDesc: UILabel!
    @IBOutlet weak var prodPrice: UILabel!
    @IBOutlet weak var probImage: UIImageView!
    @IBOutlet var container: UIView!
    @IBOutlet var ratingView: UIView!
    @IBOutlet var addToCartbtn: UIView!
    @IBOutlet var addingTOCart: UIButton!
    @IBOutlet var one: UIView!
    @IBOutlet var two: UIView!
    @IBOutlet var three: UIView!
    @IBOutlet var imgone: UIImageView!
    @IBOutlet var imgtwo: UIImageView!
    @IBOutlet var imgthree: UIImageView!
    @IBOutlet var cart4View: UIView!
    @IBOutlet var cartCount: UILabel!
    
    var Image = UIImage()
    var Name = ""
    var Name2 = ""
    var SH_desc = ""
    var Desc = ""
    var Price = ""
    var Img1 = UIImage()
    var Img2 = UIImage()
    var Img3 = UIImage()
    
    /*var callback : ((Int)->())?
    var counter1 = 0 {
        didSet {
            cartCount.text = "\(counter1)"
        }
    }*/

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let value = UserDefaults.standard.string(forKey: "CountAddedProducts")
        
        if value == nil {
            cartCount.text = "0"
        }
        else {
            cartCount.text = value
        }

        probImage.layer.cornerRadius = 15
        probImage.clipsToBounds = true
        
        container.layer.cornerRadius = 50
        container.clipsToBounds = true
        
        ratingView.layer.cornerRadius = 20
        ratingView.clipsToBounds = true
        ratingView.layer.borderWidth = 1
        ratingView.layer.borderColor = UIColor.lightGray.cgColor
        
        addToCartbtn.layer.cornerRadius = 20
        addToCartbtn.clipsToBounds = true
        
        one.layer.cornerRadius = 15
        one.clipsToBounds = true
        one.layer.borderWidth = 1
        one.layer.borderColor = UIColor.lightGray.cgColor
        
        two.layer.cornerRadius = 15
        two.clipsToBounds = true
        two.layer.borderWidth = 1
        two.layer.borderColor = UIColor.lightGray.cgColor
        
        three.layer.cornerRadius = 15
        three.clipsToBounds = true
        three.layer.borderWidth = 1
        three.layer.borderColor = UIColor.lightGray.cgColor
        
        cart4View.layer.cornerRadius = cart4View.frame.width / 2
        cart4View.layer.cornerRadius = cart4View.frame.height / 2
        cart4View.layer.masksToBounds = true
        
        self.updateUI()
    }

    override func viewWillAppear(_ animated: Bool) {
               if let info = detailInfo {
                   let buttonTItle = (self.checkCartData(cartInfo: info) ? "Go to Cart"  : "Add to Cart")
                   addingTOCart.setTitle(buttonTItle, for: .normal)
               }
           }
    
    func updateUI(){
        if let detailInfo = detailInfo {
            if let urlString = detailInfo.images.first?.src {
                self.probImage.downloadImage(from: urlString)
            }
            
            prodName.text = detailInfo.name
            probName2.text = detailInfo.name
            prodSHDesc.text = detailInfo.categories.first!.type
            prodDesc.text = detailInfo.description
            prodPrice.text = detailInfo.price
            
            let imagesArray = detailInfo.images
                        
            if imagesArray.count > 0{
                self.probImage.downloadImage(from: detailInfo.images[0].src)
                self.imgone.downloadImage(from: detailInfo.images[0].src)
            }
            
            if imagesArray.count > 1 {
                self.imgtwo.downloadImage(from: detailInfo.images[1].src)
            }
            
            if imagesArray.count > 2 {
                self.imgthree.downloadImage(from: detailInfo.images[2].src)
            }
        }
    }
    
    @IBAction func firstImgBtnTapped(_ sender: Any) {
        if let imageURL = detailInfo?.images[0].src {
            probImage.downloadImage(from: imageURL)
            
            one.layer.borderWidth = 1
            one.layer.borderColor = UIColor.orange.cgColor
            one.backgroundColor = .systemGray5
            
            two.layer.borderWidth = 1
            two.layer.borderColor = UIColor.lightGray.cgColor
            two.backgroundColor = .clear
            
            three.layer.borderWidth = 1
            three.layer.borderColor = UIColor.lightGray.cgColor
            three.backgroundColor = .clear
        }
    }
    
    @IBAction func secondImgBtnTapped(_ sender: Any) {
        if let imageURL = detailInfo?.images[1].src {
            probImage.downloadImage(from: imageURL)
            
            one.layer.borderWidth = 1
            one.layer.borderColor = UIColor.lightGray.cgColor
            one.backgroundColor = .clear
            
            two.layer.borderWidth = 1
            two.layer.borderColor = UIColor.orange.cgColor
            two.backgroundColor = .systemGray5
            
            three.layer.borderWidth = 1
            three.layer.borderColor = UIColor.lightGray.cgColor
            three.backgroundColor = .clear
        }
    }
    
    @IBAction func thirdImgBtnTapped(_ sender: Any) {
        if let imageURL = detailInfo?.images[2].src {
            probImage.downloadImage(from: imageURL)
            
            one.layer.borderWidth = 1
            one.layer.borderColor = UIColor.lightGray.cgColor
            one.backgroundColor = .clear
            
            two.layer.borderWidth = 1
            two.layer.borderColor = UIColor.lightGray.cgColor
            two.backgroundColor = .clear
            
            three.layer.borderWidth = 1
            three.layer.borderColor = UIColor.orange.cgColor
            three.backgroundColor = .systemGray5
        }
    }
    
    @IBAction func cartTappedToNavigate(_ sender: Any) {
        let cart = self.storyboard?.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController
        self.navigationController?.pushViewController(cart!, animated: true)
    }
    
    @IBAction func addToCartbtnTapped(_ sender: Any) {
        /*if let info = detailInfo {
            let cartData = CartStruct(cartItems: info, cartQuantity: 1)
            self.saveCart(data: cartData)
            showAlert()
            (sender as AnyObject).setTitle("Go to Cart", for: .normal)
            addToCartbtn.isUserInteractionEnabled = false
            //addToCartbtn.isHidden = true
            //goTOCartbtn.isHidden = false
            //goTOCartbtn.isUserInteractionEnabled = true
        }*/
        /*if !Clicked {
            if let info = detailInfo {
                let cartData = CartStruct(cartItems: info, cartQuantity: 1)
                self.saveCart(data: cartData)
                showAlert()
                addingTOCart.setTitle("Go to Cart", for: .normal)
                UserDefaults.standard.set("Go to Cart", forKey: "btn")
                print("Clicked")
                Clicked = true
                return
            }
        }
        if Clicked {
            print("Perform Action")
            let cart = self.storyboard?.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController
            self.navigationController?.pushViewController(cart!, animated: true)
        }*/
        if let info = detailInfo {
            if checkCartData(cartInfo: info) {
                let cart = self.storyboard?.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController
                self.navigationController?.pushViewController(cart!, animated: true)
            } else {
                let cartData = CartStruct(cartItems: info, cartQuantity: 1)
                self.saveCart(data: cartData)
                showAlert()
                (sender as AnyObject).setTitle("Go to Cart", for: .normal)
            }
        }
    }
    
    func checkCartData(cartInfo: jsonstruct) -> Bool {
        guard let cart = self.getCartData() else { return false }
        return (cart.contains(where: { $0.cartItems.name == cartInfo.name }) ? true : false )
    }
    
    func getCartData() -> [CartStruct]? {
        let defaults = UserDefaults.standard
        var tempCart: [CartStruct]?
        if let cdata = defaults.data(forKey: "cartt") {
            tempCart = try! PropertyListDecoder().decode([CartStruct].self, from: cdata)
        }
        return tempCart
    }
    
    func saveCart(data: CartStruct) {
        let defaults = UserDefaults.standard
        if let cdata = defaults.data(forKey: "cartt") {
            var cartArray = try! PropertyListDecoder().decode([CartStruct].self, from: cdata)
            cartArray.append(data)
            cartCount.text = "\(cartArray.count)"
            if let updatedCart = try? PropertyListEncoder().encode(cartArray) {
                UserDefaults.standard.set(updatedCart, forKey: "cartt")
            }
            UserDefaults.standard.set(cartCount.text, forKey: "CountAddedProducts")
        } else {
            if let updatedCart = try? PropertyListEncoder().encode([data]) {
                UserDefaults.standard.set(updatedCart, forKey: "cartt")
            }
        }
    }
    
    func updateCartItems(name: String) -> [CartStruct] {
         guard var cartItems = self.getCartData() else { return [] }
         cartItems = cartItems.filter({ $0.cartItems.name != name })
         if let updatedCart = try? PropertyListEncoder().encode(cartItems) {
             UserDefaults.standard.set(updatedCart, forKey: "cartt")
         }
         UserDefaults.standard.set(cartItems.count, forKey: "CountAddedProducts")
         return cartItems
       }

    func showAlert() {
        let alert = UIAlertController(title: "Item Added to Cart", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
