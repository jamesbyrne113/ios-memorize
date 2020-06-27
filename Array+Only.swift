//
//  Array+Only.swift
//  Memorize
//
//  Created by James Byrne on 26/06/2020.
//  Copyright © 2020 jamesbyrne. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
