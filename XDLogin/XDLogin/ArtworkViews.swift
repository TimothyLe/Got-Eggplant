//
//  ArtworkViews.swift
//  mapView
//
//  Created by student on 4/29/18.
//  Copyright © 2018 The-Windows-Specialists. All rights reserved.
//

import MapKit

class ArtworkMarkerView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            // mapView :viewFor:, configures the callout
            guard let artwork = newValue as? Artwork else { return }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            // Set marker's color and replace glyph icon with first letter of discipline
            markerTintColor = artwork.markerColor
            glyphText = String(artwork.discipline.first!)
        }
    }
}
