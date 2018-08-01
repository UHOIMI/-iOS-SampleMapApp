//
//  ViewController.swift
//  MapApp
//
//  Created by 石倉一平 on 2018/07/02.
//  Copyright © 2018年 Swift-Biginners. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation
import CoreMotion
import Darwin

class PinMapViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate ,  UITextFieldDelegate{
  
  var lat:Double = 0
  var lng:Double = 0
  
  var aaa = -33.868
  var bbb = 151.2086

  let top = "エラー"
  let message = "名前が入力されていません"
  let okText = "OK"
    
  var latitudeList: [Double] = []
  var longitudeList: [Double] = []
  var nameList: [String] = []
    
  var spotDataList : [SpotData] = []
  
  var locationManager: CLLocationManager!
  let motionManager = CMMotionManager()
  
  @IBOutlet weak var mapButton: UIButton!
  
  //@IBOutlet weak var latTextField: UILabel!
  //@IBOutlet weak var lngTextField: UILabel!
    
  @IBOutlet weak var nameTextField: UITextField!
    
  @IBOutlet weak var selectSpotButton: UIButton!
    
  let myFrameSize:CGSize = UIScreen.main.bounds.size
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let camera = GMSCameraPosition.camera(withLatitude: aaa,longitude:bbb, zoom:15)
    let mapView = GMSMapView.map(withFrame: CGRect(x:0,y:0,width:myFrameSize.width,height:myFrameSize.height/2),camera:camera)
    let marker = GMSMarker()

    marker.icon = UIImage(named:"thumbs-up")
    marker.map = mapView
    
    self.view.addSubview(mapView)
  }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる
        print("つうう")
        textField.resignFirstResponder()
        return true
    }
    
    /*func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる
        print("つうう")
        nameTextField.resignFirstResponder()
        return true
    }*/
  
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
      switch status {
      case .notDetermined:
        locationManager.requestWhenInUseAuthorization()
      case .restricted, .denied:
        showAlert()
        break
      case .authorizedAlways, .authorizedWhenInUse:
        break
      }
    }
  @IBAction func tappedMapButton(_ sender: Any) {
    if nameTextField.text == "" {
        let alert = UIAlertController(title: top, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okayButton = UIAlertAction(title: okText, style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(okayButton)
        present(alert, animated: true, completion: nil)
        return
    }
    if CLLocationManager.locationServicesEnabled() {
      locationManager = CLLocationManager()
      locationManager.delegate = self as CLLocationManagerDelegate
      locationManager.startUpdatingLocation()
    }
  }
  
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      guard let newLocation = locations.last,
        CLLocationCoordinate2DIsValid(newLocation.coordinate) else {
          print("Error")
          return
      }
      
      let latitude:Double = atof("".appendingFormat("%.6f", newLocation.coordinate.latitude))
      let longitude:Double = atof("".appendingFormat("%.6f", newLocation.coordinate.longitude))
        
      latitudeList.append(newLocation.coordinate.latitude)
      longitudeList.append(newLocation.coordinate.longitude)
      nameList.append(nameTextField.text!)
        
      var spotData : SpotData =
        SpotData(la: newLocation.coordinate.latitude,lo: newLocation.coordinate.longitude,na: nameTextField.text!)
        
      spotDataList.append(spotData)
      
      //self.latTextField.text = String("\(latitude)")
      lat = newLocation.coordinate.latitude
      //self.lngTextField.text = String("\(longitude)")
      lng = newLocation.coordinate.longitude
      
      let camera = GMSCameraPosition.camera(withLatitude: latitude,longitude:longitude, zoom:15)
      let mapView = GMSMapView.map(withFrame: CGRect(x:0,y:0,width:myFrameSize.width,height:myFrameSize.height/2),camera:camera)
      self.view.addSubview(mapView)
      
      let marker: GMSMarker = GMSMarker()

      marker.position = camera.target
      
      marker.snippet = "Hello World"

      marker.map = mapView
      if CLLocationManager.locationServicesEnabled() {
        locationManager.stopUpdatingLocation()
      }
      
    }
  func showAlert() {
    let alert = UIAlertController(title: "GPSがオフになっています", message: "設定を押して位置情報を許可してください", preferredStyle: UIAlertControllerStyle.alert)
    let okAction = UIAlertAction(title: "設定", style: UIAlertActionStyle.default){(action: UIAlertAction) in
      let url = NSURL(string: UIApplicationOpenSettingsURLString)!
      UIApplication.shared.openURL(url as URL)
    }
    let cancelButton = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel, handler: nil)
    alert.addAction(cancelButton)
    alert.addAction(okAction)
    self.present(alert, animated: true, completion: nil)
  }
    
    
    
    @IBAction func tappedSelectSpotButton(_ sender: Any) {
        goToSelectSpot()
    }
    
    func goToSelectSpot(){
        self.performSegue(withIdentifier: "goSelectSpot", sender:spotDataList)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextViewController = segue.destination as! SelectSpotViewController
        nextViewController.spotDataList = sender as! [SpotData]
    }
    
}
  



