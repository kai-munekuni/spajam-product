//
//  ScanFoodViewController.swift
//  spajam-product
//
//  Created by Fumiya Tanaka on 2020/10/10.
//

import AVFoundation
import Foundation
import RxSwift
import RxCocoa
import UIKit

final class ScanFoodViewController: ViewController {
    
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var scanButton: UIButton!
    @IBOutlet private weak var captureView: UIView!
    
    private let session: AVCaptureSession = AVCaptureSession()
    
    private var cameraPreviewLayer : AVCaptureVideoPreviewLayer?
    private var photoOutput : AVCapturePhotoOutput?
    private var currentDevice: AVCaptureDevice?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePreviewLayer()
    }
    
    private func configurePreviewLayer() {
        session.sessionPreset = .photo
        
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.back)
        let devices = deviceDiscoverySession.devices
        for device in devices {
            currentDevice = device
        }
        setupInputOutput()
        setupPreviewLayer()
    }
    
    private func setupInputOutput() {
        guard let currentDevice = currentDevice else {
            return
        }
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentDevice)
            session.addInput(captureDeviceInput)
            let photoOutput = AVCapturePhotoOutput()
            photoOutput.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecType.jpeg])], completionHandler: nil)
            session.addOutput(photoOutput)
            
            self.photoOutput = photoOutput
        } catch {
            print(error)
        }
    }

    private func setupPreviewLayer() {
        let cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
        cameraPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer.frame = captureView.bounds
        captureView.layer.insertSublayer(cameraPreviewLayer, at: 0)
        
        self.cameraPreviewLayer = cameraPreviewLayer
    }
}
