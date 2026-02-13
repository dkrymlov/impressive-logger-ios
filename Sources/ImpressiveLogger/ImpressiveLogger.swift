//
//  LoggerConfig.swift
//  ImpressiveLogger
//
//  Created by Данило Кримлов on 13.02.2026.
//

import Foundation
import OSLog

public class ImpressiveLogger {
    public enum LogLevel {
        case verbose
        case debug
        case info
        case warning
        case error
        case critical
        case fault
    }
    
    public enum DetalizationLevel {
        case simple
        case standart
        case detailed
    }
    
    public enum LogConfiguration: String {
        case debug = "[DEBUG]"
        case release = "[RELEASE]"
    }
    
    private let logger: Logger
    private var loggerQueue: DispatchQueue
    private var dateFormatter: DateFormatter
    private var logConfiguration: ImpressiveLogger.LogConfiguration
    private var detalizationLevel: ImpressiveLogger.DetalizationLevel
    
    public init() {
        #if DEBUG
        self.logConfiguration = .debug
        #else
        self.logConfiguration = .release
        #endif
        
        self.detalizationLevel = .standart
        self.loggerQueue = DispatchQueue(
            label: "com.krymlov.impressiveLogger.default",
            attributes: .concurrent
        )
        self.dateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "[dd-MM-yyyy, hh:mm:ss]"
            return formatter
        }()
        self.logger = Logger()
    }
    
    // MARK: Setters
    public func setLoggerQueue(_ queueLabel: String) {
        self.loggerQueue = DispatchQueue(label: queueLabel, attributes: .concurrent)
    }
    
    public func setLogConfiguration(_ logConfiguration: ImpressiveLogger.LogConfiguration) {
        self.logConfiguration = logConfiguration
    }
    
    public func setDateFormatter(_ dateFormatter: DateFormatter) {
        self.dateFormatter = dateFormatter
    }
    
    private func getFormattedDateNow() -> String {
        return "\(dateFormatter.string(from: Date()))"
    }
    
    public func logVerbose(
        message: @autoclosure () -> Any,
        detalization: DetalizationLevel = .standart,
        function: String = #function,
        file: String = #file,
        line: Int = #line
    ) {
        log(message: message(), level: .verbose, detalization: detalization)
    }
    
    public func logDebug(
        message: @autoclosure () -> Any,
        detalization: DetalizationLevel = .standart,
        function: String = #function,
        file: String = #file,
        line: Int = #line
    ) {
        log(message: message(), level: .debug, detalization: detalization)
    }
    
    public func logInfo(
        message: @autoclosure () -> Any,
        detalization: DetalizationLevel = .standart,
        function: String = #function,
        file: String = #file,
        line: Int = #line
    ) {
        log(message: message(), level: .info, detalization: detalization)
    }
    
    public func logWarning(
        message: @autoclosure () -> Any,
        detalization: DetalizationLevel = .standart,
        function: String = #function,
        file: String = #file,
        line: Int = #line
    ) {
        log(message: message(), level: .warning, detalization: detalization)
    }
    
    public func logError(
        message: @autoclosure () -> Any,
        detalization: DetalizationLevel = .standart,
        function: String = #function,
        file: String = #file,
        line: Int = #line
    ) {
        log(message: message(), level: .error, detalization: detalization)
    }
    
    public func logCritical(
        message: @autoclosure () -> Any,
        detalization: DetalizationLevel = .standart,
        function: String = #function,
        file: String = #file,
        line: Int = #line
    ) {
        log(message: message(), level: .critical, detalization: detalization)
    }
    
    public func logFault(
        message: @autoclosure () -> Any,
        detalization: DetalizationLevel = .standart,
        function: String = #function,
        file: String = #file,
        line: Int = #line
    ) {
        log(message: message(), level: .fault, detalization: detalization)
    }
    
    public func log(
        message: @autoclosure () -> Any,
        level: LogLevel,
        detalization: DetalizationLevel,
        function: String = #function,
        file: String = #file,
        line: Int = #line
    ) {
        let evaluated = message()
        let msgString = String(describing: evaluated)
        
        let configPrefix = logConfiguration.rawValue
        let dateTime = getFormattedDateNow()
        let emoji = "\(level.emoji) "
        
        var log: String = ""
        
        switch detalization {
        case .simple:
            log = "\(dateTime) \(emoji)— \(msgString)"
        case .standart:
            log = "\(configPrefix) : \(dateTime) \(emoji)— \(msgString)"
        case .detailed:
            log = "\(configPrefix) : \(dateTime) \(emoji)\(file)/\(function):\(line) — \(msgString)"
        }
        
        self.completeLog(log: log, level: level)
    }
    
    private func completeLog(
        log: String,
        level: LogLevel
    ) {
        let queue = self.loggerQueue
        let logger = self.logger
        
        queue.async { [level, log, logger] in
            switch level {
            case .verbose:
                logger.log("\(log)")
            case .debug:
                logger.debug("\(log)")
            case .info:
                logger.info("\(log)")
            case .warning:
                logger.warning("\(log)")
            case .error:
                logger.error("\(log)")
            case .critical:
                logger.critical("\(log)")
            case .fault:
                logger.fault("\(log)")
            }
        }
    }
}

extension ImpressiveLogger.LogLevel {
    var emoji: String {
        switch self {
        case .verbose: return "" /// No emoji to be light and not noticable
        case .debug: return "🤖"
        case .info: return "ℹ️"
        case .warning: return "🧐"
        case .error: return "🤯"
        case .fault: return "🛑"
        case .critical: return "💥"
        }
    }
}

