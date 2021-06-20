# FloatingPromptTextField

A TextField with a floating label using the new Focus system on iOS 15

<p float="left">
  <img src="./Screenshots/Screenshot0.png" alt="Lock Screen" width=25% height=25%>
  <img src="./Screenshots/Screenshot1.png" alt="Import Files" width=25% height=25%>
</p>

## Features

 * Use any view as the prompt
 * Use another view as the floating prompt
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
FloatingPromptTextField(text: $text) {
	Text("Prompt")
}
.font(.title)
```

### TextField Color/Gradient

```swift
FloatingPromptTextField(text: $text) {
	Text("Prompt")
}
.textFieldForegroundStyle(Color.red)
```

### Floating Prompt Spacing and Scale

`promptSpacing` will determine the spacing between the text field and the floating prompt.

`floatingPromptScale` will determine the scale that will be used when the prompt becomes a floating label.

```swift
FloatingPromptTextField(text: $text, textFieldStyle: Color.red) {
	Label("Enter Text", systemImage: "pencil.circle")
}
.promptSpacing(5)
.floatingPromptScale(0.65)
```

## To Do

 - Accessibility
 - Support the new TextField initializers that receive a binding that can be formatted.
