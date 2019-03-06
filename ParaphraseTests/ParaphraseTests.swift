//
//  ParaphraseTests.swift
//  ParaphraseTests
//
//  Created by Jake Grant on 3/5/19.
//  Copyright © 2019 Hacking with Swift. All rights reserved.
//

@testable import Paraphrase
import XCTest

class ParaphraseTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadingInitialQuotes() {
        let model = QuotesModel(testing: true)
        XCTAssert(model.count == 12)
    }
    
    func testRandomQuotes() {
        let model = QuotesModel(testing: true)
        
        guard let quote = model.random() else {
            XCTFail()
            return
        }
        
        XCTAssert(quote.author == "Eliot")
    }
    
    func testFormattingMultiLine() {
        let model = QuotesModel(testing: true)
        let quote = model.quote(at: 0)
        
        let testString = "\"\(quote.text)\"\n   — \(quote.author)"
        XCTAssert(quote.multiLine == testString)
    }
    
    func testFormattingSingleLine() {
        let model = QuotesModel(testing: true)
        let quote = model.quote(at: 0)
        
        let formattedText = quote.text.replacingOccurrences(of: "\n", with: " ")
        let testString = "\(quote.author): \(formattedText)"
        XCTAssert(quote.singleLine == testString, "\(quote.singleLine) != \(testString)")
    }
    
    func testAddingQuote() {
        var model = QuotesModel(testing: true)
        let quoteCount = model.count
        
        let newQuote = Quote(author: "Jake Grant", text: "I'll get it later.")
        model.add(newQuote)
        
        XCTAssert(model.count == quoteCount + 1)
    }
    
    func testRemovingQuote() {
        var model = QuotesModel(testing: true)
        let quoteCount = model.count
        
        model.remove(at: 0)
        XCTAssert(model.count == quoteCount - 1)
    }
    
    func testReplacingQuote() {
        var model = QuotesModel(testing: true)
        
        let newQuote = Quote(author: "Jake Grant", text: "I'll get it later.")
        model.replace(index: 0, with: newQuote)
        
        let testQuote = model.quote(at: 0)
        XCTAssert(testQuote.author == "Jake Grant")
    }
    
    func testReplacingEmptyQuote() {
        var model = QuotesModel(testing: true)
        let previousCount = model.count
        
        let newQuote = Quote(author: "", text: "")
        model.replace(index: 0, with: newQuote)
        
        XCTAssert(model.count == previousCount - 1)
    }

}
