//
//  Created by Emilio Peláez on 14/6/21.
//

import SwiftUI

struct HeightPreferenceKey: PreferenceKey {
	static let defaultValue: CGFloat = 0
	static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
		value = nextValue()
	}
}
