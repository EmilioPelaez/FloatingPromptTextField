//
//  FocusTextField.swift
//  FocusTextField
//
//  Created by Emilio Peláez on 14/6/21.
//

import SwiftUI

@available(iOS 15.0, *)
public struct FocusTextField<Placeholder: View>: View {
	
	@FocusState private var isFocused: Bool
	
	private var text: Binding<String>
	private let placeholder: Placeholder
	
	private let animation: Animation
	
	private let placeholderScale: Double
	private let spacing: Double
	
	var activeOffset: Double {
		spacing + placeholderHeight * placeholderScale
	}
	
	@State private var active: Bool = false
	@State private var placeholderHeight: Double = 0
	
	public init(text: Binding<String>, animation: Animation = .default, spacing: Double = 5, placeholderScale: Double = 0.5, @ViewBuilder placeholder: @escaping () -> Placeholder) {
		self.text = text
		self.placeholder = placeholder()
		
		self.animation = animation
		self.spacing = spacing
		self.placeholderScale = placeholderScale
	}
	
	public var body: some View {
		ZStack(alignment: .leading) {
			TextField("", text: text)
				.focused($isFocused)
			placeholder
				.background(
					GeometryReader { proxy in
						Color.clear
							.preference(key: HeightPreferenceKey.self, value: proxy.size.height)
					}
				)
				.scaleEffect(active ? placeholderScale : 1, anchor: .topLeading)
				.offset(x: 0, y: active ? -activeOffset : 0)
				.onTapGesture { isFocused = true }
		}
		.padding(.top, activeOffset)
		.onChange(of: text.wrappedValue) { _ in updateActive() }
		.onChange(of: isFocused) { _ in updateActive() }
		.onPreferenceChange(HeightPreferenceKey.self) { height in
			placeholderHeight = height
			print(height)
		}
	}
	
	func updateActive() {
		withAnimation(animation) {
			active = !text.wrappedValue.isEmpty || isFocused
		}
	}
}

@available(iOS 15.0, *)
struct FocusTextField_Previews: PreviewProvider {
	static var previews: some View {
		FocusTextField(text: .constant("")) {
			Text("Placeholder")
		}
		.previewLayout(.fixed(width: 200, height: 80))
		
		FocusTextField(text: .constant("Hello")) {
			Text("Placeholder")
		}
		.previewLayout(.fixed(width: 200, height: 80))
	}
}
