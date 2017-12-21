//
//  HomeViewController.swift
//  GetBlushh
//
//  Created by Arvind Mehta on 15/12/17.
//  Copyright © 2017 Arvind Mehta. All rights reserved.
//

import UIKit
import CoreLocation
import ImageSlideshow
import Alamofire
import GooglePlacesSearchController


class HomeViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate{
    @IBOutlet weak var _searcAddressController: UILabel!
    
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "HomePackageCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! HomePackageCell
        
        return cell
    }
    
   
     @IBOutlet  var _imageSlider: ImageSlideshow!
    @IBOutlet weak var viewBlushServices: UIView!
    
    @IBOutlet weak var _lblimageBlushBeauty: UILabel!
   
    @IBOutlet weak var blushMore: UIImageView!
    
    @IBOutlet weak var blushmessage: UIImageView!
    @IBOutlet weak var _blishPartyICon: UIImageView!
    @IBOutlet weak var _blushNailBeauty: UIImageView!
    @IBOutlet weak var _blushHairBeauty: UIImageView!
    @IBOutlet weak var _imageBlushBeauty: UIImageView!
    @IBOutlet weak var _scrollView: UIScrollView!
    @IBOutlet weak var _popView: UIView!
    @IBOutlet weak var _topView: UIView!
    @IBOutlet weak var _btUpdateLocation: UIButton!
    @IBOutlet weak var _viewDashbord: UIView!
    @IBOutlet weak var _viewLocation: UIView!
    @IBOutlet weak var _viewCurrentLocation: UIView!
    @IBOutlet weak var _pakageTable: UITableView!
    let locationManager = CLLocationManager()
    var lat : String = ""
    var lng : String = ""
    private var city:String = ""
    private var state:String = ""
    
      let GoogleMapsAPIServerKey = "AIzaSyDg2tlPcoqxx2Q2rfjhsAKS-9j0n3JA_a4"
    
    @IBOutlet weak var servicePackageSegmented: UISegmentedControl!
    override func viewDidLoad() {
       super.viewDidLoad()
        initializeSlider()
        _popView.isHidden = true
        _viewDashbord.isHidden = false
        _viewLocation.isHidden = true
        _pakageTable.isHidden = true
        _pakageTable.dataSource = self
        _pakageTable.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        let tap = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.tapFunction))
        _searcAddressController.isUserInteractionEnabled = true
        _searcAddressController.addGestureRecognizer(tap)
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        let controller = GooglePlacesSearchController(
            apiKey: GoogleMapsAPIServerKey,
            placeType: PlaceType.address
        )
        controller.didSelectGooglePlace { (place) -> Void in
            controller.isActive = false
        }
        present(controller, animated: true, completion: nil)
    }
    
    func initializeSlider()  {
        let alamofireSource = [AlamofireSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080")!, AlamofireSource(urlString: "https://images.unsplash.com/photo-1447746249824-4be4e1b76d66?w=1080")!, AlamofireSource(urlString: "https://images.unsplash.com/photo-1463595373836-6e0b0a8ee322?w=1080")!]
        _imageSlider.backgroundColor = UIColor.white
        _imageSlider.slideshowInterval = 5.0
        _imageSlider.pageControlPosition = PageControlPosition.underScrollView
        _imageSlider.pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        _imageSlider.pageControl.pageIndicatorTintColor = UIColor.black
        _imageSlider.contentScaleMode = UIViewContentMode.scaleAspectFill
        
        // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
        _imageSlider.activityIndicator = DefaultActivityIndicator()
        _imageSlider.currentPageChanged = { page in
            print("current page:", page)
        }
        
        // can be used with other sample sources as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource` or `kingfisherSource`
        _imageSlider.setImageInputs(alamofireSource)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.didTap))
        _imageSlider.addGestureRecognizer(recognizer)
    }
    
    @objc func didTap() {
        let fullScreenController = _imageSlider.presentFullScreenController(from: self)
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last! as CLLocation
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let lat: Double = center.latitude
        let lng: Double = center.longitude
        self.lat = String(format:"%.3f", lat)
        self.lng = String(format:"%.3f", lng)
        getAddressFromLatLon(pdblLatitude: self.lat,withLongitude: self.lng)
       
      
        
        
    }
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        print(error)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        renderUIView(radius: 5.0,borderWidth: 1.0, borderColor: UIColor.black, view: _viewLocation)
         renderUIView(radius: 5.0,borderWidth: 1.0, borderColor: UIColor.init(red: 245.0, green: 246.0, blue: 246.0, alpha: 1.0), view: _viewCurrentLocation)
         renderUIView(radius: 14.0,borderWidth: 1.0, borderColor: UIColor.black, view: servicePackageSegmented)
         renderUIView(radius: 15.0,borderWidth: 1.0, borderColor: UIColor.black, view: _btUpdateLocation)
        self.servicePackageSegmented.layer.masksToBounds = true
        shodowOnUIObject(object: _topView)
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        _scrollView.contentSize = CGSize.init(width: self.view.frame.width, height: 550)
    }
    

    
    @IBAction func btnMoreTapped(_ sender: Any) {
      
        
    }
    @IBAction func btnBlushMassageTapped(_ sender: Any) {
    }
    @IBAction func btnBlushPartyTapped(_ sender: Any) {
    }
    @IBAction func btnBlushNailsTapped(_ sender: Any) {
    }
    @IBAction func btnBlushHairTapped(_ sender: Any) {
    }
    @IBAction func btnBlushBeautyTapped(_ sender: Any) {
     //   var image: UIImage? = UIImage(named:"blush_beauty_pink")?.withRenderingMode(.alwaysOriginal)
        _imageBlushBeauty.tintColor = UIColor.init(red: 209.0, green: 48.0, blue: 121.0, alpha: 1.0)
     //   _lblimageBlushBeauty.textColor = UIColor.init(red: 209.0, green: 48.0, blue: 121.0, alpha: 1.0)
       // _imageBlushBeauty.image = image
    }
    
    @IBAction func homeSagment(_ sender: Any) {
        
        if(servicePackageSegmented.selectedSegmentIndex == 0)
        {
            viewBlushServices.isHidden = false
            _pakageTable.isHidden = true
        }else{
            viewBlushServices.isHidden = true
            _pakageTable.isHidden = false
        }
    }
    
    @IBAction func onCloseClick(_ sender: Any) {
        _popView.isHidden = true
    }
    
    func getPackages() {
        
        let parameter = [
            "state":self.state,
            "city": self.city,
            "latitude": self.lat,
            "longitude": self.lng
        ]
        print(parameter)
        executePOST(view: self.view, path: Constants.LIVEURL+"serviceAndPackagesonLoactionApi", parameter: parameter){ response in
            print(response)
        }
        
    }
    
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]
                    print(pm)
                    print(pm.country)
                    print(pm.locality)
                    print(pm.subLocality)
                    print(pm.thoroughfare)
                    print(pm.postalCode)
                    print(pm.subThoroughfare)
                    var addressString : String = ""
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                        self.city = pm.locality!
                    }
                    if pm.administrativeArea != nil {
                        addressString = addressString + pm.administrativeArea! + ", "
                         self.state = pm.administrativeArea!
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    
                    
                    print(addressString)
                }
                self.getPackages()
        })
        
    }

}
