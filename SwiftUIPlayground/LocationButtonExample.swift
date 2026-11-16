//
//  LocationButtonExample.swift
//  SwiftUIPlayground
//
//  Created by Joben Gohlke on 2/19/22.
//

import SwiftUI
import CoreLocationUI
import CoreLocation
import UIKit

enum LocationError: Error {
  case noLocationFound
  case geocodeFailed(Error)
  case noPlacemarksFound
}

struct LocationButtonExample: View {
  @State private var location: String = ""
  @StateObject private var viewModel = LocationButtonExampleViewModel()
  
  var body: some View {
    Form {
      Section {
        HStack {
          Text("Location")
            .font(.callout)
          
          Spacer()
          
          Text(viewModel.place)
          
          LocationButton(.currentLocation) {
            viewModel.manager.requestLocation()
          }
          .symbolVariant(.fill)
          .labelStyle(.iconOnly)
          .foregroundColor(.white)
          .cornerRadius(20)
          .font(.system(size: 12))
        }
      }
    }
  }
}

final class LocationButtonExampleViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
  
  let manager = CLLocationManager()
  @Published var place = ""
  
  override init() {
    super.init()
    manager.delegate = self
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    lookUpCurrentLocation { result in
      switch result {
        case .success(let placeName):
          self.place = placeName
        case .failure(let error):
          switch error {
            case .noLocationFound:
              print("Did not find valid location.")
            case .geocodeFailed(let error):
              print("Reverse geocode failed with error: \(error)")
            case .noPlacemarksFound:
              print("No placemarks found when reverse geocoding.")
          }
      }
    }
  }
  
  func lookUpCurrentLocation(completionHandler: @escaping (Result<String, LocationError>) -> Void) {
    if let lastLocation = manager.location {
      let geocoder = CLGeocoder()
      geocoder.reverseGeocodeLocation(lastLocation) { placemarks, error in
        if let error = error {
          completionHandler(.failure(.geocodeFailed(error)))
          return
        }
      
        if let firstLocation = placemarks?[0].name {
          completionHandler(.success(firstLocation))
        } else {
          completionHandler(.failure(.noPlacemarksFound))
        }
      }
    } else {
      completionHandler(.failure(.noLocationFound))
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("Error requesting location.")
  }
}

struct LocationButtonExample_Previews: PreviewProvider {
  static var previews: some View {
    LocationButtonExample()
  }
}
