//
//  Created by Emilio Peláez on 9/1/22.
//

import SwiftUI

extension View {
	/// Sets the font for the text field in this view.
	public func textFieldFont(_ font: Font) -> some View {
		environment(\.textFieldFont, font)
	}
	
	/// Sets the scale at which the prompt will be displayed when floating
	/// over the text field.
	public func floatingPromptScale(_ scale: Double) -> some View {
		environment(\.floatingPromptScale, scale)
	}
	
	/// Sets the spacing between the floating prompt and the text field.
	public func floatingPromptSpacing(_ spacing: Double) -> some View {
		environment(\.floatingPromptSpacing, spacing)
	}
	
	/// Sets whether or not the view will animate its height to accommodate the
	/// floating prompt, or if the height of the floating prompt will
	/// always be calculated into the height's view.
	public func animateFloatingPromptHeight(_ animate: Bool) -> some View {
		environment(\.animateFloatingPromptHeight, animate)
	}
}