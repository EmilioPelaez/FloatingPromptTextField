//
//  Created by Emilio Peláez on 9/1/22.
//

import SwiftUI

struct TextFieldFontKey: EnvironmentKey {
	static var defaultValue: Font? = nil
}

struct FloatingPromptScaleKey: EnvironmentKey {
	static var defaultValue: Double = 0.65
}

struct FloatingPromptSpacingKey: EnvironmentKey {
	static var defaultValue: Double = 5
}

struct AnimateFloatingPromptHeightKey: EnvironmentKey {
	static var defaultValue = false
}

extension EnvironmentValues {
	var textFieldFont: Font? {
		get { self[TextFieldFontKey.self] }
		set { self[TextFieldFontKey.self] = newValue }
	}
	
	var floatingPromptScale: Double {
		get { self[FloatingPromptScaleKey.self] }
		set { self[FloatingPromptScaleKey.self] = newValue }
	}
	
	var floatingPromptSpacing: Double {
		get { self[FloatingPromptSpacingKey.self] }
		set { self[FloatingPromptSpacingKey.self] = newValue }
	}
	
	var animateFloatingPromptHeight: Bool {
		get { self[AnimateFloatingPromptHeightKey.self] }
		set { self[AnimateFloatingPromptHeightKey.self] = newValue }
	}
}
