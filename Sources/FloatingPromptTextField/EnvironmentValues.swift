//
//  Created by Emilio Peláez on 9/1/22.
//

import SwiftUI

struct FloatingPromptScaleKey: EnvironmentKey {
	static var defaultValue: Double = 0.65
}

struct FloatingPromptSpacingKey: EnvironmentKey {
	static var defaultValue: Double = 5
}

struct PromptLeadingMarginKey: EnvironmentKey {
	static var defaultValue: Double = 0
}

struct AnimateFloatingPromptHeightKey: EnvironmentKey {
	static var defaultValue = false
}

extension EnvironmentValues {
	
	var floatingPromptScale: Double {
		get { self[FloatingPromptScaleKey.self] }
		set { self[FloatingPromptScaleKey.self] = newValue }
	}
	
	var promptLeadingMargin: Double {
		get { self[PromptLeadingMarginKey.self] }
		set { self[PromptLeadingMarginKey.self] = newValue }
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
