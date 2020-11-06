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
    
    var thumbnailType:String? = nil
    var defeatVideoURL:URL? = nil
    
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
        let ip = UIImagePickerController()
        ip.sourceType = .camera
        ip.mediaTypes = [kUTTypeMovie as String, kUTTypeImage as String, kUTTypeLivePhoto as String]
        ip.videoQuality = .typeHigh
        ip.delegate = self
        present(ip, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! CFString
        
        self.thumbnailType = mediaType as String

        switch mediaType {
        case kUTTypeImage, kUTTypeLivePhoto:
            
            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            defeatImageView.image = image
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

                defeatImageView.image = UIImage(cgImage: cgImage)
            } catch {
               print(error.localizedDescription)
                
            }
            break
        default:
            break
        }
        
        picker.dismiss(animated: true)
    }
    
    @IBAction func didTapThumbnail(_ sender: Any) {
        print("Thumbnail tapped")
        print(self.thumbnailType!)
        if self.thumbnailType == "public.movie" && self.defeatVideoURL != nil {
            print("Video tapped")
            
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
    
    @IBAction func pressHome(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}
