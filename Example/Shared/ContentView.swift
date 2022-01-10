//
//  ContentView.swift
//  Shared
//
//  Created by Emilio Peláez on 20/6/21.
//

import SwiftUI
import FloatingPromptTextField

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
				FloatingPromptTextField(text: $textZero, prompt: Text("Input Zero"))
				.animateFloatingPromptHeight(true)
				.focused($focus, equals: .zero)
				FloatingPromptTextField(text: $textOne) {
					Label("Input One", systemImage: "pencil.circle").foregroundStyle(.secondary)
				}
				.focused($focus, equals: .one)
				FloatingPromptTextField(text: $textTwo) {
					Label("Input Two", systemImage: "pencil.circle").foregroundStyle(.secondary)
				}
				.textFieldForegroundStyle(Color.red)
				.focused($focus, equals: .two)
				FloatingPromptTextField(text: $textThree) {
					Label("Input Three", systemImage: "pencil.circle").foregroundStyle(.secondary)
				}
				.floatingPrompt {
					Label("Input Three", systemImage: "pencil.circle.fill").foregroundStyle(Color.blue)
				}
				.focused($focus, equals: .three)
				FloatingPromptTextField(text: $textFour) {
					Label("Input Four", systemImage: "pencil.circle").foregroundStyle(.secondary)
				}
				.textFieldForegroundStyle(Color.red)
				.floatingPrompt {
					Label("Input Four", systemImage: "pencil.circle.fill").foregroundStyle(Color.blue)
				}
				.floatingPromptSpacing(5)
				.floatingPromptScale(0.65)
				.focused($focus, equals: .four)
				HStack {
					Spacer()
					Button(action: { focus = nil }) {
						Text("Unfocus")
					}
					.buttonStyle(.bordered)
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
