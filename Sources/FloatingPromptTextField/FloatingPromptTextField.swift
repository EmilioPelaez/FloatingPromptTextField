//
//  FloatingPromptTextField.swift
//  FloatingPromptTextField
//
//  Created by Emilio Peláez on 14/6/21.
//

import SwiftUI

/// A text input control with a prompt that moves or "floats" when it
/// becomes focused, and for as long as the input text is not empty.

@available(iOS 15.0, *)
public struct FloatingPromptTextField<Prompt: View, FloatingPrompt: View, TextFieldForegroundStyle: ShapeStyle>: View {
	
	enum PromptState {
		case normal
		case floating
	}
	
	@FocusState private var isFocused: Bool
	
	private var text: Binding<String>
	private let textFieldStyle: TextFieldForegroundStyle
	private let prompt: Prompt
	private let floatingPrompt: FloatingPrompt
	
	fileprivate var font: Font = .body
	fileprivate var floatingPromptScale: Double = 0.65
	fileprivate var promptSpacing: Double = 5
	fileprivate var animateHeight: Bool = false
	
	@State private var promptState: PromptState
	@State private var promptHeight: Double = 0
	
	private var floatingOffset: Double { promptSpacing + promptHeight * floatingPromptScale }
	private var topMargin: Double { animateHeight && promptState == .normal ? 0 : floatingOffset }
	
	fileprivate init(text: Binding<String>,
							textFieldStyle: TextFieldForegroundStyle,
							@ViewBuilder prompt: () -> Prompt,
							@ViewBuilder floatingPrompt: () -> FloatingPrompt) {
		self.text = text
		self.prompt = prompt()
		self.floatingPrompt = floatingPrompt()
		
		self.textFieldStyle = textFieldStyle
		
		_promptState = State(initialValue: text.wrappedValue.isEmpty ? .normal : .floating)
	}
	
	public var body: some View {
		ZStack(alignment: .leading) {
			TextField("", text: text)
				.font(font)
				.foregroundStyle(textFieldStyle)
				.focused($isFocused)
			ZStack(alignment: .leading) {
				prompt
					.opacity(promptState == .normal ? 1 : 0)
				floatingPrompt
					.background(
						GeometryReader { proxy in
						Color.clear
							.preference(key: HeightPreferenceKey.self, value: proxy.size.height)
					}
					)
					.opacity(promptState == .floating ? 1 : 0)
			}
			.scaleEffect(promptState == .floating ? floatingPromptScale : 1, anchor: .topLeading)
			.offset(x: 0, y: promptState == .floating ? -floatingOffset : 0)
		}
		.padding(.top, topMargin)
		.onChange(of: text.wrappedValue) { _ in updateState() }
		.onChange(of: isFocused) { _ in updateState() }
		.onPreferenceChange(HeightPreferenceKey.self) { height in
			promptHeight = height
		}
		.onTapGesture { isFocused = true }
	}
	
	func updateState() {
		withAnimation {
			promptState = (!text.wrappedValue.isEmpty || isFocused) ? .floating : .normal
		}
	}
}

@available(iOS 15.0, *)
extension FloatingPromptTextField where TextFieldForegroundStyle == HierarchicalShapeStyle {
	fileprivate  init(text: Binding<String>,
							@ViewBuilder prompt: () -> Prompt,
							@ViewBuilder floatingPrompt: () -> FloatingPrompt) {
		self.init(text: text,
							textFieldStyle: .primary,
							prompt: prompt,
							floatingPrompt: floatingPrompt)
	}
}

@available(iOS 15.0, *)
extension FloatingPromptTextField where Prompt == FloatingPrompt {
	fileprivate  init(text: Binding<String>,
							textFieldStyle: TextFieldForegroundStyle,
							@ViewBuilder prompt: () -> Prompt) {
		self.init(text: text,
							textFieldStyle: textFieldStyle,
							prompt: prompt,
							floatingPrompt: prompt)
	}
}

