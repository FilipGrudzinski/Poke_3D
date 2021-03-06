//
//  ViewController.swift
//  Poke_3D
//
//  Created by Filip on 30/11/2018.
//  Copyright © 2018 Filip. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        sceneView.autoenablesDefaultLighting = true // Switch light on a model
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()

        if let imageToTruck = ARReferenceImage.referenceImages(inGroupNamed: "Pockemon Cards", bundle: Bundle.main) {

                configuration.trackingImages = imageToTruck
                configuration.maximumNumberOfTrackedImages = 2

                print("Images successfully added")

        }
        
//        let configuration = ARWorldTrackingConfiguration() // changed for detect more images
//
//
//        if let imageToTruck = ARReferenceImage.referenceImages(inGroupNamed: "Pockemon Cards", bundle: Bundle.main) { //tracking images
//
//            configuration.detectionImages = imageToTruck  // changed for detect more images
//            configuration.maximumNumberOfTrackedImages = 2
//
//            print("Images successfully added")
//
//        }

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

   
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode() // brand new 3D object
        
        if let imageAnchor = anchor as? ARImageAnchor { // checking if the image is detected
            
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.5)
            
            let planeNode = SCNNode(geometry: plane)
            
            planeNode.eulerAngles.x = -.pi / 2
        
            node.addChildNode(planeNode)
            
            if imageAnchor.referenceImage.name == "eevee" {
                
                if let pokeScene = SCNScene(named: "art.scnassets/eevee.scn") {
                    
                    if let pokeNode = pokeScene.rootNode.childNodes.first {
                        
                        pokeNode.eulerAngles.x = .pi / 2
                        
                        planeNode.addChildNode(pokeNode)
                        
                    }
                    
                }
                
            }
            
            
            if imageAnchor.referenceImage.name == "oddish" {
                
                if let pokeScene = SCNScene(named: "art.scnassets/oddish.scn") {
                    
                    if let pokeNode = pokeScene.rootNode.childNodes.first {
                        
                        pokeNode.eulerAngles.x = .pi / 2
                        
                        planeNode.addChildNode(pokeNode)
                        
                    }
                    
                }
                
            }

            
           
            
        }
        
        return node
        
    }
    
}
