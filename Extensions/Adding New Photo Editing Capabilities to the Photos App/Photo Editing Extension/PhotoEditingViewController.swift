//
//  PhotoEditingViewController.swift
//  Photo Editing Extension
//
//  Created by Yao Jiqian on 31/05/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit
import Photos
import PhotosUI
import OpenGLES

class PhotoEditingViewController: UIViewController, PHContentEditingController {
    
    /* An image view on the screen that first shows the original
     image to the user; after we are done applying our edits to the image, it will show the edited image */
    @IBOutlet weak var imageView: UIImageView!

    /* The input that the system will give us */
    var input: PHContentEditingInput!
    
    /* We give our edits to the user in this way */
    var output: PHContentEditingOutput!
    
    /* The name of the image filter that we will apply to the input image */
    let filterName = "CIColorPosterize"
    
    /* These two values are our way of telling the Photos framework about the identifier of the changes that we are going to make to the photo */
    let editFormatIdentifier = Bundle.main.bundleIdentifier!
    
    /* Just an application specific editing version */
    let editFormatVersion = "0.1"
    
    /* A queue that will execute our edits in the background */
    let operationQueue = OperationQueue()
    
    let shouldShowCancleComformation : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - PHContentEditingController
    
    /* We just want to work with the original image */
    func canHandle(_ adjustmentData: PHAdjustmentData) -> Bool {
        // Inspect the adjustmentData to determine whether your extension can work with past edits.
        // (Typically, you use its formatIdentifier and formatVersion properties to do this.)
        return false
    }
    
    func startContentEditing(with contentEditingInput: PHContentEditingInput, placeholderImage: UIImage) {
        
        imageView.image = placeholderImage
        
        input = contentEditingInput
        
        /* Start the editing in the background */
        let block = BlockOperation(block: editingOperation)
        
        operationQueue.addOperation(block)
    }
    
    func finishContentEditing(completionHandler: @escaping ((PHContentEditingOutput?) -> Void)) {
        // Update UI to reflect that editing has finished and output is being rendered.
        
        // Render and provide output on a background queue.
        DispatchQueue.global().async {
            // Create editing output from the editing input.
            let output = PHContentEditingOutput(contentEditingInput: self.input!)
            
            // Provide new adjustments and render output to given location.
            // output.adjustmentData = <#new adjustment data#>
            // let renderedJPEGData = <#output JPEG#>
            // renderedJPEGData.writeToURL(output.renderedContentURL, atomically: true)
            
            // Call completion handler to commit edit to Photos.
            completionHandler(output)
            
            // Clean up temporary files, etc.
        }
    }
    
    var shouldShowCancelConfirmation: Bool {
        // Determines whether a confirmation to discard changes should be shown to the user on cancel.
        // (Typically, this should be "true" if there are any unsaved changes.)
        return false
    }
    
    func cancelContentEditing() {
        operationQueue.cancelAllOperations()
    }
    
    /* This turns an image into its NSData representation */
    func dataFromCiImage(image : CIImage) -> NSData{
    
        let glContext = EAGLContext(api :.openGLES2)
        let context = CIContext(eaglContext : glContext!)
        let imageRef = context.createCGImage(image, from: image.extent)
        let image = UIImage(cgImage: imageRef!, scale : 1.0, orientation : .up)
        return UIImageJPEGRepresentation(image, 1.0)! as NSData
    }

    /* This takes the input and converts it to the output. The output has our posterized content saved inside it */
    func posterizeImageForInput(input : PHContentEditingInput) -> PHContentEditingOutput{
        
        /* Get the required information from the asset */
        let url = input.fullSizeImageURL
        let orientation = input.fullSizeImageOrientation
        
        /* Retrieve an instance of CIImage to apply our filter to */
        let inputImage = CIImage(contentsOf: url!, options: nil)?.applyingOrientation(orientation)
        
        /* Apply the filter to our image */
        let filter = CIFilter(name: filterName)
        filter!.setDefaults()
        filter!.setValue(inputImage, forKey: kCIInputImageKey)
        let outputImage = filter!.outputImage
        
        /* Get the data of our edited image */
        let editedImageData = dataFromCiImage(image: outputImage!)
        
        /* The results of editing our image are encapsulated here */
        let output = PHContentEditingOutput(contentEditingInput:input)
        
        /* Here we are saving our edited image to the URL that is dictated by the content editing output class */
        editedImageData.write(to: output.renderedContentURL, atomically: true)
        
        output.adjustmentData = PHAdjustmentData(formatIdentifier: editFormatIdentifier, formatVersion: editFormatVersion, data: filterName.data(using: String.Encoding.utf8, allowLossyConversion: false)!)
        
        return output
    }
    
    /* This is a closure that we will submit to our operation queue */
    func editingOperation(){
        
        output = posterizeImageForInput(input: input)
        
        DispatchQueue.main.async(execute: {[weak self] in
            let strongeSelf = self!
            
            let data = try! NSData(contentsOf: strongeSelf.output.renderedContentURL, options: .mappedIfSafe)
            let image = UIImage(data: data as Data)
            strongeSelf.imageView.image = image
        })
    }
}
