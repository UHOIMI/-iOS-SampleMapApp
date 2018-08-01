//
//  MapViewController.swift
//  SampleMapApp
//
//  Created by 猪岡勝生 on 2018/07/20.
//  Copyright © 2018年 Swift-Biginners. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    
    var spotDataList : [SpotData] = []
    var markerList : [GMSMarker] =  []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.view = mapView
        
        for sd in spotDataList{
            markerList.append(GMSMarker())
            markerList[markerList.count - 1].position = CLLocationCoordinate2D(latitude: sd.latitude, longitude: sd.longitude)
            markerList[markerList.count - 1].title = sd.name
            markerList[markerList.count - 1].map = mapView
        }
        
        mapView.camera = GMSCameraPosition.camera(withLatitude: spotDataList[0].latitude, longitude: spotDataList[0].longitude, zoom: 15.0)
        
        // Creates a marker in the center of the map.
        /*let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView*/

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
