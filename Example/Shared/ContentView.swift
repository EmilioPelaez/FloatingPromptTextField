//
//  ContentView.swift
//  Shared
//
//  Created by Emilio Peláez on 14/6/21.
//

import SwiftUI
import FocusTextField

struct ContentView: View {
	@State var text: String = ""
	
	var body: some View {
		ZStack(alignment: .center) {
			Color.clear
			VStack {
				FocusTextField(text: $text) {
					Text("Placeholder")
				}
			}
			.padding()
			.background(Color(.secondarySystemBackground))
			.cornerRadius(10)
			.padding()
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
