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

All of the customization is done using modifier-style functions. Since these are exclusive to `FocusTextField`, they must be called before calling other modifiers.

#### Customizing the Active Placeholder

The `activePlaceholder` receives a view that will replace the placeholder as it becomes active. For best results it's recommended to use a view that will have the same height as the placeholder. 

In this example we use a `Text` view with the same font but different contents and foreground styles. 

```swift
FocusTextField(text: $text) {
	Text("Placeholder")
}
.activePlaceholder(
	Text("Active Placeholder")
		.foregroundStyle(Color.blue)
)
```

#### TextField Font

Just like setting a font on a Text view, use the `font` modifier.

```swift
FocusTextField(text: $text) {
	Text("Placeholder")
}
.font(.title)
```

#### TextField Color/Gradient

```swift
FocusTextField(text: $text) {
	Text("Placeholder")
}
.textFieldForegroundStyle(Color.red)
```

#### Active Placeholder Spacing and Scale

`placeholderSpacing` will determine the spacing between the text field and the active placeholder.

`activePlaceholderScale` will determine the scale that will be used when the placeholder becomes a floating label.

```swift
FocusTextField(text: $text, textFieldStyle: Color.red) {
	Label("Enter Text", systemImage: "pencil.circle")
}
.placeholderSpacing(5)
.activePlaceholderScale(0.65)
```

### Features

 * Use any view as the placeholder
 * Use another view as the active placeholder
 * Set the placeholder scale
 * Set the placeholder spacing

### To Do

