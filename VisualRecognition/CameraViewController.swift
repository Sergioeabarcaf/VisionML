import UIKit
import AVFoundation
import CoreML
import Vision

class CameraViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet var cameraView: UIView!
    @IBOutlet var tempImageView: UIImageView!
    
    @IBOutlet var captureButton: UIButton!
    @IBOutlet var retakeButton: UIButton!
    
    //variables camara
    var captureSession: AVCaptureSession?
    var photoOutput: AVCapturePhotoOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCamera()
        retake()
        
    }
    
    func initCamera(){
        self.captureSession = AVCaptureSession()
        self.captureSession?.sessionPreset = AVCaptureSession.Preset.hd4K3840x2160
        
        let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
        
        do{
            let input = try AVCaptureDeviceInput(device: backCamera!)
            self.captureSession?.addInput(input)
            
            self.photoOutput = AVCapturePhotoOutput()
            
            if (captureSession?.canAddOutput(self.photoOutput!) != nil){
                self.captureSession?.addOutput(self.photoOutput!)
                
                self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession!)
                
                self.previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspect
                self.previewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                self.cameraView.layer.addSublayer(self.previewLayer!)
                self.captureSession?.startRunning()
            }
        } catch {
            print("ERROR :\(error)")
        }
        
        self.previewLayer?.frame = self.view.bounds
    }
    
    //funcion para clasificar la imagen
    func classify(_ image: CGImage, completion: @escaping([VNClassificationObservation])-> Void){
        
    }
    
    func dismissResults(){
        
    }
    
    func pushData(data: [VNClassificationObservation]){
        
    }
    
    func getTableController(run: (_ tableController: ResultsTableViewController, _ drawer: PulleyViewController)->Void){
        
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        <#code#>
    }
    
    @IBAction func takePhoto() {
        
    }
    
    @IBAction func retake() {
        self.tempImageView.isHidden = true
        self.captureButton.isHidden = false
        self.retakeButton.isHidden = true
        self.dismissResults()
        
    }
}
