//
//  Utils.swift
//  list
//
//  Created by GGsrvg on 04.05.2020.
//  Copyright © 2020 GGsrvg. All rights reserved.
//

import Foundation
import UIKit

internal func createAdditionalInfo(count: Int) -> UIStackView {
    let label = createLabel(text: String(count), fontSize: 12, weight: .light)
    
    let hStack = UIStackView()
    hStack.axis = .horizontal
    
    hStack.addArrangedSubview(label)
    
    return hStack
}

internal func createLabel(text: String, fontSize: CGFloat, weight: UIFont.Weight) -> UILabel {
    let label = UILabel()
    label.text = text
    label.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
    return label
}
