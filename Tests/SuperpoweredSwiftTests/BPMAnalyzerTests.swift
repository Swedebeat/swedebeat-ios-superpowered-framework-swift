import XCTest
@testable import SuperpoweredSwift

final class BPMAnalyzerTests: XCTestCase {
    
    func test_processLocalAudio_completionWithBPM() {
        let sut = makeSUT(bpm: 120)
        
        assertBPMEqualTo(120, analyzer: sut, audioURL: .dummy)
    }
    
    func test_processLocalAudio_whenURLPathIsEmpty_completionWithZeroBPM() {
        let sut = makeSUT()
        
        assertBPMEqualTo(0, analyzer: sut, audioURL: .emptyPath)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(bpm: Float = 120) -> BPMAnalyzer {
        let core = BPMAnalyzerAdapterSpy(bpm: bpm)
        return BPMAnalyzer(core: core)
    }
    
    private func assertBPMEqualTo(_ expectedBPM: Float,
                                  analyzer: BPMAnalyzer,
                                  audioURL: URL) {
        var receivedBPM: Float?
        
        let exp = expectation(description: "bpm")
        analyzer.processLocalAudio(url: audioURL) { bpm in
            receivedBPM = bpm
            exp.fulfill()
        }
        waitForExpectations(timeout: 1)
        
        XCTAssertEqual(receivedBPM, expectedBPM)
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

private extension URL {
    static var emptyPath: URL {
        var components = URLComponents()
        components.path = ""
        return components.url ?? .dummy
    }
    
    static var dummy: URL {
        return .init(fileURLWithPath: "")
    }
}
