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
			VStack(spacing: 25) {
				FocusTextField(text: $text, animation: .spring(), spacing: 5, floatingPlaceholderScale: 0.5) {
					Label("Enter your text...", systemImage: "square.and.pencil")
						.opacity(0.5)
				}
				.focused($isFocused)
				HStack {
					Spacer()
					Button(action: { isFocused = false }) {
						Text("Unfocus")
					}
					.buttonStyle(BorderedButtonStyle(tint: .red))
					Spacer()
					Button(action: { isFocused = true }) {
						Text("Focus")
					}
					.buttonStyle(BorderedButtonStyle(tint: .blue))
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
