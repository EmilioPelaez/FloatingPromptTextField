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

### Features

 * Use any view as the placeholder
 * Set the placeholder scale
 * Set the placeholder spacing
 * Set the placeholder animation

### To Do

 * Placeholder Active State
 * Match keyboard animation curve (Maybe make animation not customizable?)
 * Make Text Field customizable

### Known Bugs

 * Animation looks a bit off when showing/hiding the keyboard
