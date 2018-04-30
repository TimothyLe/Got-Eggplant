//
//  MapViewController.swift
//  GotEggplant
//
//  Created by student on 4/22/18.
//  Copyright © 2018 San Jose State University. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController : UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    /**
     MapView
     - note: Set to private for location manager, map view, and search bar
     */
    @IBOutlet weak var mapView: MKMapView!
    private var searchController: UISearchController!
    private var localSearchRequest: MKLocalSearchRequest!
    private var localSearch: MKLocalSearch!
    private var localSearchResponse: MKLocalSearchResponse!
    // disciplines for categorizing the stores
    let groceryDiscipline = "Grocery"
    let liquorStoreDiscipline = "Liquor Store"
    let generalDiscipline = "General"
    let convenienceDiscipline = "Convenience"
    
    /**
     Searches through Annotation arrays for locations
     - note: Used for finding the specified locations from users
     
     - parameter : button
     
     - returns: location requested
     */
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
    
    /**
    Location Manager Pop Up
     - note: receives the User's decision to allow the app to track
     - parameter : CLLocation and locations
     - returns: bool
     */
    let locationManager = CLLocationManager()
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("Location = \(locValue.latitude) \(locValue.longitude)")
    }
    
    // Create a CLLocationManager to track app's authortization status for accessing the user's location
    override func viewDidAppear (_ animated: Bool)
    {
        //!< Check Shows-User-Location checkbox from map view if authorized
        //!< Else request access from the user
        super.viewDidAppear(animated)
    }
    
    /**
     MapView and Artwork implementation
     - note: code block where all UI is manipulated
     */
    override func viewDidLoad() {
        // Custom Annotation Markers, register class with custom identifiers
        mapView.register(ArtworkMarkerView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        super.viewDidLoad()
        super.viewDidLoad()
        
        // might throw SIGBRT, selects the currentLocBtnAction func
        let currentLocation = UIBarButtonItem(title: "Current Location", style: UIBarButtonItemStyle.plain, target: self, action: Selector(("currentLocBtnAction:")))
        self.navigationItem.leftBarButtonItem = currentLocation
        mapView.delegate = self
        definesPresentationContext = true
        
        // Location Manager
        self.locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        // Search Navigation Bar
        let searchButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: Selector(("searchButtonAction:")))
        self.navigationItem.rightBarButtonItem = searchButton
        
        // Assigns initial location at San Jose State
        let initLocation = CLLocation(latitude: 37.335187, longitude: -121.881072)
        // How much of the map you will see
        let radiusOfRegion: CLLocationDistance = 5000
        
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
        
        // Grocery store markers placed on map
        let groceryOutlet = Artwork(title: "Grocery Outlet", locationName: "Milk, Eggs, Ham", discipline: groceryDiscipline, coordinate: CLLocationCoordinate2D(latitude: 37.338316, longitude: -121.884173))
        let sevenEleven0 = Artwork(title: "7/11", locationName: "Doritos, Mountain Dew, Yogurt", discipline: convenienceDiscipline, coordinate: CLLocationCoordinate2D(latitude: 37.3326, longitude: -121.8801))
        let sevenEleven1 = Artwork(title: "7/11", locationName: "Spaghetti, Instant Noodles, Hot Dogs", discipline: convenienceDiscipline, coordinate: CLLocationCoordinate2D(latitude: 37.336960, longitude: -121.876427))
        let sevenEleven2 = Artwork(title: "7/11", locationName: "Oreos, Peanut Butter, Bananas", discipline: convenienceDiscipline, coordinate: CLLocationCoordinate2D(latitude: 37.340490, longitude: -121.880409))
        let wholeFoods = Artwork(title: "Whole Foods", locationName: "Tofu, Quinoa, Honey, Cucumbers, Lettuce, Oranges, Whole Grain Bread", discipline: groceryDiscipline, coordinate: CLLocationCoordinate2D(latitude: 37.332124, longitude: -121.904907))
        let walmart = Artwork(title: "Walmart", locationName: "Bananas, Squash, Tomatoes, Steak, Muffins, White Bread", discipline: generalDiscipline, coordinate: CLLocationCoordinate2D(latitude: 37.331031, longitude: -121.860175))
        let liquorStore0 = Artwork(title: "Kelly's Liquor Store", locationName: "Fireball, Vodka, Crown Royal, Amsterdam, Gum", discipline: liquorStoreDiscipline, coordinate: CLLocationCoordinate2D(latitude: 37.346276, longitude: -121.893504))
        let liquorStore1 = Artwork(title: "College Market", locationName: "Tecate, Bud Light, Corona, Modelo, Beef Jerky", discipline: liquorStoreDiscipline, coordinate: CLLocationCoordinate2D(latitude: 37.331100, longitude: -121.879320))
        // Annotation array displaying all markers and information
        mapView.addAnnotation(groceryOutlet)
        mapView.addAnnotation(sevenEleven0)
        mapView.addAnnotation(sevenEleven1)
        mapView.addAnnotation(sevenEleven2)
        mapView.addAnnotation(wholeFoods)
        mapView.addAnnotation(walmart)
        mapView.addAnnotation(liquorStore0)
        mapView.addAnnotation(liquorStore1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

/**
 MapView VC extension
 - note: Annotations thrown onto the MapView
 */
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
