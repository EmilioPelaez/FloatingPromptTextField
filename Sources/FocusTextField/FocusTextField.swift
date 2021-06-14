//
//  FocusTextField.swift
//  FocusTextField
//
//  Created by Emilio Peláez on 14/6/21.
//

import SwiftUI

@available(iOS 15.0, *)
public struct FocusTextField<Placeholder: View>: View {
	
	@FocusState public var isFocused: Bool
	
	public var text: Binding<String>
	public let placeholder: Placeholder
	
	@State private var active: Bool = false
	
	public init(text: Binding<String>, @ViewBuilder placeholder: @escaping () -> Placeholder) {
		self.text = text
		self.placeholder = placeholder()
	}
	
	public var body: some View {
		ZStack(alignment: .leading) {
			TextField("", text: text)
				.focused($isFocused)
			placeholder
				.scaleEffect(active ? 0.5 : 1, anchor: .leading)
				.offset(x: 0, y: active ? -20 : 0)
		}
		.padding(.top, 20)
		.onChange(of: text.wrappedValue) { _ in updateActive() }
		.onChange(of: isFocused) { _ in updateActive() }
	}
	
	func updateActive() {
		withAnimation {
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
