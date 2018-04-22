//
//  MapViewController.swift
//  GotEggplant
//
//  Created by student on 4/22/18.
//  Copyright © 2018 San Jose State University. All rights reserved.
//

import UIKit
<<<<<<< HEAD
=======

//class ViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//
//}

import CloudKit

class ViewController: UIViewController {
    
import UIKit
>>>>>>> 7cb1c6b90f51e8a0de7df41ec1ce78bce6b63002
import MapKit

class ViewController : UIViewController {
    // MapView
    @IBOutlet weak var mapView: MKMapView!
    
    // User Location Authortization
    let locationManager = CLLocationManager()
    func checkLocationAuthorizationStatus()
    {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse
        {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    // Create a CLLocationManager to track app's authortization status for accessing the user's location
    //!< Check Shows-User-Location checkbox from map view if authorized
    //!< Else request access from the user
    override func viewDidAppear (_ animated: Bool)
    {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        // Assigns initial location at San Jose State
        let initLocation = CLLocation(latitude: 37.3352, longitude: -121.8811)
        let radiusOfRegion: CLLocationDistance = 1000 //constant
        // helper method
        func centerMapOnLocation(location: CLLocation)
        {
            /* Center Map On Location objects
             *
             * location         arg is the center point
             * regionOfRadius   distance that the north-south and east-west spans
             *                  initialized to 1000 meters > 1/2 mile
             *                  Works well for plotting public artwork data in the JSON file
             * setRegion        instructs mapView to display region
             */
            let coordinateOfRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, radiusOfRegion, radiusOfRegion)
            mapView.setRegion(coordinateOfRegion, animated: true)
        }
        // Helper method
        centerMapOnLocation(location: initLocation)
        
        mapView.delegate = self
        
        // Artwork displayed on map
        let artWork = Artwork(title: "Black Power Statue", locationName: "San Jose State University", discipline: "Statue", coordinate: CLLocationCoordinate2D(latitude: 37.335484539286455, longitude: -121.88255488872528))
        mapView.addAnnotation(artWork) // Array of annotations added to map view
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
<<<<<<< HEAD
=======
    
    // Camera Controller
    @IBOutlet weak var label: UILabel!
    
    let database = CKContainer.default().privateCloudDatabase
    let cameraController = CameraController()
    
    var counter: Int = 0
    
    var notes = [CKRecord]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func addToDatabase(){
        counter += 1
        let record = CKRecord(recordType: "Note")
        record.setValue(String(counter), forKeyPath: "content")
        database.save(record) { (record, error) in
            guard error == nil else { return }
            print("saved successfully")
        }
    }
    
    @IBAction func queryDatabase(){
        let query = CKQuery(recordType: "Note", predicate: NSPredicate(value: true))
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard error == nil else { return }
            self.notes = records!
            for record in self.notes{
                print(record.value(forKey: "content"))
            }
        }
    }
    
    @IBAction func removeFromDatabase(){
        let lastNote = self.notes.last
        guard lastNote != nil else { return }
        database.delete(withRecordID: (lastNote?.recordID)!) { (_, error) in
            guard error == nil else { return }
            let lastIndex = self.notes.count - 1
            self.notes.remove(at: lastIndex)
            print("deleted successfully.")
        }
    }
    
    @IBAction func button(_ sender: UIButton) {
        label.text = "Testing UIkit"
    }
    
    @IBAction func accessCamera(_ sender: UIButton) {
        configureCameraController()
    }
    
    
    func configureCameraController() {
        cameraController.prepare {(error) in
            if let error = error {
                print(error)
            }
        }
        try? self.cameraController.displayPreview(on: self.view)
    }
>>>>>>> 7cb1c6b90f51e8a0de7df41ec1ce78bce6b63002
}

extension ViewController: MKMapViewDelegate
    // Called for every annotation added to the map to return the view for each annotation
{
    // Method grabs the Artwork obj referenced and launches the Maps app through MKMapItem through openInMaps
    // Every time the user taps a map annotation marker, the callout shows an info button through mapView(_ ..)
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl)
    {
        let location = view.annotation as! Artwork
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        // App might use other annotations so this checks it is an Artwork object
        guard let annotation = annotation as? Artwork else { return nil }
        // Creates view as MKMarker
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // Map view reuses annotation views that are no longer visible, checks if view is available before creating a new one
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // Creates new MKMarker obj, if a view could not be dequeued
            // Determines view of the callout from subtitle properties of Artwork class
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
}
