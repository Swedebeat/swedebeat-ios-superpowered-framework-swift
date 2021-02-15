//
//  BPMAnalyzer.swift
//  
//
//  Created by Orest Patlyka on 11.02.2021.
//

import SuperpoweredFramework

public protocol BPMAnalyzing: AnyObject {
    typealias BPM = Float
    typealias BPMCompletion = (BPM) -> Void
    func processLocalAudio(url: URL, completion: @escaping BPMCompletion)
}

public class BPMAnalyzer: BPMAnalyzing {
    public static func make() -> BPMAnalyzing {
        return BPMAnalyzer()
    }
    
    private let core = SuperpoweredBPMAnalyzer()
    
    public func processLocalAudio(url: URL, completion: @escaping BPMCompletion) {
        DispatchQueue.global(qos: .utility).async { [weak core] in
            let bpm = core?.bpm(forLocalSong: url) ?? 0
            completion(bpm)
        }
    }
}
