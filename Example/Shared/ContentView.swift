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
	
	@FocusState public var isFocused: Bool
	
	var body: some View {
		ZStack(alignment: .center) {
			Color.clear
			VStack {
				FocusTextField(text: $text, animation: .spring(), spacing: 5, placeholderScale: 0.5) {
					Label("Placeholder", systemImage: "square.and.pencil")
				}
				.focused($isFocused)
				HStack {
					Spacer()
					Button(action: { isFocused = false }) {
						Text("Unfocus")
					}
					Spacer()
					Button(action: { isFocused = true }) {
						Text("Focus")
					}
					Spacer()
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
