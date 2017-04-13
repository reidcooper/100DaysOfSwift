//
//  ViewController.swift
//  AddPhotoFromCameraRoll
//
//  Created by Reid Cooper on 4/7/17.
//  Copyright © 2017 Reid Cooper. All rights reserved.
//

import UIKit

class DisplayPhotoViewController: UIViewController {

  let photoPicker = UIImagePickerController()
  
  @IBOutlet weak var imagePhotoView: UIImageView!
  
  @IBAction func pickPhotoButton(_ sender: UIButton) {
    presentPhotoPicker()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    photoPicker.delegate = self
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func calculateImageHeightWithRatio(_ image: UIImage, width: CGFloat) -> CGFloat {
    let imageAspectRatio = image.size.height/image.size.width
    return imageAspectRatio * width
  }
  
  private func presentPhotoPicker() {
    photoPicker.allowsEditing = false
    photoPicker.sourceType = .photoLibrary
    photoPicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
    present(photoPicker, animated: true, completion: nil)
  }
}

extension DisplayPhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
    let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
    setImageToView(with: chosenImage)
    dismiss(animated: true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true, completion: nil)
  }
  
  private func setImageToView(with image: UIImage) {
    let new_image_size = CGSize(width: imagePhotoView.bounds.width, height: imagePhotoView.bounds.height)
    let new_image = image.resizedImage(withBounds: new_image_size)
    
    imagePhotoView.contentMode = .scaleAspectFit
    imagePhotoView.image = new_image
  }
}

extension UIImage {
  func resizedImage(withBounds bounds: CGSize) -> UIImage {
    let horizontalRatio = bounds.width / size.width
    let verticalRatio = bounds.height / size.height
    let ratio = min(horizontalRatio, verticalRatio)
    let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
    
    UIGraphicsBeginImageContextWithOptions(newSize, true, 0)
    draw(in: CGRect(origin: CGPoint.zero, size: newSize))
    
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage!
  }
}
