//
//  Created by Emilio Peláez on 9/1/22.
//

import SwiftUI

public extension View {
	/// Sets the scale at which the prompt will be displayed when floating
	/// over the text field.
	func floatingPromptScale(_ scale: Double) -> some View {
		environment(\.floatingPromptScale, scale)
	}
	
	/// Sets the spacing between the floating prompt and the text field.
	func floatingPromptSpacing(_ spacing: Double) -> some View {
		environment(\.floatingPromptSpacing, spacing)
	}
	
	/// Sets the leading margin for the prompt in both floating and regular states
	func promptLeadingMargin(_ margin: Double) -> some View {
		environment(\.promptLeadingMargin, margin)
	}
	
	/// Sets whether or not the view will animate its height to accommodate the
	/// floating prompt, or if the height of the floating prompt will
	/// always be calculated into the height's view.
	func animateFloatingPromptHeight(_ animate: Bool) -> some View {
		environment(\.animateFloatingPromptHeight, animate)
	}
}
