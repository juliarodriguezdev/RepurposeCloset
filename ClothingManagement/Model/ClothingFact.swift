//
//  ClothingFact.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/20/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import Foundation

struct ClothingFact {
    
    var fact: String
    var source: String
    var type: factType
}

enum factType {
    case water
    case dyes
    case landfill
    case oil
    case cotton
    case clothing
    case playfields
    case secondHand
    case recycle
    case pollution
    case trees
    
    
}
