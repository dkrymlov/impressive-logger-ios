//
//  LoggerTests.swift
//  ImpressiveLogger
//
//  Created by Данило Кримлов on 13.02.2026.
//

import XCTest
import Foundation
@testable import ImpressiveLogger

final class LoggerTests: XCTestCase {
    let logger = ImpressiveLogger()
    
    func testLogIntArray() {
        logger.setLoggerQueue("com.krymlov.impressiveLogger.test")
        let exp = expectation(description: "Log 3 different arrays on 3 different detalization levels")
        
        logger.logVerbose(message: [1,2,3], detalization: .simple)
        logger.logVerbose(message: [4,5,6], detalization: .standart)
        logger.logVerbose(message: [5,6,7], detalization: .detailed)
        
        logger.logDebug(message: [1,2,3], detalization: .simple)
        logger.logDebug(message: [4,5,6], detalization: .standart)
        logger.logDebug(message: [7,8,9], detalization: .detailed)
        
        logger.logInfo(message: [1,2,3], detalization: .simple)
        logger.logInfo(message: [4,5,6], detalization: .standart)
        logger.logInfo(message: [7,8,9], detalization: .detailed)
        
        logger.logWarning(message: [7,8,9], detalization: .simple)
        logger.logWarning(message: [7,8,9], detalization: .standart)
        logger.logWarning(message: [7,8,9], detalization: .detailed)
        
        logger.logError(message: [7,8,9], detalization: .simple)
        logger.logError(message: [7,8,9], detalization: .standart)
        logger.logError(message: [7,8,9], detalization: .detailed)
        
        logger.logCritical(message: [7,8,9], detalization: .simple)
        logger.logCritical(message: [7,8,9], detalization: .standart)
        logger.logCritical(message: [7,8,9], detalization: .detailed)
        
        logger.logFault(message: [7,8,9], detalization: .simple)
        logger.logFault(message: [7,8,9], detalization: .standart)
        logger.logFault(message: [7,8,9], detalization: .detailed)
        
        exp.fulfill()
        wait(for: [exp], timeout: 1.0)
    }
}
