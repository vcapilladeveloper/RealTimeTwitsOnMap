//
//  MainView.swift
//  RealTimeTwitsOnMap
//
//  Created by Victor Capilla Developer on 27/8/21.
//

import SwiftUI
import MapKit

struct MainView: View {
    
    @ObservedObject var viewModel = MainViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                TextField("What do you want to search?", text: $viewModel.keyWord)
                Button("Search") {
                    print("\(viewModel.keyWord)")
                }
            }.padding()
            Text("Pins life time?")
            Picker(selection: $viewModel.pinLifeCycle, label: Text("Pins life time?")) {
                ForEach(viewModel.lifeTimeOptions, id: \.self) {
                    Text("\($0)")
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            Map(coordinateRegion: $viewModel.region, annotationItems: viewModel.annotationsToShow) {
                MapPin(coordinate: $0)
            }
            .onAppear{
                Timer.scheduledTimer(withTimeInterval: TimeInterval(viewModel.pinLifeCycle), repeats: true) { _ in
                    viewModel.processData()
                }
            }
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

extension CLLocationCoordinate2D: Identifiable {
    public var id: String {
        "\(latitude)-\(longitude)"
    }
}
