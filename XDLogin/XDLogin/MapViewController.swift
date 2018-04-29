//
//  MapViewController.swift
//  GotEggplant
//
//  Created by student on 4/22/18.
//  Copyright © 2018 San Jose State University. All rights reserved.
//

import UIKit
import MapKit

class MapViewController : UIViewController, MKMapViewDelegate {
    // MapView
    @IBOutlet weak var mapView: MKMapView!
    private var searchController: UISearchController!
    private var localSearchRequest: MKLocalSearchRequest!
    private var localSearch: MKLocalSearch!
    private var localSearchResponse: MKLocalSearchResponse!
    
    // Implement Search Button Action
    func searchButtonAction(button: UIBarButtonItem) {
        if searchController == nil {
            searchController = UISearchController(searchResultsController: nil)
        }
        searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.delegate = self as! UISearchBarDelegate
        //        presentedViewController(searchController, dismiss(animated: true, completion: nil))
    }
    
    // Clicking the Search Bar from UISearchBarDelegate
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        if self.mapView.annotations.count != 0 {
            //            annotation = self.mapView.annotations[0]
            //            self.mapView.removeAnnotation(annotation)
        }
        localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = searchBar.text
        localSearch = MKLocalSearch(request: localSearchRequest)
        localSearch.start { [weak self] (locationSearchResponse, error) -> Void in
            if self?.localSearchResponse == nil {
                let alert = UIAlertView(title: nil, message: "Invalid location", delegate: self, cancelButtonTitle: "Try another location")
                alert.show()
                return
            }
            let pointAnnotation = MKPointAnnotation.self
            //            pointAnnotation.title = searchBar.text
            //            pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude: localSearchResponse!.boundingRegion.center.longitude)
            //            let pinAnnotationView = MKPinAnnotationView(annotation: pointAnnotation, reuseIdentifier: nil)
            //            self!.mapView.centerCoordinate = pointAnnotation.coordinate
            //            self!.mapView.addAnnotation(pinAnnotationView.annotation!)
        }
    }
    
    // User Location Authorization
    var locationManager = CLLocationManager()
    
    func currentLocBtnAction(sender: UIBarButtonItem) {
        if (CLLocationManager.locationServicesEnabled()) {
            if locationManager == nil {
                locationManager = CLLocationManager()
            }
            locationManager.requestWhenInUseAuthorization()
            locationManager.delegate = self as! CLLocationManagerDelegate
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    // Implement didUpdateLocations from CLLocationManagerDelegate to add location to mapView
    func locationManager(manager: CLLocationManager, didUpdateLocations loc: [CLLocation]) {
        let location = loc.last
        // allow for naming convention
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapView.setRegion(region, animated: true)
        if self.mapView.annotations.count != 0 {
            //            annotations = self.mapView.annotations[0]
            //            self.mapView.removeAnnotation(annotations)
            print("No annotations")
        }
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = location!.coordinate
        pointAnnotation.title = ""
        mapView.addAnnotation(pointAnnotation)
    }
    
    // Create a CLLocationManager to track app's authortization status for accessing the user's location
    //!< Check Shows-User-Location checkbox from map view if authorized
    //!< Else request access from the user
    override func viewDidAppear (_ animated: Bool)
    {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        // might throw SIGBRT, selects the currentLocBtnAction func
        let currentLocation = UIBarButtonItem(title: "Current Location", style: UIBarButtonItemStyle.plain, target: self, action: Selector(("currentLocBtnAction:")))
        self.navigationItem.leftBarButtonItem = currentLocation
        mapView.delegate = self
        definesPresentationContext = true
        
        // Search Navigation Bar
        let searchButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: "searchButtonAction:")
        self.navigationItem.rightBarButtonItem = searchButton
        
        // Assigns initial location at San Jose State
        let initLocation = CLLocation(latitude: 37.338316, longitude: -121.884173)
        //constant
        let radiusOfRegion: CLLocationDistance = 1000
        
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
        let artWork = Artwork(title: "Grocery Outlet", locationName: "272 E Santa Clara St San Jose, CA 95113", discipline: "Grocery", coordinate: CLLocationCoordinate2D(latitude: 37.338316, longitude: -121.884173))
        mapView.addAnnotation(artWork) // Array of annotations added to map view
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MapViewController
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

