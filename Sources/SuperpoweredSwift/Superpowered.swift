//
//  Superpowered.swift
//  
//
//  Created by Orest Patlyka on 11.02.2021.
//

import SuperpoweredFramework

public enum Superpowered {
    /**
     Register the API key and activate the Superpowered components.
     - Important: Should be called only once.
     */
    public static func activate() {
        SuperpoweredShared.activate()
    }
}
