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
	public static let activePlaceholderScale: Double = 0.65
}

@available(iOS 15.0, *)
public struct FocusTextField<Placeholder: View, ActivePlaceholder: View, TextFieldForegroundStyle: ShapeStyle>: View {
	
	enum PlaceholderState {
		case normal
		case active
	}
	
	@FocusState private var isFocused: Bool
	
	private var text: Binding<String>
	private let textFieldStyle: TextFieldForegroundStyle
	private let placeholder: Placeholder
	private let activePlaceholder: ActivePlaceholder
	
	fileprivate var font: Font = FocusTextFieldDefaultValues.font
	fileprivate var activePlaceholderScale: Double = FocusTextFieldDefaultValues.activePlaceholderScale
	fileprivate var placeholderSpacing: Double = FocusTextFieldDefaultValues.spacing
	fileprivate var animateHeight: Bool = false
	
	@State private var placeholderState: PlaceholderState
	@State private var placeholderHeight: Double = 0
	
	private var activeOffset: Double { placeholderSpacing + placeholderHeight * activePlaceholderScale }
	private var topMargin: Double { animateHeight && placeholderState == .normal ? 0 : activeOffset }
	
	fileprivate init(text: Binding<String>,
							textFieldStyle: TextFieldForegroundStyle,
							@ViewBuilder placeholder: () -> Placeholder,
							@ViewBuilder activePlaceholder: () -> ActivePlaceholder) {
		self.text = text
		self.placeholder = placeholder()
		self.activePlaceholder = activePlaceholder()
		
		self.textFieldStyle = textFieldStyle
		
		_placeholderState = State(initialValue: text.wrappedValue.isEmpty ? .normal : .active)
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
				activePlaceholder
					.background(
						GeometryReader { proxy in
						Color.clear
							.preference(key: HeightPreferenceKey.self, value: proxy.size.height)
					}
					)
					.opacity(placeholderState == .active ? 1 : 0)
			}
			.scaleEffect(placeholderState == .active ? activePlaceholderScale : 1, anchor: .topLeading)
			.offset(x: 0, y: placeholderState == .active ? -activeOffset : 0)
		}
		.padding(.top, topMargin)
		.onChange(of: text.wrappedValue) { _ in updateActive() }
		.onChange(of: isFocused) { _ in updateActive() }
		.onPreferenceChange(HeightPreferenceKey.self) { height in
			placeholderHeight = height
		}
		.onTapGesture { isFocused = true }
	}
	
	func updateActive() {
		withAnimation {
			placeholderState = (!text.wrappedValue.isEmpty || isFocused) ? .active : .normal
		}
	}
}

@available(iOS 15.0, *)
extension FocusTextField where TextFieldForegroundStyle == PrimaryContentStyle {
	fileprivate  init(text: Binding<String>,
							@ViewBuilder placeholder: () -> Placeholder,
							@ViewBuilder activePlaceholder: () -> ActivePlaceholder) {
		self.init(text: text,
							textFieldStyle: .primary,
							placeholder: placeholder,
							activePlaceholder: activePlaceholder)
	}
}

@available(iOS 15.0, *)
extension FocusTextField where Placeholder == ActivePlaceholder {
	fileprivate  init(text: Binding<String>,
							textFieldStyle: TextFieldForegroundStyle,
							@ViewBuilder placeholder: () -> Placeholder) {
		self.init(text: text,
							textFieldStyle: textFieldStyle,
							placeholder: placeholder,
							activePlaceholder: placeholder)
	}
}

@available(iOS 15.0, *)
extension FocusTextField where TextFieldForegroundStyle == PrimaryContentStyle, Placeholder == ActivePlaceholder {
	public init(text: Binding<String>,
							@ViewBuilder placeholder: () -> Placeholder) {
		self.init(text: text,
							textFieldStyle: FocusTextFieldDefaultValues.textFieldStyle,
							placeholder: placeholder,
							activePlaceholder: placeholder)
	}
}

@available(iOS 15.0, *)
extension FocusTextField {
	public func textFieldFont(_ font: Font) -> Self {
		var this = self
		this.font = font
		return this
	}
	
	public func activePlaceholder<Content: View>(_ activePlaceholder: Content) -> FocusTextField<Placeholder, Content, TextFieldForegroundStyle> {
		FocusTextField<Placeholder, Content, TextFieldForegroundStyle>(
			text: text,
			textFieldStyle: textFieldStyle,
			placeholder: { placeholder },
			activePlaceholder: { activePlaceholder }
		)
	}
	
	public func textFieldForegroundStyle<Style: ShapeStyle>(_ textFieldStyle: Style) -> FocusTextField<Placeholder, ActivePlaceholder, Style> {
		FocusTextField<Placeholder, ActivePlaceholder, Style>(
			text: text,
			textFieldStyle: textFieldStyle,
			placeholder: { placeholder },
			activePlaceholder: { activePlaceholder }
		)
	}
	
	public func activePlaceholderScale(_ activePlaceholderScale: Double) -> Self {
		var this = self
		this.activePlaceholderScale = activePlaceholderScale
		return this
	}
	
	public func placeholderSpacing(_ placeholderSpacing: Double) -> Self {
		var this = self
		this.placeholderSpacing = placeholderSpacing
		return this
	}
	
	public func animateHeight(_ animateHeight: Bool) -> Self {
		var this = self
		this.animateHeight = animateHeight
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
