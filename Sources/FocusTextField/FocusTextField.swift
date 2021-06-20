//
//  FocusTextField.swift
//  FocusTextField
//
//  Created by Emilio Peláez on 14/6/21.
//

import SwiftUI

/// A text input control with a placeholder that moves or "floats" when it
/// becomes focused, and for as long as the input text is not empty.

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
	
	fileprivate var font: Font = .body
	fileprivate var activePlaceholderScale: Double = 0.65
	fileprivate var placeholderSpacing: Double = 5
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
	/// Creates a FocusTextField with a string binding and a view that will be used as
	/// a placeholder
	///
	/// - Parameters:
	///   - text: A binding to the text to display and edit.
	///   - placeholder: A view that will be used as a placeholder when the text field
	///   is empty, and as a floating label when it's focused or not empty
	public init(text: Binding<String>,
							@ViewBuilder placeholder: () -> Placeholder) {
		self.init(text: text,
							textFieldStyle: .primary,
							placeholder: placeholder,
							activePlaceholder: placeholder)
	}
}

@available(iOS 15.0, *)
extension FocusTextField where TextFieldForegroundStyle == PrimaryContentStyle, Placeholder == Text, ActivePlaceholder == Text {
	/// Creates a FocusTextField with a string binding and a view that will be used as
	/// a placeholder
	///
	/// - Parameters:
	///   - text: A binding to the text to display and edit.
	///   - placeholder: A Text view that will be used as a placeholder when the text field
	///   is empty, and as a floating label when it's focused or not empty
	public init(text: Binding<String>, placeholder: Text) {
		self.init(text: text,
							textFieldStyle: .primary,
							placeholder: { placeholder.foregroundColor(.secondary) },
							activePlaceholder: { placeholder.foregroundColor(.primary) })
	}
}

@available(iOS 15.0, *)
extension FocusTextField {
	/// Sets the font for the text field in this view.
	///
	/// - Parameter font: The default font to use in this view.
	public func font(_ font: Font) -> Self {
		var this = self
		this.font = font
		return this
	}
	
	/// Sets the font for the text field in this view.
	///
	/// - Parameter activePlaceholder: The view that will be used as the floating
	/// placeholder.
	public func activePlaceholder<Content: View>(_ activePlaceholder: Content) -> FocusTextField<Placeholder, Content, TextFieldForegroundStyle> {
		FocusTextField<Placeholder, Content, TextFieldForegroundStyle>(
			text: text,
			textFieldStyle: textFieldStyle,
			placeholder: { placeholder },
			activePlaceholder: { activePlaceholder }
		)
	}
	
	/// Sets the style for the text field. You can use this to set the color of the
	/// text in the text field.
	///
	/// - Parameter textFieldStyle: The style for the text field.
	public func textFieldForegroundStyle<Style: ShapeStyle>(_ textFieldStyle: Style) -> FocusTextField<Placeholder, ActivePlaceholder, Style> {
		FocusTextField<Placeholder, ActivePlaceholder, Style>(
			text: text,
			textFieldStyle: textFieldStyle,
			placeholder: { placeholder },
			activePlaceholder: { activePlaceholder }
		)
	}
	
	/// Sets the scale at which the placeholder will be displayed when floating
	/// over the text field.
	///
	/// - Parameter activePlaceholderScale: The scale for the floating placeholder.
	public func activePlaceholderScale(_ activePlaceholderScale: Double) -> Self {
		var this = self
		this.activePlaceholderScale = activePlaceholderScale
		return this
	}
	
	/// Sets the spacing between the floating placeholder and the text field.
	///
	/// - Parameter placeholderSpacing: The spacing in points between the floating
	/// placeholder and the text field.
	public func placeholderSpacing(_ placeholderSpacing: Double) -> Self {
		var this = self
		this.placeholderSpacing = placeholderSpacing
		return this
	}
	
	/// Sets whether or not the view will animate its height to accommodate the
	/// floating placeholder, or if the height of the floating placeholder will
	/// always be calculated into the height's view.
	///
	/// - Parameter animateHeight: The default font to use in this view.
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
