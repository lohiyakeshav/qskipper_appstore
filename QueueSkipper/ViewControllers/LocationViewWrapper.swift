import SwiftUI
import UIKit

struct LocationViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> LocationViewController {
        let storyboard = UIStoryboard(name: "Location", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "locationVC") as! LocationViewController
    }

    func updateUIViewController(_ uiViewController: LocationViewController, context: Context) {}
}
