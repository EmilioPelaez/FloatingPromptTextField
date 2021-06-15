//
//  FocusTextField.swift
//  FocusTextField
//
//  Created by Emilio Peláez on 14/6/21.
//

import SwiftUI

@available(iOS 15.0, *)
public enum FocusTextFieldDefaultValues {
	public static let font: Font = .body
	public static let textFieldStyle: PrimaryContentStyle = .primary
	public static let spacing: Double = 5
	public static let floatingPlaceholderScale: Double = 0.65
}

@available(iOS 15.0, *)
public struct FocusTextField<Placeholder: View, FloatingPlaceholder: View, TextFieldForegroundStyle: ShapeStyle>: View {
	
	enum PlaceholderState {
		case normal
		case floating
	}
	
	@FocusState private var isFocused: Bool
	
	private var text: Binding<String>
	private let font: Font
	private let placeholder: Placeholder
	private let floatingPlaceholder: FloatingPlaceholder
	
	private let textFieldStyle: TextFieldForegroundStyle
	
	private let floatingPlaceholderScale: Double
	private let spacing: Double
	
	var activeOffset: Double {
		spacing + placeholderHeight * floatingPlaceholderScale
	}
	
	@State private var placeholderState: PlaceholderState
	@State private var placeholderHeight: Double = 0
	
	public init(text: Binding<String>,
							font: Font = FocusTextFieldDefaultValues.font,
							textFieldStyle: TextFieldForegroundStyle,
							spacing: Double = FocusTextFieldDefaultValues.spacing,
							floatingPlaceholderScale: Double = FocusTextFieldDefaultValues.floatingPlaceholderScale,
							@ViewBuilder placeholder: () -> Placeholder,
							@ViewBuilder floatingPlaceholder: () -> FloatingPlaceholder) {
		self.text = text
		self.font = font
		self.placeholder = placeholder()
		self.floatingPlaceholder = floatingPlaceholder()
		
		self.textFieldStyle = textFieldStyle
		
		self.spacing = spacing
		self.floatingPlaceholderScale = floatingPlaceholderScale
		
		_placeholderState = State(initialValue: text.wrappedValue.isEmpty ? .normal : .floating)
	}
	
	public var body: some View {
		ZStack(alignment: .leading) {
			TextField("", text: text)
				.font(font)
				.foregroundStyle(textFieldStyle)
				.focused($isFocused)
			ZStack(alignment: .leading) {
				placeholder
					.opacity(placeholderState == .normal ? 1 : 0)
				floatingPlaceholder
					.background(
						GeometryReader { proxy in
							Color.clear
								.preference(key: HeightPreferenceKey.self, value: proxy.size.height)
						}
					)
					.opacity(placeholderState == .floating ? 1 : 0)
			}
			.scaleEffect(placeholderState == .floating ? floatingPlaceholderScale : 1, anchor: .topLeading)
			.offset(x: 0, y: placeholderState == .floating ? -activeOffset : 0)
		}
		.padding(.top, activeOffset)
		.onChange(of: text.wrappedValue) { _ in updateActive() }
		.onChange(of: isFocused) { _ in updateActive() }
		.onPreferenceChange(HeightPreferenceKey.self) { height in
			placeholderHeight = height
		}
		.onTapGesture { isFocused = true }
	}
	
	func updateActive() {
		withAnimation {
			placeholderState = (!text.wrappedValue.isEmpty || isFocused) ? .floating : .normal
		}
	}
}

@available(iOS 15.0, *)
extension FocusTextField where TextFieldForegroundStyle == PrimaryContentStyle {
	public init(text: Binding<String>,
							font: Font = FocusTextFieldDefaultValues.font,
							spacing: Double = FocusTextFieldDefaultValues.spacing,
							floatingPlaceholderScale: Double = FocusTextFieldDefaultValues.floatingPlaceholderScale,
							@ViewBuilder placeholder: () -> Placeholder,
							@ViewBuilder floatingPlaceholder: () -> FloatingPlaceholder) {
		self.init(text: text,
							font: font,
							textFieldStyle: .primary,
							spacing: spacing,
							floatingPlaceholderScale: floatingPlaceholderScale,
							placeholder: placeholder,
							floatingPlaceholder: floatingPlaceholder)
	}
}

@available(iOS 15.0, *)
extension FocusTextField where Placeholder == FloatingPlaceholder {
	public init(text: Binding<String>,
							font: Font = FocusTextFieldDefaultValues.font,
							textFieldStyle: TextFieldForegroundStyle,
							spacing: Double = FocusTextFieldDefaultValues.spacing,
							floatingPlaceholderScale: Double = FocusTextFieldDefaultValues.floatingPlaceholderScale,
							@ViewBuilder placeholder: () -> Placeholder) {
		self.init(text: text,
							font: font,
							textFieldStyle: textFieldStyle,
							spacing: spacing,
							floatingPlaceholderScale: floatingPlaceholderScale,
							placeholder: placeholder,
							floatingPlaceholder: placeholder)
	}
}

@available(iOS 15.0, *)
extension FocusTextField where TextFieldForegroundStyle == PrimaryContentStyle, Placeholder == FloatingPlaceholder {
	public init(text: Binding<String>,
							font: Font = FocusTextFieldDefaultValues.font,
							animation: Animation = .default,
							spacing: Double = FocusTextFieldDefaultValues.spacing,
							floatingPlaceholderScale: Double = FocusTextFieldDefaultValues.floatingPlaceholderScale,
							@ViewBuilder placeholder: () -> Placeholder) {
		self.init(text: text,
							font: font,
							textFieldStyle: FocusTextFieldDefaultValues.textFieldStyle,
							spacing: spacing,
							floatingPlaceholderScale: floatingPlaceholderScale,
							placeholder: placeholder,
							floatingPlaceholder: placeholder)
	}
}

@available(iOS 15.0, *)
struct FocusTextField_Previews: PreviewProvider {
	static var previews: some View {
		FocusTextField(text: .constant("Hello")) {
			Text("Placeholder")
		}
		.previewLayout(.fixed(width: 200, height: 80))
	}
}
