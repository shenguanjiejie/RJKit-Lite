//
//  ExtensionString.swift
//  SenseGo
//
//  Created by Shen Ruijie on 2020/5/22.
//  Copyright © 2020 Sensetime. All rights reserved.
//

import Foundation

extension String {
    var url:URL{
        get{
            URL(string: self)!
        }
    }
}
