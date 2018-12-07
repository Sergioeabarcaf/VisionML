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
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            print("ERROR: \(error)")
        }
        
        let photoData = photo.fileDataRepresentation()
        let dataProvider = CGDataProvider(data: photoData! as CFData)
        
        let cgImageRef = CGImage(jpegDataProviderSource: dataProvider!, decode: nil, shouldInterpolate: true, intent: .defaultIntent)
        
        classify(cgImageRef!, completion: {data in
            self.pushData(data: data)
        })
        
        let image = UIImage(data: photoData!)
        self.tempImageView.image = image
        self.tempImageView.isHidden = false
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
    
    @IBAction func takePhoto() {
        self.photoOutput?.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
        self.captureButton.isHidden = true
        self.retakeButton.isHidden = false
        
        let alert = UIAlertController(title: "Prosesando", message: "Favor de esperar", preferredStyle: .alert)
        
        alert.view.tintColor = UIColor.black
        
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 10, y: (alert.view.bounds.maxY / 2), width: 50, height: 50))
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.startAnimating()
        alert.view.addSubview(activityIndicator)
        
        present(alert,animated: true)
    }
    
    @IBAction func retake() {
        self.tempImageView.isHidden = true
        self.captureButton.isHidden = false
        self.retakeButton.isHidden = true
        self.dismissResults()
        
    }
}
