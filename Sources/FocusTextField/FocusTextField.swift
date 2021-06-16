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
	private let textFieldStyle: TextFieldForegroundStyle
	private let placeholder: Placeholder
	private let floatingPlaceholder: FloatingPlaceholder
	
	fileprivate var font: Font = FocusTextFieldDefaultValues.font
	fileprivate var floatingPlaceholderScale: Double = FocusTextFieldDefaultValues.floatingPlaceholderScale
	fileprivate var placeholderSpacing: Double = FocusTextFieldDefaultValues.spacing
	
	var activeOffset: Double {
		placeholderSpacing + placeholderHeight * floatingPlaceholderScale
	}
	
	@State private var placeholderState: PlaceholderState
	@State private var placeholderHeight: Double = 0
	
	public init(text: Binding<String>,
									 textFieldStyle: TextFieldForegroundStyle,
									 @ViewBuilder placeholder: () -> Placeholder,
									 @ViewBuilder floatingPlaceholder: () -> FloatingPlaceholder) {
		self.text = text
		self.placeholder = placeholder()
		self.floatingPlaceholder = floatingPlaceholder()
		
		self.textFieldStyle = textFieldStyle
		
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
									 @ViewBuilder placeholder: () -> Placeholder,
									 @ViewBuilder floatingPlaceholder: () -> FloatingPlaceholder) {
		self.init(text: text,
							textFieldStyle: .primary,
							placeholder: placeholder,
							floatingPlaceholder: floatingPlaceholder)
	}
}

@available(iOS 15.0, *)
extension FocusTextField where Placeholder == FloatingPlaceholder {
	public init(text: Binding<String>,
									 textFieldStyle: TextFieldForegroundStyle,
									 @ViewBuilder placeholder: () -> Placeholder) {
		self.init(text: text,
							textFieldStyle: textFieldStyle,
							placeholder: placeholder,
							floatingPlaceholder: placeholder)
	}
}

@available(iOS 15.0, *)
extension FocusTextField where TextFieldForegroundStyle == PrimaryContentStyle, Placeholder == FloatingPlaceholder {
	public init(text: Binding<String>,
							@ViewBuilder placeholder: () -> Placeholder) {
		self.init(text: text,
							textFieldStyle: FocusTextFieldDefaultValues.textFieldStyle,
							placeholder: placeholder,
							floatingPlaceholder: placeholder)
	}
}

@available(iOS 15.0, *)
extension FocusTextField {
	public func textFieldFont(_ font: Font) -> Self {
		var this = self
		this.font = font
		return this
	}
	
	public func floatingPlaceholderScale(_ floatingPlaceholderScale: Double) -> Self {
		var this = self
		this.floatingPlaceholderScale = floatingPlaceholderScale
		return this
	}
	
	public func placeholderSpacing(_ placeholderSpacing: Double) -> Self {
		var this = self
		this.placeholderSpacing = placeholderSpacing
		return this
	}
}

@available(iOS 15.0, *)
private struct FocusTextField_Previews: PreviewProvider {
	static var previews: some View {
		FocusTextField(text: .constant("Hello")) {
			Text("Placeholder")
		}
		.previewLayout(.fixed(width: 200, height: 80))
	}
}
