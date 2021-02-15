import XCTest
@testable import SuperpoweredSwift

final class BPMAnalyzerTests: XCTestCase {
    
    // MARK: - Helpers
    
    private func makeSUT(bpm: Float = 0) -> BPMAnalyzer {
        let core = BPMAnalyzerAdapterSpy(bpm: bpm)
        return BPMAnalyzer(core: core)
    }
    
    private final class BPMAnalyzerAdapterSpy: BPMAnalyzerAdapter {
        var getBPMCalledSpy = false
        var getBPMSongPathSpy: String?
        private let bpmStub: Float
        
        init(bpm: Float) {
            bpmStub = bpm
        }
        
        func getBPM(of songPath: String) -> Float {
            getBPMCalledSpy = true
            getBPMSongPathSpy = songPath
            return bpmStub
        }
    }
}
