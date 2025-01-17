//
//  CameraController.swift
//  Ignite
//
//  Created by ageor0114 on 10/21/20.
//  Copyright © 2020 Ignite. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVKit

class CameraController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet var defeatImageView: UIImageView!
    

    @IBOutlet weak var snapText: UILabel!
    @IBOutlet weak var snapTitle: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var playIcon: UIButton!
    @IBOutlet weak var shareItTitle: UILabel!
    @IBOutlet weak var shareItText: UILabel!
    var thumbnailType:String? = nil
    var defeatImageURL: URL? = nil
    var defeatVideoURL:URL? = nil
    
    var goalModel: GoalTextModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func returnReflectionButton(_ sender: Any) {
    }
    
    @IBAction func takePicture(_ sender: Any) {
        if AVCaptureDevice.authorizationStatus(for: .video) == .denied || AVCaptureDevice.authorizationStatus(for: .audio) == .denied {
            let alertController = UIAlertController (title: "Enable Camera + Microphone Access", message: "You need to enable camera and microphone access in settings to share a photo/video with your friends.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alertController.addAction(cancelAction)
            
            let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
                
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }

                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)") // Prints true
                    })
                }
            }
            alertController.addAction(settingsAction)
            
            alertController.preferredAction = settingsAction

            present(alertController, animated: true, completion: nil)
        } else {
            let ip = UIImagePickerController()
            ip.sourceType = .camera
            ip.mediaTypes = [kUTTypeMovie as String, kUTTypeImage as String, kUTTypeLivePhoto as String]
            ip.videoQuality = .typeHigh
            ip.delegate = self
            present(ip, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! CFString
        
        self.thumbnailType = mediaType as String

        switch mediaType {
        case kUTTypeImage, kUTTypeLivePhoto:
            
            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            self.defeatImageView.image = image
            self.playIcon.isHidden = true
            break
            
        case kUTTypeMovie:
            
            // Get first frame of video for the thumbnail
            do {
                let url = info[UIImagePickerController.InfoKey.mediaURL] as! URL
                self.defeatVideoURL = url
                let asset = AVURLAsset(url: url)
                let imageGenerator = AVAssetImageGenerator(asset: asset)
                imageGenerator.appliesPreferredTrackTransform = true
                
                let cgImage = try imageGenerator.copyCGImage(at: .zero, actualTime: nil)

                self.defeatImageView.image = UIImage(cgImage: cgImage)
                self.playIcon.isHidden = false
                self.view.bringSubviewToFront(self.playIcon)
            } catch {
               print(error.localizedDescription)
                
            }
            break
        default:
            break
        }
        
        self.snapTitle.isHidden = true
        self.snapText.isHidden = true
        
        self.shareItTitle.isHidden = false
        //self.view.bringSubviewToFront(self.shareItTitle)
        self.shareItText.isHidden = false
        //self.view.bringSubviewToFront(self.shareItText)
        
        self.cameraButton.isHidden = true
        self.shareButton.isHidden = false
        //self.view.bringSubviewToFront(self.cameraButton)
        
        picker.dismiss(animated: true)
    }
    
    func playVideo() {
        if self.thumbnailType == "public.movie" && self.defeatVideoURL != nil {
            
            // Create an AVPlayer, passing it the HTTP Live Streaming URL.
            let player = AVPlayer(url: self.defeatVideoURL!)

            // Create a new AVPlayerViewController and pass it a reference to the player.
            let controller = AVPlayerViewController()
            controller.player = player

            // Modally present the player and call the player's play() method when complete.
            present(controller, animated: true) {
                player.play()
            }
        }
    }
    
    @IBAction func pressShare(_ sender: Any) {
        
        if (self.thumbnailType == "public.movie" && self.defeatVideoURL != nil) {
            let activityItems: [Any] = [self.defeatVideoURL!]
            let activityController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
            activityController.popoverPresentationController?.sourceView = view
            activityController.popoverPresentationController?.sourceRect = view.frame
            self.present(activityController, animated: true, completion: nil)
        } else {
            let activityItems: [Any] = [self.defeatImageView.image!]
            let activityController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
            activityController.popoverPresentationController?.sourceView = view
            activityController.popoverPresentationController?.sourceRect = view.frame
            self.present(activityController, animated: true, completion: nil)
        }
    }
    
    @IBAction func didTapPlay(_ sender: Any) {
        playVideo()
    }
    
    @IBAction func didTapThumbnail(_ sender: Any) {
        playVideo()
    }
    
    @IBAction func pressArrow(_ sender: Any) {
        performSegue(withIdentifier: "showConclusion", sender: self)
    }
}
