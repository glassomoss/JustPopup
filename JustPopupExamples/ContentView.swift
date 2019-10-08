//
//  ContentView.swift
//  JustPopupShowcase
//
//  Created by Mefodiy Akatov on 21.07.2019.
//  Copyright © 2019 Eubicor. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        VStack {
            ForEach(0..<10) { identified in
                Text("Hello World \(identified)")
            }
        }
    }

}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
