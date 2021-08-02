//
//  OrientationObserver.swift
//  OrientationObserver
//
//  Created by incetro on 8/2/21.
//

import UIKit
import CoreMotion

// MARK: - OrientationObserver

public class OrientationObserver {

    // MARK: - Properties

    /// Notification name
    public static let deviceOrientationChangedNotification = NSNotification.Name("DeviceOrientationChangedNotification")

    /// Current orientation value
    public private(set) var currentDeviceOrientation: UIDeviceOrientation = .portrait

    /// Current orientation transform
    public var affineTransform: CGAffineTransform {
        var angleRadians: CGFloat
        switch currentDeviceOrientation {
        case .portrait:
            angleRadians = 0
        case .landscapeLeft:
            angleRadians = -0.5 * .pi
        case .landscapeRight:
            angleRadians = 0.5 * .pi
        case .portraitUpsideDown:
            angleRadians = .pi
        default:
            return .identity
        }
        return CGAffineTransform(rotationAngle: angleRadians)
    }

    /// CMMotionManager instance
    private let motionManager: CMMotionManager

    /// Observing OperationQueue instance
    private let queue: OperationQueue

    // MARK: - Initializers

    /// Standard initializer
    /// - Parameters:
    ///   - motionManager: CMMotionManager instance
    ///   - queue: observing OperationQueue instance
    public init(
        motionManager: CMMotionManager,
        queue: OperationQueue
    ) {
        self.motionManager = motionManager
        self.queue = queue
    }

    /// Default initializer
    public init() {
        self.motionManager = CMMotionManager()
        self.motionManager.accelerometerUpdateInterval = 0.1
        self.queue = OperationQueue()
    }

    /// Starts device orientation tracking
    public func startDeviceOrientationTracking() {
        motionManager.startAccelerometerUpdates(to: queue) { [weak self] accelerometerData, error in
            guard
                let self = self,
                let accelerometerData = accelerometerData,
                error == nil
            else { return }
            let newDeviceOrientation = self.deviceOrientation(forAccelerometerData: accelerometerData)
            guard newDeviceOrientation != self.currentDeviceOrientation else { return }
            self.currentDeviceOrientation = newDeviceOrientation
            NotificationCenter.default.post(
                name: OrientationObserver.deviceOrientationChangedNotification,
                object: nil,
                userInfo: nil
            )
        }
    }

    /// Stops device orientation tracking
    public func stopDeviceOrientationTracking() {
        motionManager.stopAccelerometerUpdates()
    }

    // MARK: - Private

    /// Calculates device orientation from accelerometer data
    /// - Parameter accelerometerData: accelerometer data
    /// - Returns: a device orientation value
    private func deviceOrientation(forAccelerometerData accelerometerData: CMAccelerometerData) -> UIDeviceOrientation {
        let threshold = 0.55
        if accelerometerData.acceleration.x >= threshold {
            return .landscapeLeft
        } else if accelerometerData.acceleration.x <= -threshold {
            return .landscapeRight
        } else if accelerometerData.acceleration.y <= -threshold {
            return .portrait
        } else if accelerometerData.acceleration.y >= threshold {
            return .portraitUpsideDown
        } else {
            return currentDeviceOrientation
        }
    }
}
