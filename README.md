# FloatingPromptTextField

A prompt is the label in a text field that informs the user about the kind of content the text field expects. In a default `TextField` it disappears when the user starts typing, hiding this important information.

A "floating" prompt/label/placeholder is a UX pattern pioneered by [JVFloatLabeledTextField](https://github.com/jverdi/JVFloatLabeledTextField) where the prompt floats over the text field when it becomes active, keeping this useful information visible even after the user has begun typing.

`FloatingPromptTextField` is a SwiftUI version of this UI component. It uses the new Focus system and because of it requires iOS 15. 

<p float="left">
  <img src="./Screenshots/Screenshot0.png" alt="Lock Screen" width=25% height=25%>
  <img src="./Screenshots/Screenshot1.png" alt="Import Files" width=25% height=25%>
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

All of the customization is done using modifier-style functions. Since these are exclusive to `FloatingPromptTextField`, they must be called before calling other modifiers.

### Customizing the Floating Prompt

The `floatingPrompt` receives a view that will replace the prompt as it becomes floating. For best results it's recommended to use a view that will have the same height as the prompt. 

In this example we use a `Text` view with the same font but different contents and foreground styles. 

```swift
FloatingPromptTextField(text: $text) {
	Text("Prompt")
}
.floatingPrompt(
	Text("Floating Prompt")
		.foregroundStyle(Color.blue)
)
```

### TextField Font

Just like setting a font on a Text view, use the `font` modifier.

```swift
FloatingPromptTextField(text: $text, prompt: Text("Prompt"))
	.font(.title)
```

### TextField Color/Gradient

```swift
FloatingPromptTextField(text: $text, prompt: Text("Prompt"))
	.textFieldForegroundStyle(Color.red)
```

### Floating Prompt Spacing and Scale

`promptSpacing` will determine the spacing between the text field and the floating prompt.

`floatingPromptScale` will determine the scale that will be used when the prompt becomes a floating label.

```swift
FloatingPromptTextField(text: $text, prompt: Text("Prompt"))
	.promptSpacing(5)
	.floatingPromptScale(0.65)
```

## To Do

 - Accessibility
 - Support the new TextField initializers that receive a binding that can be formatted.
