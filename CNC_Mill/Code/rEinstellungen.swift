//
//  Einstellungen.swift
//  CNC_Mill
//
//  Created by Ruedi Heimlicher on 14.06.2020.
//  Copyright © 2020 Ruedi Heimlicher. All rights reserved.
//

import Foundation
import Cocoa


class rEinstellungen: NSViewController, NSWindowDelegate
{
   @IBOutlet weak var    Element:NSTextField!
  @IBOutlet weak var     StartpunktX: NSTextField!
   @IBOutlet weak var    StartpunktY: NSTextField!
   
   @IBOutlet weak var    StartpunktXStepper: NSStepper!
   @IBOutlet weak var    StartpunktXSlider: NSStepper!
   @IBOutlet weak var    StartpunktYStepper: NSStepper!
   @IBOutlet weak var    StartpunktYSlider: NSStepper!
   
   @IBOutlet weak var    EndpunktX: NSTextField!
   @IBOutlet weak var    EndpunktY: NSTextField!
   @IBOutlet weak var    EndpunktXStepper: NSStepper!
   @IBOutlet weak var    EndpunktXSlider: NSSlider!
   @IBOutlet weak var    EndpunktYStepper: NSStepper!
   @IBOutlet weak var    EndpunktYSlider: NSSlider!
   
   @IBOutlet weak var    deltaX: NSTextField!
   @IBOutlet weak var    deltaXStepper: NSTextField!
   @IBOutlet weak var    deltaXSlider: NSTextField!
   
   @IBOutlet weak var    deltaY: NSTextField!
   @IBOutlet weak var    deltaYStepper: NSStepper!
   @IBOutlet weak var    deltaYSlider:NSSlider!
   
   @IBOutlet weak var    Laenge: NSTextField!
   @IBOutlet weak var    LaengeStepper: NSStepper!
   @IBOutlet weak var    LaengeSlider: NSSlider!
   @IBOutlet weak var    Winkel: NSTextField!
   @IBOutlet weak var    WinkelStepper: NSStepper!
   @IBOutlet weak var    WinkelSlider: NSSlider!
  

   var schritte:Int?
   var speed:Int?
   
   
   
   override func viewDidLoad()
   {
      super.viewDidLoad()
      
   }   
   
}
