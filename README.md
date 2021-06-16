# FocusTextField

A TextField with a floating label using the new Focus system on iOS 15

<p float="left">
  <img src="./Screenshots/Screenshot0.png" alt="Lock Screen" width=25% height=25%>
  <img src="./Screenshots/Screenshot1.png" alt="Import Files" width=25% height=25%>
</p>

### Usage

Usage is as simple as importing `FocusTextField`, declaring a `@State` `String` variable, and initializing `FocusTextField` with a placeholder.

```swift
@import FocusTextField

...

@State var text: String = ""

...

FocusTextField(text: $text) {
	Text("Placeholder")
}
```

### Customization

The style of the TextField, the Placeholder and the Floating Placeholder are configured during initialization.

Other properties like `font`, the `placeholderSpacing` and the `floatingPlaceholderScale` are configured like view modifiers

```swift
FocusTextField(text: $text, textFieldStyle: Color.red) {
	Label("Enter Text", systemImage: "pencil.circle")
} floatingPlaceholder: {
	Label("Text", systemImage: "pencil.circle.fill")
		.foregroundStyle(Color.blue)
}
.textFieldFont(.body)
.placeholderSpacing(5)
.floatingPlaceholderScale(0.65)
```

### Features

 * Use any view as the placeholder
 * Use another view as the floating placeholder
 * Set the placeholder scale
 * Set the placeholder spacing

### To Do

 * Move floating placeholder to modifier, if possible
 * Move text field style to modifier, if possible
