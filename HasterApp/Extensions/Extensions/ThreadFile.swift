//
//  ThreadFile.swift
//  ExtraMiles
//
//  Created by Usama Ali on 03/03/2021.
//

import Foundation

/**
 Runs a block in the main thread
 **/
public func runOnMainThread(_ block: @escaping () -> ()) {
    DispatchQueue.main.async(execute: {
        block()
    })
}

/**
 Runs a block in background
 */
public func runInBackground(_ block: @escaping () -> ()) {
    
    DispatchQueue.global(qos: .userInitiated).async {
        block()
    }
}

public func runAfterTime(_ time: Double ,block : @escaping () -> ()){
    let delayTime = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline: delayTime) {
        block()
    }
}
