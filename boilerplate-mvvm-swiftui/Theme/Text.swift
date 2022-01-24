//
//  Text.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 1/5/22.
//

import SwiftUI

extension Text {
    public func primaryRegular(fontSize: CGFloat =  13, color: Color = Color.primaryTextColor) -> Text {
        return self.font(
                .custom(DesignTokens.fontFamilyPrimary, size: fontSize)
            )
            .foregroundColor(color)
    }
    
    public func primaryBold(fontSize: CGFloat =  13, color: Color = Color.primaryTextColor) -> Text {
        return self.primaryRegular(fontSize: fontSize, color: color)
            .fontWeight(.bold)
    }
    
    public func secondaryRegular(fontSize: CGFloat =  13, color: Color = Color.primaryTextColor) -> Text {
        return self.font(
                .custom(DesignTokens.fontFamilySecondary, size: fontSize)
            )
            .foregroundColor(color)
    }
}
