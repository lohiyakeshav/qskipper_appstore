import UIKit
import CoreLocation
import MapKit

struct Location {
    let name: String
    let coordinate: CLLocationCoordinate2D
}

class LocationViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    let locationManager = CLLocationManager()
    var availableLocations = [Location]()
    var userLocation: CLLocation?

    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupAvailableLocations()

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }

    func setupAvailableLocations() {
        availableLocations.append(Location(name: "Galgotias University", coordinate: CLLocationCoordinate2D(latitude: 28.3669, longitude: 77.5413)))
        availableLocations.append(Location(name: "GBU", coordinate: CLLocationCoordinate2D(latitude: 28.4209, longitude: 77.5267)))
        availableLocations.append(Location(name: "NIU", coordinate: CLLocationCoordinate2D(latitude: 28.3723, longitude: 77.5395)))
        availableLocations.append(Location(name: "NIMS", coordinate: CLLocationCoordinate2D(latitude: 28.3713, longitude: 77.5385)))
        availableLocations.append(Location(name: "Chennai", coordinate: CLLocationCoordinate2D(latitude: 13.0827, longitude: 80.2707)))
        availableLocations.append(Location(name: "Pune", coordinate: CLLocationCoordinate2D(latitude: 18.5204, longitude: 73.8567)))
        availableLocations.append(Location(name: "Hyderabad", coordinate: CLLocationCoordinate2D(latitude: 17.3850, longitude: 78.4867)))
        availableLocations.append(Location(name: "Goa", coordinate: CLLocationCoordinate2D(latitude: 15.2993, longitude: 74.1240)))
        availableLocations.append(Location(name: "Jaipur", coordinate: CLLocationCoordinate2D(latitude: 26.9124, longitude: 75.7873)))
        availableLocations.append(Location(name: "Gurgaon", coordinate: CLLocationCoordinate2D(latitude: 28.5355, longitude: 77.3910)))

        for location in availableLocations {
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            annotation.title = location.name
            mapView.addAnnotation(annotation)
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            userLocation = location
            checkAvailability(for: location.coordinate)
            centerMapOnLocation(location: location)
        }
        locationManager.stopUpdatingLocation()
    }

    func checkAvailability(for coordinate: CLLocationCoordinate2D) {
        let userLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)

        var isAvailable = false

        for location in availableLocations {
            let availableLocation = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            if userLocation.distance(from: availableLocation) < 10000 {
                isAvailable = true
                break
            }
        }

        if isAvailable {
            showAvailablePlaces()
        } else {
            showNotAvailableMessage()
        }
    }

    func showAvailablePlaces() {
        let alert = UIAlertController(title: "Available", message: "Food ordering is available in your area.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func showNotAvailableMessage() {
        let alert = UIAlertController(title: "Not Available", message: "Food ordering is not available in your area.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    @IBAction func showAvailablePlacesButtonTapped(_ sender: UIButton) {
        guard let userLocation = userLocation else { return }

        var nearbyLocations = [Location]()

        for location in availableLocations {
            let availableLocation = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            if userLocation.distance(from: availableLocation) < 10000 {
                nearbyLocations.append(location)
            }
        }

        performSegue(withIdentifier: "showAvailableLocations", sender: nearbyLocations)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAvailableLocations",
           let destinationVC = segue.destination as? AvailableLocationsViewController,
           let locations = sender as? [Location] {
            destinationVC.locations = locations
        }
    }
    
    @IBAction func unwindToLocation(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
}