@available(iOS 15.0, *)
extension FloatingPromptTextField where TextFieldForegroundStyle == HierarchicalShapeStyle, Prompt == FloatingPrompt {
	/// Creates a FloatingPromptTextField with a string binding and a view that will be used
	/// as the prompt.
	///
	/// - Parameters:
	///   - text: A binding to the text to display and edit.
	///   - prompt: A view that will be used as a prompt when the text field
	///   is empty, and as a floating prompt when it's focused or not empty,
	public init(text: Binding<String>,
							@ViewBuilder prompt: () -> Prompt) {
		self.init(text: text,
							textFieldStyle: .primary,
							prompt: prompt,
							floatingPrompt: prompt)
	}
}

@available(iOS 15.0, *)
extension FloatingPromptTextField where TextFieldForegroundStyle == HierarchicalShapeStyle, Prompt == Text, FloatingPrompt == Text {
	/// Creates a FloatingPromptTextField with a string binding and a Text view that will be
	/// used as the prompt.
	///
	/// - Parameters:
	///   - text: A binding to the text to display and edit.
	///   - prompt: A Text view that will be used as a prompt when the text field
	///   is empty, and as a floating prompt when it's focused or not empty.
	public init(text: Binding<String>, prompt: Text) {
		self.init(text: text,
							textFieldStyle: .primary,
							prompt: { prompt.foregroundColor(.secondary) },
							floatingPrompt: { prompt.foregroundColor(.primary) })
	}
}

@available(iOS 15.0, *)
extension FloatingPromptTextField {
	/// Sets the font for the text field in this view.
	///
	/// - Parameter font: The font for the text field.
	public func font(_ font: Font) -> Self {
		var this = self
		this.font = font
		return this
	}
	
	/// A `View` to be used as the floating prompt when the text field is focused
	/// or not empty.
	///
	/// - Parameter floatingPrompt: The view that will be used as the floating
	/// prompt when the text field is focused or not empty.
	public func floatingPrompt<Content: View>(_ floatingPrompt: Content) -> FloatingPromptTextField<Prompt, Content, TextFieldForegroundStyle> {
		FloatingPromptTextField<Prompt, Content, TextFieldForegroundStyle>(
			text: text,
			textFieldStyle: textFieldStyle,
			prompt: { prompt },
			floatingPrompt: { floatingPrompt }
		)
	}
	
	/// Sets the style for the text field. You can use this to set the color of the
	/// text in the text field.
	///
	/// - Parameter textFieldStyle: The style for the text field.
	public func textFieldForegroundStyle<Style: ShapeStyle>(_ textFieldStyle: Style) -> FloatingPromptTextField<Prompt, FloatingPrompt, Style> {
		FloatingPromptTextField<Prompt, FloatingPrompt, Style>(
			text: text,
			textFieldStyle: textFieldStyle,
			prompt: { prompt },
			floatingPrompt: { floatingPrompt }
		)
	}
	
	/// Sets the scale at which the prompt will be displayed when floating
	/// over the text field.
	///
	/// - Parameter floatingPromptScale: The scale for the floating prompt.
	public func floatingPromptScale(_ floatingPromptScale: Double) -> Self {
		var this = self
		this.floatingPromptScale = floatingPromptScale
		return this
	}
	
	/// Sets the spacing between the floating prompt and the text field.
	///
	/// - Parameter promptSpacing: The spacing in points between the floating
	/// prompt and the text field.
	public func promptSpacing(_ promptSpacing: Double) -> Self {
		var this = self
		this.promptSpacing = promptSpacing
		return this
	}
	
	/// Sets whether or not the view will animate its height to accommodate the
	/// floating prompt, or if the height of the floating prompt will
	/// always be calculated into the height's view.
	///
	/// - Parameter animateHeight: Whether or not the view will animate its
	/// height to accommodate the floating prompt.
	public func animateHeight(_ animateHeight: Bool) -> Self {
		var this = self
		this.animateHeight = animateHeight
		return this
	}
}

@available(iOS 15.0, *)
private struct FloatingPromptTextField_Previews: PreviewProvider {
	static var previews: some View {
		FloatingPromptTextField(text: .constant("Hello")) {
			Text("Prompt")
		}
		.previewLayout(.fixed(width: 200, height: 80))
	}
}
