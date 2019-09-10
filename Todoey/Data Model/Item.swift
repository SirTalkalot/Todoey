//
//  Item.swift
//  Todoey
//
//  Created by Oliver Weinmeier on 08.09.19.
//  Copyright © 2019 oliverweinmeier. All rights reserved.
//

import Foundation

class Item: Encodable {
    var title: String = ""
    var done: Bool = false
}
