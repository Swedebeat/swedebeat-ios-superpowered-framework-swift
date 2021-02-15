//
//  BPMAnalyzerAdapter.swift
//  
//
//  Created by Orest Patlyka on 15.02.2021.
//

import SuperpoweredFramework

protocol BPMAnalyzerAdapter {
    func getBPM(of songPath: String) -> Float
}

final class DefaultBPMAnalyzerAdapter: BPMAnalyzerAdapter {
    private let analyzer: SuperpoweredBPMAnalyzer
    
    init(analyzer: SuperpoweredBPMAnalyzer = .init()) {
        self.analyzer = analyzer
    }
    
    func getBPM(of songPath: String) -> Float {
        return analyzer.bpm(forSongPath: songPath)
    }
}
