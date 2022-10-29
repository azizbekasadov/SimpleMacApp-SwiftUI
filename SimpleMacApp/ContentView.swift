//
//  ContentView.swift
//  SimpleMacApp
//
//  Created by Azizbek Asadov on 29/10/22.
//

import SwiftUI

struct Option: Hashable {
    let title: String
    let imageName: String
}

struct ContentView: View {
    @State var currentOption: Int = 0
    
    let options: [Option] = [
        .init(title: "Home", imageName: "house"),
        .init(title: "About", imageName: "info.circle"),
        .init(title: "Settings", imageName: "gearshape"),
        .init(title: "Social", imageName: "message")
    ]
    
    var body: some View {
        NavigationView {
            ListView(
                currentSelection: $currentOption,
                options: options
            )
            switch self.currentOption {
            case 1:
                Text("About this app")
            case 2:
                Text("Settings")
            case 3:
                Text("Social")
            default:
                MainView()
            }
        }
        .frame(minWidth: 600, minHeight: 400)
    }
}

struct ListView: View {
    @Binding var currentSelection: Int
    let options: [Option]
    
    var body: some View {
        VStack(spacing: 5) {
            let current = options[currentSelection]
            ForEach(options, id: \.self) { option in
                HStack {
                    Image(systemName: option.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundColor(
                            current == option ? .blue : .gray
                        )
                    Text(option.title)
                        .foregroundColor(
                            current == option ? .blue : .gray
                        )
                    Spacer()
                }
                .padding([.top, .leading, .trailing], 20)
                .onTapGesture {
                    if self.currentSelection == 1 {
                        self.currentSelection = 0
                    } else if currentSelection == 2 {
                        self.currentSelection = 1
                    } else if currentSelection == 3 {
                        self.currentSelection = 2
                    }
                }
            }
            
            Spacer()
        }
    }
}

struct MainView: View {
    let columns: [GridItem] = [
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible()),
    ]
    
    let videosThumbnails = Array(1...6).map { "video\($0)"}
    
    var body: some View {
        VStack {
            Image("")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .background(Color.red)
            
            LazyVGrid(columns: columns) {
                ForEach(videosThumbnails, id: \.self) {
                    Image($0)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
