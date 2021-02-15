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
    
    private let core: BPMAnalyzerAdapter
    
    init(core: BPMAnalyzerAdapter = DefaultBPMAnalyzerAdapter()) {
        self.core = core
    }
    
    public func processLocalAudio(url: URL, completion: @escaping BPMCompletion) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let self = self else {
                return
            }
            guard let songPath = self.path(of: url) else {
                completion(0)
                return
            }
            let bpm = self.core.getBPM(of: songPath)
            completion(bpm)
        }
    }
    
    private func path(of url: URL) -> String? {
        let filePath = url.path
        if filePath.isEmpty {
            return nil
        }
        let systemRepresentation = FileManager.default.fileSystemRepresentation(withPath: filePath)
        return String(cString: systemRepresentation)
    }
}

protocol BPMAnalyzerAdapter {
    func getBPM(of songPath: String) -> Float
}

class DefaultBPMAnalyzerAdapter: BPMAnalyzerAdapter {
    private let analyzer: SuperpoweredBPMAnalyzer
    
    init(analyzer: SuperpoweredBPMAnalyzer = .init()) {
        self.analyzer = analyzer
    }
    
    func getBPM(of songPath: String) -> Float {
        return analyzer.bpm(forSongPath: songPath)
    }
}
