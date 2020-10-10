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
    
    enum Const {
        static let heightDiff: CGFloat = 70
        static let topMarginAfterScanning: CGFloat = -20
    }
    
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var scanButtonContainer: ScanButtonContainer!
    @IBOutlet private weak var captureView: UIView!
    @IBOutlet private weak var nutritionCotainerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var parentStackViewTopConstriant: NSLayoutConstraint!
    @IBOutlet private weak var nutritionContaienrView: NutritionListContainerView!
    
    private let session: AVCaptureSession = AVCaptureSession()
    
    private var maskLayer: CAShapeLayer?
    private var cameraPreviewLayer : AVCaptureVideoPreviewLayer?
    private var photoOutput : AVCapturePhotoOutput?
    private var currentDevice: AVCaptureDevice?
    
    private let viewModel: ScanFoodViewModel = ScanFoodViewModel()
    private let disposeBag: DisposeBag = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePreviewLayer()
        bindViewModel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        session.stopRunning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let maskLayer = maskLayer {
            setupMaskLayer(mask: maskLayer)
            return
        }
        setupMaskLayer(mask: CAShapeLayer())
    }
    
    private func bindViewModel() {
        //MARK: Input
        scanButtonContainer.scanButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.viewModel.didTapScanButton()
        })
        .disposed(by: disposeBag)
        
        // MARK: Output
        Observable.combineLatest(viewModel.scanning, viewModel.nutritions)
            .filter { $0.0 == false }
            .subscribe(onNext: { [weak self] (scanning, nutrition) in
                if scanning {
                    self?.hideNtritionContainerView()
                } else {
                    self?.showNutritionContaienrView(nutritions: nutrition ?? [])
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func showNutritionContaienrView(nutritions: [Any]) {
        nutritionContaienrView.refreshData(data: nutritions)
        let baseHeight = scanButtonContainer.frame.height
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.nutritionCotainerViewHeightConstraint.constant = baseHeight + Const.heightDiff
            self?.parentStackViewTopConstriant.constant = Const.topMarginAfterScanning
            self?.view.layoutIfNeeded()
        }
    }
    
    private func hideNtritionContainerView() {
        
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
        
        session.startRunning()
    }
    
    private func setupMaskLayer(mask: CAShapeLayer) {
        let rect = CGRect(x: 0, y: 0, width: captureView.bounds.width, height: captureView.bounds.width)
        let path = UIBezierPath(rect: rect)
        mask.fillRule = CAShapeLayerFillRule.evenOdd
        mask.path = path.cgPath
        cameraPreviewLayer?.mask = mask
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
