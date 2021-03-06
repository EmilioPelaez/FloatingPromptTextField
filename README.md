# FloatingPromptTextField

[![Platforms](https://img.shields.io/badge/platforms-iOS-lightgray.svg)]()
[![Swift 5.5](https://img.shields.io/badge/swift-5.5-red.svg?style=flat)](https://developer.apple.com/swift)
[![License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://opensource.org/licenses/MIT)
[![Twitter](https://img.shields.io/badge/twitter-@emiliopelaez-blue.svg)](http://twitter.com/emiliopelaez)

A prompt is the label in a text field that informs the user about the kind of content the text field expects. In a default `TextField` it disappears when the user starts typing, hiding this important information.

A "floating" prompt/label/placeholder is a UX pattern pioneered by [JVFloatLabeledTextField](https://github.com/jverdi/JVFloatLabeledTextField) where the prompt floats over the text field when it becomes active, keeping this useful information visible even after the user has begun typing.

`FloatingPromptTextField` is a SwiftUI version of this UI component. It uses the new Focus system and because of it requires iOS 15. 

<p float="left">
  <img src="./Screenshots/Capture.gif" alt="Lock Screen" width=40% height=40%>
</p>

## Features

 * Use a `Text` view as the prompt
 * Use any `View` as the prompt
 * Use a different `View` as the floating prompt
 * Set the floating prompt scale
 * Set the floating prompt spacing

## Usage

Usage is as simple as importing `FloatingPromptTextField`, declaring a `@State` `String` variable, and initializing `FloatingPromptTextField` with a `Text` or any `View`.

```swift
@import FloatingPromptTextField

...

@State var text: String = ""

...

FloatingPromptTextField(text: $text, prompt: Text("Prompt"))

FocusTextField(text: $text) {
	Label("Prompt", systemImage: "pencil.circle")
}
```

## Customization

All of the customization is done using modifier-style functions.

### Customizing the Floating Prompt

The `floatingPrompt` receives a view that will replace the prompt as it becomes floating. For best results it's recommended to use a view that will have the same height as the prompt. 

In this example we use a `Text` view with the same font but different contents and foreground styles. 

```swift
FloatingPromptTextField(text: $text) {
	Text("Prompt")
}
.floatingPrompt {
	Text("Floating Prompt")
		.foregroundStyle(Color.blue)
}
```

Note: This function is exclusive to `FloatingPromptTextField`, so it must be called before calling other modifiers.

### TextField Color/Gradient

```swift
FloatingPromptTextField(text: $text, prompt: Text("Prompt"))
	.textFieldForegroundStyle(Color.red)
```

Note: This function is exclusive to `FloatingPromptTextField`, so it must be called before calling other modifiers.

### Floating Prompt Spacing, Scale and Animation 

`floatingPromptScale(_ scale: Double)` will determine the scale that will be used when the prompt becomes a floating label.

`floatingPromptSpacing(_ spacing: Double)` will determine the spacing between the text field and the floating prompt.

`animateFloatingPromptHeight(_ animate: Bool)` will determine whether or not the view will animate its height to accommodate the floating prompt, or if the height of the floating prompt will always be calculated into the height's view.

```swift
FloatingPromptTextField(text: $text, prompt: Text("Prompt"))
	.floatingPromptScale(0.65)
	.floatingPromptSpacing(5)
	.animateFloatingPromptHeight(true)
```

## To Do

 - Accessibility
