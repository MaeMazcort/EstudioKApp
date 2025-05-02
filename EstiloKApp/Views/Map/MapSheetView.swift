import SwiftUI
import MapKit

struct MapSheetView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 19.0521 - 0.003, longitude: -98.2850),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Map(coordinateRegion: $region, annotationItems: [UDLAPLocation()]) { location in
                MapMarker(coordinate: location.coordinate, tint: .red)
            }
            .ignoresSafeArea()
            
            VStack(spacing: 12) {
                Button(action: {
                    print("Confirm address tapped")
                    dismiss()
                }) {
                    Text("Confirm")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.primaryColor)
                        .bold()
                        .cornerRadius(12)
                }
                
                Button(action: {
                    print("Choose another address tapped")
                }) {
                    Text("Choose another address")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.carbon)
                        .bold()
                        .cornerRadius(12)
                }
            }
            .padding()
            .cornerRadius(20)
            .padding()
        }
        .presentationDetents([.fraction(0.6), .medium, .large]) // iOS 16+
    }
}

struct UDLAPLocation: Identifiable {
    let id = UUID()
    let coordinate = CLLocationCoordinate2D(latitude: 19.0521, longitude: -98.2850)
}

#Preview {
    MapSheetView()
}
