//
//  ContentView.swift
//  Shared
//
//  Created by Emilio Peláez on 14/6/21.
//

import SwiftUI
import FocusTextField

struct ContentView: View {
	@State var textZero: String = ""
	@State var textOne: String = "Hello World"
	@State var textTwo: String = "Hello World"
	@State var textThree: String = "Hello World"
	@State var textFour: String = "Hello World"
	
	enum Focus: Int, Hashable {
		case zero, one, two, three, four
	}
	
	@FocusState public var focus: Focus?
	
	var body: some View {
		ZStack(alignment: .center) {
			Color.clear
			VStack(spacing: 25) {
				FocusTextField(text: $textZero) {
					Label("Input Zero", systemImage: "pencil.circle")
				}
				.focused($focus, equals: .zero)
				FocusTextField(text: $textOne) {
					Label("Input One", systemImage: "pencil.circle")
				}
				.focused($focus, equals: .one)
				FocusTextField(text: $textTwo, textFieldStyle: Color.red) {
					Label("Input Two", systemImage: "pencil.circle")
				}
				.focused($focus, equals: .two)
				FocusTextField(text: $textThree) {
					Label("Input Three", systemImage: "pencil.circle")
				} floatingPlaceholder: {
					Label("Input Three", systemImage: "pencil.circle.fill")
						.foregroundStyle(Color.blue)
				}
				.focused($focus, equals: .three)
				FocusTextField(text: $textFour, textFieldStyle: Color.red) {
					Label("Input Four", systemImage: "pencil.circle")
				} floatingPlaceholder: {
					Label("Input Four", systemImage: "pencil.circle.fill")
						.foregroundStyle(Color.blue)
				}
				.textFieldFont(.body)
				.placeholderSpacing(5)
				.floatingPlaceholderScale(0.65)
				.focused($focus, equals: .four)
				HStack {
					Spacer()
					Button(action: { focus = nil }) {
						Text("Unfocus")
					}
					.buttonStyle(BorderedButtonStyle(tint: .red))
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
