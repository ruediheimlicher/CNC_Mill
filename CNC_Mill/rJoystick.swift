//
//  rBasis.swift
//  Robot_Interface
//
//  Created by Ruedi Heimlicher on 06.08.2019.
//  Copyright © 2019 Ruedi Heimlicher. All rights reserved.
//
import Foundation
import Cocoa

//let USBATTACHED:Int     =      5
//let USBREMOVED:Int      =      6








class rJoystick: rViewController 
{
   
   
   
   var circledicarray = [[String:Int]]()
   
   var circlearray = [[Int]]() // Koordinaten der Punkte
   
   var maxdiff:Double = 100 // maximale differenz fuer doppelte Punkte
   
   var zoomfaktor:Double = 1.0
   
   var transformfaktor:Double = 0.3527777777779440
   
   var Schnittdatenarray = [[UInt8]]()
   
   var mouseistdown:Int = 0
   
   var lastklickposition:position = position()
  // var schnittPfad = rSchnittPfad()
 //  var usbstatus: Int32 = 0
   
 //  var teensy = usb_teensy()
   
   @IBOutlet weak var readSVG_Knopf: NSButton!
   
   @IBOutlet weak var DataSendTaste: NSButton!
   
   
   @IBOutlet weak var linear_checkbox: NSButton!
   @IBOutlet weak var horizontal_checkbox:NSButton!
   
   @IBOutlet weak var zoomFeld: NSTextField!
   
   @IBOutlet weak var fahrtweg: NSTextField!
   @IBOutlet weak var speedFeld: NSTextField!
 
   @IBOutlet weak var timerintervallFeld: NSTextField!
   
   @IBOutlet weak var stepsFeld: NSTextField!
   @IBOutlet weak var ramp_OK_Check: NSButton!
   
   
   
   @IBOutlet weak var dxFeld: NSTextField!
   @IBOutlet weak var dyFeld: NSTextField!
   
   @IBOutlet weak var dx_Stepper: NSStepper!
   @IBOutlet weak var dy_Stepper: NSStepper!

   @IBOutlet weak var homexFeld: NSTextField!
   @IBOutlet weak var homeyFeld: NSTextField!

   
   /*
   @IBOutlet weak var manufactorer: NSTextField!
   @IBOutlet weak var Counter: NSTextField!


   @IBOutlet weak var Start_Knopf: NSButton!
   @IBOutlet weak var Stop_Knopf: NSButton!
   @IBOutlet weak var Send_Knopf: NSButton!
   @IBOutlet weak var Start_Read_Knopf: NSButton!
   
   @IBOutlet weak var Anzeige: NSTextField!
   
   @IBOutlet weak var USB_OK: NSOutlineView!
   
   @IBOutlet weak var check_USB_Knopf: NSButton!

   
   @IBOutlet weak var codeFeld: NSTextField!
   
   @IBOutlet weak var dataFeld: NSTextField!
   
   @IBOutlet weak var schrittweiteFeld: NSTextField!
   
   @IBOutlet weak var Pot0_Feld: NSTextField!
   @IBOutlet weak var Pot0_Slider: NSSlider!
   @IBOutlet weak var Pot0_Stepper_H: NSStepper!
   @IBOutlet weak var Pot0_Stepper_L: NSStepper!
   @IBOutlet weak var Pot0_Stepper_L_Feld: NSTextField!
   @IBOutlet weak var Pot0_Stepper_H_Feld: NSTextField!
   
   @IBOutlet weak var joystick_x: NSTextField!
   @IBOutlet weak var joystick_y: NSTextField!
   
   @IBOutlet weak var goto_x: NSTextField!
   @IBOutlet weak var goto_x_Stepper: NSStepper!
   @IBOutlet weak var goto_y: NSTextField!
   @IBOutlet weak var goto_y_Stepper: NSStepper!
   
   @IBOutlet weak var Pot1_Feld: NSTextField!
   @IBOutlet weak var Pot1_Slider: NSSlider!
   @IBOutlet weak var Pot1_Stepper_H: NSStepper!
   @IBOutlet weak var Pot1_Stepper_L: NSStepper!
   @IBOutlet weak var Pot1_Stepper_L_Feld: NSTextField!
   @IBOutlet weak var Pot1_Stepper_H_Feld: NSTextField!
   
   
   
   @IBOutlet weak var Pot2_Feld: NSTextField!
   @IBOutlet weak var Pot2_Slider: NSSlider!
   @IBOutlet weak var Pot2_Stepper: NSStepper!
   @IBOutlet weak var Pot2_Stepper_H: NSStepper!
   @IBOutlet weak var Pot2_Stepper_L: NSStepper!
   @IBOutlet weak var Pot2_Stepper_L_Feld: NSTextField!
   @IBOutlet weak var Pot2_Stepper_H_Feld: NSTextField!
   
   @IBOutlet weak var Pot3_Feld: NSTextField!
   @IBOutlet weak var Pot3_Slider: NSSlider!
   @IBOutlet weak var Pot3_Stepper: NSStepper!
   @IBOutlet weak var Pot3_Stepper_H: NSStepper!
   @IBOutlet weak var Pot3_Stepper_L: NSStepper!
   @IBOutlet weak var Pot3_Stepper_L_Feld: NSTextField!
   @IBOutlet weak var Pot3_Stepper_H_Feld: NSTextField!
   
   @IBOutlet weak var Joystickfeld: rJoystickView!
   @IBOutlet weak var clear_Ring: NSButton!
    
   var formatter = NumberFormatter()
   
   
   var weg0_start:UInt16  = ACHSE0_START;
   var weg0_max:UInt16   = ACHSE0_MAX;
   
   
   
   // const fuer USB
   let SET_0:UInt8 = 0xA1
   let SET_1:UInt8 = 0xB1
   
   let SET_2:UInt8 = 0xC1
   let SET_3:UInt8 = 0xD1
   
   let SET_ROB:UInt8 = 0xA2
   
   let SET_P:UInt8 = 0xA3
   let GET_P:UInt8 = 0xB3
   
   let SIN_START:UInt8 = 0xE0
   let SIN_END:UInt8 = 0xE1
   
   
   
   
   let U_DIVIDER:Double = 9.8
   let ADC_REF:Double = 3.26
   
   let schrittexA = 4
   let schrittexB = 5
   
   let delayxA = 6
   let delayxB = 7
   
   
   let schritteyA = 16
   let schritteyB = 17
   
   
   let delayyA = 18
   let delayyB = 19
   
   let schrittezA = 22 // Hypotenuse
   let schrittezB = 23
   
   let delayzA = 24
   let delayzB = 25
   
   let delayzC = 26
   let delayzD = 27
*/
   override func viewDidAppear() 
   {
      print ("Joystick viewDidAppear selectedDevice: \(selectedDevice)")
   }
   
   override func viewDidLoad() 
    {
        super.viewDidLoad()
      
      
       
        // Do view setup here.
      self.view.window?.acceptsMouseMovedEvents = true
      //let view = view[0] as! NSView
      self.view.wantsLayer = true
      
      hintergrundfarbe  = NSColor.init(red: 0.35, 
                                    green: 0.15, 
                                    blue: 0.35, 
                                    alpha: 0.25)
      
      self.view.layer?.backgroundColor = hintergrundfarbe.cgColor
 
      formatter.maximumFractionDigits = 1
      formatter.minimumFractionDigits = 2
      formatter.minimumIntegerDigits = 1
      //formatter.roundingMode = .down
      
      let sup = self.view.superview
      //print("DeviceTab superview: \(String(describing: sup)) ident: \(String(describing: sup?.identifier))")
      
      //USB_OK.backgroundColor = NSColor.greenColor()
      // Do any additional setup after loading the view.
      let newdataname = Notification.Name("newdata")
      NotificationCenter.default.addObserver(self, selector:#selector(newDataAktion(_:)),name:newdataname,object:nil)
      NotificationCenter.default.addObserver(self, selector:#selector(joystickAktion(_:)),name:NSNotification.Name(rawValue: "joystick"),object:nil)
      NotificationCenter.default.addObserver(self, selector:#selector(usbstatusAktion(_:)),name:NSNotification.Name(rawValue: "usb_status"),object:nil)
  //    NotificationCenter.default.addObserver(self, selector:#selector(usbattachAktion(_:)),name:NSNotification.Name(rawValue: "usb_attach"),object:nil)

      //NotificationCenter.default.addObserver(self, selector:#selector(mausstatusAktion(_:)),name:NSNotification.Name(rawValue: "maus_status"),object:nil)

      
      dx_Stepper.intValue = dxFeld.intValue
      dx_Stepper.increment = 10
      dy_Stepper.intValue = dyFeld.intValue
      dy_Stepper.increment = 10
      // schnittPfad
      schnittPfad?.setStartposition(x: 0x800, y: 0x800, z: 0)
      
      // Pot 0
      /*
      Pot0_Slider.integerValue = Int(ACHSE0_START)
      Pot0_Feld.integerValue = Int(ACHSE0_START)
      let intpos0 = UInt16(Double(ACHSE0_START) * FAKTOR0)
      Pot0_Feld.integerValue = Int(UInt16(Double(ACHSE0_START) * FAKTOR0))
      Pot0_Stepper_L.integerValue = 0
      Pot0_Stepper_L_Feld.integerValue = 0
      Pot0_Stepper_H.integerValue = Int(Pot0_Slider.maxValue)
      Pot0_Stepper_H_Feld.integerValue = Int(Pot0_Slider.maxValue)
      
      // Pot 1
      Pot1_Slider.integerValue = Int(ACHSE1_START)
      //Pot1_Feld.integerValue = Int(ACHSE1_START)
      let intpos1 = UInt16(Double(ACHSE1_START) * FAKTOR1)
      Pot1_Feld.integerValue = Int(UInt16(Double(ACHSE1_START) * FAKTOR1))
      //Pot1_Feld.integerValue = Int(intpos1)
      Pot1_Stepper_L.integerValue = 0
      Pot1_Stepper_L_Feld.integerValue = 0 
      Pot1_Stepper_H.integerValue = Int(Pot1_Slider.maxValue)
      Pot1_Stepper_H_Feld.integerValue = Int(Pot1_Slider.maxValue)
      //print("intpos0: \(intpos0) intpos1: \(intpos1)")
 */
      /*
      // Pot 2
      Pot2_Slider.integerValue = Int(ACHSE2_START)
      Pot2_Feld.integerValue = Int(ACHSE2_START)
      Pot2_Stepper_L.integerValue = 0
      Pot2_Stepper_L_Feld.integerValue = 0 
      Pot2_Stepper_H.integerValue = Int(Pot2_Slider.maxValue)
      Pot2_Stepper_H_Feld.integerValue = Int(Pot2_Slider.maxValue)
      
      // Pot 3
      Pot3_Slider.integerValue = Int(ACHSE3_START)
      Pot3_Feld.integerValue = Int(ACHSE3_START)
      Pot3_Stepper_L.integerValue = 0
      Pot3_Stepper_L_Feld.integerValue = 0 
      Pot3_Stepper_H.integerValue = Int(Pot3_Slider.maxValue)
      Pot3_Stepper_H_Feld.integerValue = Int(Pot3_Slider.maxValue)
      */
      
      teensy.write_byteArray[SCHRITTEX_A] = UInt8(((ACHSE0_START) & 0xFF00) >> 8) // hb
      teensy.write_byteArray[SCHRITTEX_B] = UInt8(((ACHSE0_START) & 0x00FF) & 0xFF) // lb
      
      teensy.write_byteArray[DELAYX_A] = UInt8(((ACHSE1_START) & 0xFF00) >> 8) // hb
      teensy.write_byteArray[DELAYX_B] = UInt8(((ACHSE1_START) & 0x00FF) & 0xFF) // lb
      
      teensy.write_byteArray[0] = SET_0
  
//      let wegarray = wegArrayMitWegXY(wegx: 74, wegy: 4)
//      print("wegarray: \(wegarray)")

   }
 
 /*  
   func openFile() -> URL? 
   { 
      let myFileDialog = NSOpenPanel() 
      myFileDialog.runModal() 
      return myFileDialog.url 
   }  
   */
 /*
   override func mouseDown(with theEvent: NSEvent) 
   {
      
      super.mouseDown(with: theEvent)
      //let ident  = self.identifier as! String
      //let ident  = self.tag
      let location = theEvent.locationInWindow
      //    Swift.print(location)
      //    NSPoint lokalpunkt = [self convertPoint: [anEvent locationInWindow] fromView: nil];
      let lokalpunkt = self.view.convert(theEvent.locationInWindow, from: nil)
      //    Swift.print(lokalpunkt)
      
      Swift.print("joystick left mouse lokalpunkt")
      var notificationDic = [String:Any]()
       let nc = NotificationCenter.default
//      nc.post(name:Notification.Name(rawValue:"maus_status"),
 //             object: nil,
 //             userInfo: notificationDic)        

   }
  */ 
   
   
   func sortDicArray_opt(origDicArray:[[String:Int]], key0:String, key1: String, order:Bool) -> [[String:Int]]
   {
      print("sortDicArray_opt anz: \(origDicArray.count) order: \(order)")
      var returnDicArray:[[String:Int]] = [[String:Int]]()
      // https://useyourloaf.com/blog/sorting-an-array-of-dictionaries
      
      var linear = 0
      if linear_checkbox.state == .on
      {
            print("linear on")
            linear = 1
      }
      // Array nach cx sortieren
      var cxDicArray:[[String:Int]] = [[String:Int]]()
      var keyA = "" // keys je nach order
      var keyB = ""
      
      if order == false // zuerst nach senkrechte sortieren (cx)
      {
         keyA = key0
         keyB = key1
      }
      else // zuerst waagrecht sortieren (cy)
      {
         keyA = key1
         keyB = key0
      }
      
      
      
 //     if order == false // zuerst nach senkrechte sortieren
  //    {
         cxDicArray = origDicArray.sorted 
            {
               guard let s1 = $0[keyA], let s2 = $1[keyA] else 
               {
                  return false
               }
               if order == false
               {
                  return s1 < s2
               }
               else
               {
                  return s1 > s2 // reverse
               }
         }
   //   }
      /*
      else // zuerst nach waagrechte sortieren
      {
         cxDicArray = origDicArray.sorted 
            {
               guard let s1 = $0[keyA], let s2 = $1[keyA] else 
               {
                  return false
               }
               return s1 > s2 // reverse
         }
         
      }
 */
      //print(returnDicArray)  
      
       //print("cxDicArray anz: \(cxDicArray.count)") 
      
 //     for el in cxDicArray
//      {
//         print("\(el[keyA] ?? 0)\t \(el[keyB] ?? 0)")
 //     }
       
      
      var equalarray = [[[String:Int]]]()
      var equaldicarray = [[String:Int]]() // Zeilen mit gleichem cx sammeln
      var equaldic = [keyA:0] // startwert
      var eqindex = 0 
      var oldcx = 0
      for el in cxDicArray
      {
         oldcx = equaldic[keyA]! // Wert von cx: Dics mit gleichem Wert suchen und in equalarray sammeln
         let cx = el[keyA]! // aktueller wert
         //print("****                   eqindex 0: \(eqindex) cx: \(cx)")
         if cx == oldcx // Punkt mit gleichem cx, in equaldicarray einsetzen
         {
            equaldicarray.append(el)
            //print("eqindex A: \(eqindex) cx: \(cx)")
         }
         else // neuer Wert. 
         {
             // bisherigen equaldicarray in eaqualarray einfügen
            if equaldicarray.count > 0 // Array mit Inhalt
            {
               // equaldicarray mit gleichem cx nach cy sortieren
               var equaldicarraysorted = [[String:Int]]()
               equaldicarraysorted = equaldicarray.sorted {
                  guard let s1 = $0[keyB], let s2 = $1[keyB] else 
                  {
                     return false
                  }
                  if linear == 1 && eqindex % 2 == 0
                  {
                     return s1 > s2
                  }
                  else
                  {
                     return s1 < s2
                  }
               }

               //print("eqindex B: \(eqindex) cx: \(cx)")
               equalarray.append(equaldicarraysorted)
               equaldicarray.removeAll() // aufräumen
            }
            
            // neues Element in leerem equaldicarray einsetzen
            //print("eqindex C: \(eqindex) cx: \(cx)")
            equaldicarray.append(el)
            
            equaldic = el // aktualisieren
         }
         eqindex += 1
         if eqindex == origDicArray.count // letztes, einzelnes Element noch einsetzen
         {
            //print("eqindex last: \(eqindex)  cx: \(cx)")
            equalarray.append(equaldicarray)
         }
      }
        
      

      print("sortDicArray_opt equalarray anz: \(equalarray.count)")  
      
       for statusel in equalarray
       {
         //print("el: \(el)") 
      }
       
      print("equalarray anz: \(equalarray.count)") 
      for el in equalarray
      {
         if el.count > 0
         {
            
            for e in el
            {
               //print("\(e[keyA] ?? 0)\t \(e[keyB] ?? 0)")
               returnDicArray.append(e)
            }
         }
      }
      print("returnDicArray anz: \(returnDicArray.count)")  
      
  /*       for el in returnDicArray
         {
            print("\(el[keyA] ?? 0)\t \(el[keyB] ?? 0)")
         }
 */
      return returnDicArray
   }
   
   
   func sortDicArray(origDicArray:[[String:Int]], key0:String, key1: String, order:Bool) -> [[String:Int]]
   {
      print("sortDicArray")
      var returnDicArray:[[String:Int]] = [[String:Int]]()
      let keyarray = Array(origDicArray[0].keys)
//      let key0 = keyarray[0]
 //     let key1 = keyarray[1]
    //  print("keyarray: \(key0) \(key1)")
      if order == false // 
      {
         returnDicArray = origDicArray.sorted {
            guard let s1 = $0[key0], let s2 = $1[key0] else {
               return false
            }
            
            if s1 == s2 {
               guard let g1 = $0[key1], let g2 = $1[key1] else {
                  return false
               }
               return g1 < g2
            }
            
            return s1 < s2
         }

      }
      else
      {
         returnDicArray = origDicArray.sorted {
            guard let s1 = $0[key1], let s2 = $1[key1] else {
               return false
            }
            
            if s1 == s2 {
               guard let g1 = $0[key0], let g2 = $1[key0] else {
                  return false
               }
               return g1 < g2
            }
            
            return s1 < s2
         }

      }
      
      return returnDicArray
   }
   
   func clearteensy()
   {
      Schnittdatenarray.removeAll(keepingCapacity: true)
      if Schnittdatenarray.count == 0 // Array im Teensy loeschen
      {
         teensy.write_byteArray[25] = 1 //erstes Element
         teensy.write_byteArray[24] = 0xF1 // Stopp
         if teensy.dev_present() > 0
         {
            let senderfolg = teensy.send_USB()
            print("joystickAktion clear senderfolg: \(senderfolg)")
         }
         
      }
      
   }

   
   
   @IBAction func report_readSVG(_ sender: NSButton)
   {
      let SVG_URL = openFile()
      // https://stackoverflow.com/questions/10016475/create-nsscrollview-programmatically-in-an-nsview-cocoa
      guard let fileURL = SVG_URL else { return  }
      
      circledicarray.removeAll()
      
      //reading
      do {
         print("readSVG")
         
         let SVG_data = try String(contentsOf: fileURL, encoding: .utf8)
         //print("SVGdata: \(SVG_data)")
         let anz = SVG_data.count
         //print("SVGdata count: \(anz)")
         let SVG_text = SVG_data.components(separatedBy: "\n")
         // print("SVG_text: \(SVG_text)")
         let SVG_array = Array(SVG_text)
         var i=0
         var circle = 0
         var circlenummer = 0
         circlearray = [[Int]]()
         var circleelementarray = [Int]()
         
         var circleelementdic = [String:Int]()
         
         var z = 0
         for zeile in SVG_array
         {
       //     print("i: \(i) zeile: \(zeile)")
            let trimmzeile = zeile.trimmingCharacters(in: .whitespaces)
            if (trimmzeile.contains("circle") || trimmzeile.contains("ellipse"))
            {
              // print("i: \(i) trimmzeile: \(trimmzeile)")
               circle = 6
               circlenummer = i
               circleelementarray.removeAll()
               circleelementdic = [:]
            }
            if circle > 0
            {
               if circle < 5
               {
                  
                  //print("\t i: \(i) \tdata: \(trimmzeile)")
                  let zeilenarray = trimmzeile.split(separator: "=")
                  var zeilenindex = 0
                  for element in zeilenarray
                  {
                     
                     if element == "id" // 
                     {
                        circleelementarray.append(Int(circlenummer))
                        
                        continue
                     }
                     else if zeilenindex == 1
                     { 
                        //var partAraw = element.split(separator:"=")
                        //print("partAraw: \(partAraw)")
                        //var partA =  String(element.split(separator:"=")[1])
                        
                        var partB = element.replacingOccurrences(of: "\"", with: "")
                        partB = partB.replacingOccurrences(of: "/>", with: "")
                     //   print("i: \(i) \tz:\t \(z)\tpartB: \t\(partB)")
                       
                        z += 1
                        let partfloat = (partB as NSString).doubleValue * 1000000 // Vorbereitung Int
                        let partint = Int(partfloat)
                        if partint > 0xFFFFFFFF
                           {
                              print("partint zu  gross*** partfloat: \(partfloat) partint: \(partint)")
                        }
                        /*
                        let partintA:UInt8 = UInt8(UInt(partint) & 0x000000FF)
                        let partintB:UInt8 = UInt8((UInt(partint) & 0x0000FF00) >> 8)
                        let partintC:UInt8 = UInt8((UInt(partint) & 0x00FF0000) >> 16)
                        let partintD:UInt8 = UInt8((UInt(partint) & 0xFF000000) >> 24)
                        */
                  //      print(" partfloat: \(partfloat) partint: \(partint) partintA: \(partintA) partintB: \(partintB) partintC: \(partintC) partintD: \(partintD)")
                 //       print("  partint:  partintD: \(partintD)")
                        
                       // print("partB: \(partB) partfloat: \(partfloat) partint: \(partint)")
                        circleelementarray.append(partint)
                     }
                     zeilenindex += 1
                  }
               } // circle < 5
               if circle == 1
               {
                  //print("i: \(i) circleelementarray: \(circleelementarray)")
                  if circleelementarray.count > 0
                  {
                     circlearray.append(circleelementarray)
                  //   circleelementdic["id"] = circleelementarray[0]  // nirgends verwendet
                     circleelementdic["cx"] = circleelementarray[1]
                     circleelementdic["cy"] = circleelementarray[2]
                     
                     circledicarray.append(circleelementdic) // [[String:Int]]
                  }
               }
               
               circle -= 1
            }
                        i = i+1
         }
         print("report_readSVG circlearray count: \(circlearray.count)")
         var ii = 0
         for el in circlearray
         {
            print("\(ii) \(el[2])")
            ii += 1
         }
 
         
         /*
         print("report_readSVG circledicarray")
         var iii = 0
         for el in circledicarray
         {
            print("\(iii) \(el)")
            iii += 1
         }
*/
 
         
         //        print("PCB circlearray")
 //        print(circlearray)
//         let sorted = circlearray.sorted()
 //        print("PCB circledicarray")
 //        print(circledicarray)
         
      
     //    let sortedarray = circledicarray.sorted {$0["cx"]! < $1["cx"]!}
   /*
         var testarray = sortDicArray(origDicArray: circledicarray,key0:"cx", key1:"cy", order: true)
         for el in testarray{
            print("\(String(describing: el["cx"])) \(String(describing: el["cy"]))")
         }
   */      
        // print("testarray: \(testarray)")
         
         // https://useyourloaf.com/blog/sorting-an-array-of-dictionaries/
         var sortedarray = [[String:Int]]()
         var sortedarray_opt = [[String:Int]]()
     //    sortedarray_opt = sortDicArray_opt(origDicArray: circledicarray,key0:"cx", key1:"cy", order: false)
         
        // Doppelte Punkte suchen
         
         var doppelarray = [[String:Int]]()
         
         
         
         switch horizontal_checkbox.state
         {
         case .off:
            print("horizontal_checkbox: off")
            sortedarray = sortDicArray_opt(origDicArray: circledicarray,key0:"cx", key1:"cy", order: false)
          
         
         case .on:
            print("horizontal_checkbox: on")
            sortedarray = sortDicArray_opt(origDicArray: circledicarray,key0:"cx", key1:"cy", order: true)
         
         default:
            break
         }
         //print(circledicarray)

         /*
         print("report_readSVG sortedarray")
         iii = 0
         for el in sortedarray
         {
            print("\(iii) \(el)")
            iii += 1
         }
  
         */
         
         //let sortedarray = sorted(circledicarray, key=lambda k: k['cx'])
         //print("PCB sortedarray")
         //print(sortedarray)
         circlearray.removeAll()
         var zeilendicindex:Int = 0
         for zeilendic in sortedarray
         {
            let cx:Int = (zeilendic["cx"]!) 
            let cy:Int = (zeilendic["cy"]!) 
            
            //print("\(zeilendicindex) \(cx) \(cy)")
            let zeilendicarray = [zeilendicindex,cx,cy]
            circlearray.append(zeilendicarray)
            zeilendicindex += 1
         }
         
         print("report_readSVG circlearray vor.  count: \(circlearray.count)")
         for el in circlearray
         {
            
            print("\(el[0] )\t \(el[1] ) \(el[2])")
         }
         
         var doppelindex:Int = 0
         
         for datazeile in circlearray
         {
            if doppelindex < circlearray.count
            {
               let akt = circlearray[doppelindex]
               var next = [Int]()
               var n = 1
               while doppelindex + n < circlearray.count // naechste Zeilen absuchen
               {
                  next = circlearray[doppelindex+n]
                  var diffX:Double = (Double((next[1] - akt[1]))) 
                  //print(" zeile: \(doppelindex) n: \(n)\t diffX: \(diffX)")

                  if fabs(diffX) < maxdiff
                  {
                     //print("diffX < maxdiff  zeile: \(doppelindex) n: \(n)\t diffX: \(diffX)")
                     var diffY:Double = (Double((next[2] - akt[2])))
                     
                     if fabs(diffY) < maxdiff
                     {
                        //print(" *** diff zu klein akt zeile: \(doppelindex) n: \(n)\t diffX: \(diffX) diffY: \(diffY) ")
                        circlearray.remove(at: doppelindex + n)
                        n -= 1 // ein element weniger, next ist bei n-1
                     }
                     
                  }
                   n += 1
               }
               
         
         
         
         
            } // if < count
            doppelindex += 1
         } // for datazeile
         
         /*
         for datazeile in circlearray
         {
            if doppelindex < circlearray.count
            {
               let akt = circlearray[doppelindex]
               var next = [Int]()
               if doppelindex < circlearray.count-1
               {
                  next = circlearray[doppelindex+1]
                  var diffX:Double = (Double((next[1] - akt[1]))) * zoomfaktor
                  var diffY:Double = (Double((next[2] - akt[2]))) * zoomfaktor
                  print(" \(doppelindex)\t diffX: \(diffX) diffY: \(diffY) zeile: \(doppelindex)")
                  if fabs(diffX) < maxdiff && fabs(diffY) < maxdiff
                  {
                     print(" *** diff zu klein \(doppelindex)\t diffX: \(diffX) diffY: \(diffY) zeile: \(doppelindex)")
                  }
                  
                  while fabs(diffX) < maxdiff && fabs(diffY) < maxdiff
                  {
                     print(" datazeile *********    differenz null zeile: \(doppelindex)")
                     circlearray.remove(at: doppelindex + 1)
                     
                     if doppelindex < circlearray.count-1
                     {
                        next = circlearray[doppelindex+1]
                        diffX = (Double((next[1] - akt[1]))) * zoomfaktor
                        diffY = (Double((next[2] - akt[2]))) * zoomfaktor
                        
                     }
                     else
                     {
                        continue
                     }
                  }
                  
               } // if < count
               
               doppelindex += 1
            }
         }
*/
         
         print("report_readSVG circlearray nach. count: \(circlearray.count)")
         for el in circlearray
         {
            
            print("\(el[0] )\t \(el[1] )\t \(el[2])")
         }
         
         
         
         
         
         
         
         // circlearray: [[Int]] x,y
   //      schnittPfad?.addSVG_Pfadarray(newPfad: circlearray)
         let l = Plattefeld.setWeg(newWeg: circlearray, scalefaktor: 800, transform:  transformfaktor)
         fahrtweg.integerValue = l
         
         /*
         var CNC_DatendicArray = [[String:Any]]()
         for zeilendaten in circlearray
         {
            var zeilendic = [String:Any]()
            zeilendic["startpunktx"] = zeilendaten[1]
            zeilendic["startpunkty"] = zeilendaten[2]
            
            CNC_DatendicArray.append(zeilendic)
         }
         */
         print("report_readSVG CNC_DatendicArray")
         
         /*
         for el in CNC_DatendicArray
         {
            print("\(el["startpunktx"] ?? 0) \(el["startpunkty"] ?? 0)")
         }
          */
 //        var steuerdaten:[String:Int] = CNC.SteuerdatenVonDi(derDatenDic: CNC_DatendicArray[0])
         
      }
      catch 
      {
         print("readSVG error")
         /* error handling here */
         return
      }
      
      
   }
   
    
   
   func wegArrayMitWinkel(winkel:Double, distanz:Double) ->[UInt8]
   {
      print("wegMitWinkel")
      var maxsteps:Double = 0
      var weg = [Double]()
      let wegX = distanz * cos(winkel) * zoomfaktor
      let wegY = distanz * sin(winkel) * zoomfaktor
      
      var speed = speedFeld.intValue
      
      if ramp_OK_Check.state == NSControl.StateValue.on
      {
         speed *= 2
      }
 //     let propfaktor = 2834645.67 // 14173.23
      
      let start = [0,0]
      let ziel = [wegX,wegY]
      
      let zeit:Double = Double(distanz)/Double(speed) //   Schnittzeit für Distanz
      
      var schrittex = Double(stepsFeld.integerValue) * wegX 
      schrittex /= propfaktor
      var schrittexRound = round(schrittex)
      var schrittexInt:Int = 0
      if schrittexRound >= Double(Int.min) && schrittexRound < Double(Int.max)
      {
         //    print("schritteXInt OK: \(schrittexInt)")
         schrittexInt = Int(schrittexRound)
         if schrittexInt < 0 // negativer Weg
         {
            schrittexInt *= -1
            schrittexInt |= 0x80000000
         }
      }
      else
      {
         print("schritteXround zu gross")
      }
      var schrittey = Double(stepsFeld.integerValue) * wegY 
      schrittey /= propfaktor
      var schritteyRound = round(schrittey)
      var schritteyInt:Int = 0
      if schritteyRound >= Double(Int.min) && schritteyRound < Double(Int.max)
      {
         //    print("schritteXInt OK: \(schrittexInt)")
         schritteyInt = Int(schritteyRound)
         if schritteyInt < 0 // negativer Weg
         {
            schritteyInt *= -1
            schritteyInt |= 0x80000000
         }
      }
      else
      {
         print("schritteYround zu gross")
      }
      
      var wegschnittdatenarray:[UInt8] = schrittdatenvektor(sxInt:schrittexInt,syInt:schritteyInt, szInt:0, zeit:zeit  )// Array mit Daten fuer USB
      
      return wegschnittdatenarray
   }
   
   
   @IBAction func report_PCB_Daten(_ sender: NSButton)
   {
      // s SteuerdatenVonDic in CNC.m
      /*
       [KoordinatenTabelle addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:PositionA.x],@"ax",[NSNumber numberWithFloat:PositionA.y],@"ay",[NSNumber numberWithFloat:PositionB.x],@"bx", [NSNumber numberWithFloat:PositionB.y],@"by",[NSNumber numberWithInt:index],@"index",[NSNumber numberWithInt:0],@"lage",[NSNumber numberWithFloat:aktuellepwm*red_pwm],@"pwm",nil]];
       */
      print("report_PCB_Daten")
      
      var speed = speedFeld.intValue
      
       if ramp_OK_Check.state == NSControl.StateValue.on
      {
         speed *= 2
      }
 //     let propfaktor = 2834645.67 // 14173.23
      
      Schnittdatenarray.removeAll()
      
      var SchritteArray:[[String:Any]] = [[:]]
      zoomfaktor = zoomFeld.doubleValue
      let steps = stepsFeld.intValue // Schritte fuer 1mm
      var code:UInt8 = 0
      
      var maxsteps:Double = 0
      //var relevanteschritte
      var zeilenposition = 0
      var zeilenanzahl = circlearray.count
//      print("report_PCB_Daten circlearray vor doppelcheck count: \(zeilenanzahl)")
      var doppelindex:Int = 0
    
      /*
      
      for datazeile in circlearray
      {
         if doppelindex < circlearray.count
         {
            let akt = circlearray[doppelindex]
            var next = [Int]()
            if doppelindex < circlearray.count-1
            {
               next = circlearray[doppelindex+1]
               var diffX:Double = (Double((next[1] - akt[1]))) * zoomfaktor
               var diffY:Double = (Double((next[2] - akt[2]))) * zoomfaktor
               print(" datazeile diffX: \(diffX) diffY: \(diffY) zeile: \(doppelindex)")
               while fabs(diffX) < 50 && fabs(diffY) < 50
               {
                  print(" datazeile *********    differenz null zeile: \(doppelindex)")
                  circlearray.remove(at: doppelindex + 1)
                  
                  if doppelindex < circlearray.count-1
                  {
                     next = circlearray[doppelindex+1]
                     diffX = (Double((next[1] - akt[1]))) * zoomfaktor
                     diffY = (Double((next[2] - akt[2]))) * zoomfaktor
                     
                  }
                  else
                  {
                     continue
                  }
               }
               
            } // if < count
            
            doppelindex += 1
         }
      }
  */    
      zeilenanzahl = circlearray.count
      print("report_PCB_Daten circlearray nach doppelcheck count: \(zeilenanzahl)")

      /*
      var ii = 0
      for el in circlearray
      {
          print("\(ii) \(el)")
         ii += 1
      }
       */
       
      let l = Plattefeld.setWeg(newWeg: circlearray, scalefaktor: 800, transform:  transformfaktor)
      fahrtweg.integerValue = l

      
      for zeilenindex in stride(from: 0, to: circlearray.count-1, by: 1)
      {
         zeilenposition = 0
         if zeilenindex == 0
         {
            zeilenposition |= (1<<FIRST_BIT); // Erstes Element, Start
         }
         if zeilenindex == circlearray.count - 2
         {
            zeilenposition |= (1<<LAST_BIT);
         }
         
/*         
         if zeilenindex == 22
         {
               print("22")
         }
*/         
         let next = circlearray[zeilenindex+1]
         let akt = circlearray[zeilenindex]
         let diffX:Double = (Double((next[1] - akt[1]))) * zoomfaktor
        /*
         if diffX == 0
         {
            print(" diffX null zeile: \(zeilenindex)")
         }
         */
         let diffY:Double = (Double((next[2] - akt[2]))) * zoomfaktor
        /*
         if diffY == 0
         {
            print(" diffY null zeile: \(zeilenindex)")
         }
*/
         if diffX == 0 && diffY == 0
         {
            print(" stride *********    differenz null zeile: \(zeilenindex)")
            continue
         }
         
         // dic aufbauen
         var position:UInt8 = 0
         
         
         var zeilendic:[String:Any] = [:]
         
         let aktX = (akt[1]) //* stepsFeld.intValue
         let aktY = (akt[2]) //* stepsFeld.intValue
         let nextX = (next[1])
         let nextY = (next[2])
         
         let distanzX = Double(nextX - aktX) //* stepsFeld.floatValue
         let distanzY = Double(nextY - aktY) //* stepsFeld.floatValue
         //       var distanz = Double(hypotf(Float(distanzX),Float(distanzY)))
         //let distanz = (distanzX * distanzX + distanzY * distanzY).squareRoot()
         let distanz = (diffX * diffX + diffY * diffY).squareRoot()
         let distanzstring = String(distanz)
         //       print("distanz: \(distanz)  \(distanzstring)")
         zeilendic["startpunktx"] = aktX
         zeilendic["startpunkty"] = aktY
         zeilendic["endpunktx"] = nextX
         zeilendic["endpunkty"] = nextY
         zeilendic["distanz"] = distanz
         
         let zeit:Double = Double(distanz)/Double(speed) //   Schnittzeit für Distanz
         
         var schrittex = Double(stepsFeld.integerValue) * distanzX 
         schrittex /= propfaktor
         var schrittexRound = round(schrittex)
         var schrittexInt:Int = 0
         if schrittexRound >= Double(Int.min) && schrittexRound < Double(Int.max)
         {
        //    print("schritteXInt OK: \(schrittexInt)")
            schrittexInt = Int(schrittexRound)
            if Double(schrittexInt) > maxsteps
            {
               maxsteps = Double(schrittexInt)
            }
            if schrittexInt < 0 // negativer Weg
            {
                              schrittexInt *= -1
                              schrittexInt |= 0x80000000
            }
         }
         else
         {
            print("schritteXround zu gross")
         }
          
         zeilendic["schrittex"] = schrittexInt
         
         var schrittey = Double(stepsFeld.integerValue) * distanzY  
         //let schrittey = distanzY
         schrittey /= propfaktor
         var schritteyRound = round(schrittey)
         var schritteyInt:Int = 0
         if schritteyRound >= Double(Int.min) && schritteyRound < Double(Int.max)
         {
        //    print("schritteYInt OK: \(schritteyInt)")
            schritteyInt = Int(schritteyRound)
            if Double(schritteyInt) > maxsteps
            {
               maxsteps = Double(schritteyInt)
            }

            if schritteyInt < 0 // negativer Weg
            {
                              schritteyInt *= -1
                              schritteyInt |= 0x80000000
            }
         }
         else
         {
            print("schritteYInt zu gross")
         }
         zeilendic["schrittey"] = schritteyInt
//         print("schrittey: \(schrittey) ")
         
         zeilendic["code"] = code
         if zeilenindex == 0
         {
            position |= (1<<FIRST_BIT) // Start markieren
         }
         if zeilenindex == circlearray.count - 1
         {
            position |= (1<<LAST_BIT)
         }
         zeilendic["position"] = position
         zeilendic["zoomfaktor"] = zoomfaktor
         SchritteArray.append(zeilendic)
         var zeilenschnittdatenarray = [UInt8]()
         // Schritte X
         //print("schrittex: \(schrittexInt) ")
         let schrittexA = UInt8(schrittexInt & 0x000000FF)
         let schrittexB = UInt8((schrittexInt & 0x0000FF00) >> 8)
         let schrittexC = UInt8((schrittexInt & 0x00FF0000) >> 16)
         let schrittexD = UInt8((schrittexInt & 0xFF000000) >> 24)
         zeilenschnittdatenarray.append(schrittexA)
         zeilenschnittdatenarray.append(schrittexB)
         zeilenschnittdatenarray.append(schrittexC)
         zeilenschnittdatenarray.append(schrittexD)
         
//         let delayx:Double = (zeit * 1000.0/Double((schrittexInt & 0x0FFFFFFF))) // Vorzeichen-Bit weg
         let delayx:Double = (zeit / Double((schrittexInt & 0x0FFFFFFF))) // Vorzeichen-Bit weg
         
         let delayxIntround = round(delayx)
         var delayxInt = 0
         if delayxIntround >= Double(Int.min) && delayxIntround < Double(Int.max)
         {
            // print("delayxInt OK")
            delayxInt = Int(delayxIntround)
         }
       
         
   //      print("delayx: \(delayx) \t delayxInt: \(delayxInt) \tdelayy: \(delayy) \t delayyInt: \(delayyInt)")
         
         let delayxA = UInt8(delayxInt & 0x000000FF)
         let delayxB = UInt8((delayxInt & 0x0000FF00) >> 8)
         let delayxC = UInt8((delayxInt & 0x00FF0000) >> 16)
         let delayxD = UInt8((delayxInt & 0xFF000000) >> 24)
         //print("delayxA: \(delayxA) ")
         //print("delayxB: \(delayxB) ")
         //print("delayxC: \(delayxC) ")
         //print("delayxD: \(delayxD) ")
         zeilenschnittdatenarray.append(delayxA)
         zeilenschnittdatenarray.append(delayxB)
         zeilenschnittdatenarray.append(delayxC)
         zeilenschnittdatenarray.append(delayxD)
         
         // Schritte Y
         //print("*** schritteyInt: \(schritteyInt) ")
         let schritteyA = UInt8(schritteyInt & 0x000000FF)
        // print("schritteyA: \(schritteyA) ")
         let schritteyB = UInt8((schritteyInt & 0x0000FF00) >> 8)
         //print("schritteyB: \(schritteyB) ")
         let schritteyC = UInt8((schritteyInt & 0x00FF0000) >> 16)
         //print("schritteyC: \(schritteyC) ")
         let schritteyD = UInt8((schritteyInt & 0xFF000000) >> 24)
         //print("schritteyA: \(schritteyD) ")
         zeilenschnittdatenarray.append(schritteyA)
         zeilenschnittdatenarray.append(schritteyB)
         zeilenschnittdatenarray.append(schritteyC)
         zeilenschnittdatenarray.append(schritteyD)
         
         var schritteY_check:UInt32 = UInt32(schritteyA) | UInt32(schritteyB)<<8 | UInt32(schritteyC)<<16 | UInt32(schritteyD)<<24;
  //       print("schritteY_check: \(schritteY_check) ")
         
         let delayy:Double = (zeit / Double((schritteyInt & 0x0FFFFFFF)))
     //    let delayy:Double = (zeit * 1000.0/Double((schritteyInt & 0x0FFFFFFF)))
         let delayyIntround = round(delayy)
         var delayyInt = 0
         if delayyIntround >= Double(Int.min) && delayyIntround < Double(Int.max)
         {
            // print("schritteYInt OK")
            delayyInt = Int(delayyIntround)
         }

         let delayyA = UInt8(delayyInt & 0x000000FF)
         
         
        
         let delayyB = UInt8((delayyInt & 0x0000FF00) >> 8)
         let delayyC = UInt8((delayyInt & 0x00FF0000) >> 16)
         let delayyD = UInt8((delayyInt & 0xFF000000) >> 24)
         zeilenschnittdatenarray.append(delayyA)
         zeilenschnittdatenarray.append(delayyB)
         zeilenschnittdatenarray.append(delayyC)
         zeilenschnittdatenarray.append(delayyD)

         // Motor C Schritte
         zeilenschnittdatenarray.append(0)
         zeilenschnittdatenarray.append(0)
         zeilenschnittdatenarray.append(0)
         zeilenschnittdatenarray.append(0)
         // Motor C delay
         zeilenschnittdatenarray.append(0)
         zeilenschnittdatenarray.append(0)
         zeilenschnittdatenarray.append(0)
         zeilenschnittdatenarray.append(0)
         
         // code, 
         zeilenschnittdatenarray.append(UInt8(code))
         // position im Ablauf
         zeilenschnittdatenarray.append(UInt8(zeilenposition))
         
         // zeilennummer
         var zeilenindexh = UInt8((zeilenindex & 0xFF00)>>8)
         var zeilenindexl = UInt8((zeilenindex & 0x00FF))

         zeilenschnittdatenarray.append(zeilenindexh)
         zeilenschnittdatenarray.append(zeilenindexl)
         
         // motorstatus
         var motorstatus:UInt8 = 0
         
         if (fabs(schritteyRound) > fabs(schrittexRound)) // wer hat mehr schritte x
         {
            maxsteps = fabs(schritteyRound)
            
            motorstatus = (1<<MOTOR_B)
         }
         else 
         {
            maxsteps = fabs(schrittexRound)
            motorstatus = (1<<MOTOR_A)
          }
         
         // Testphase
  //       motorstatus = (1<<MOTOR_A)
         
  //       print("motorstatus: \(motorstatus) maxsteps: \(maxsteps)")
         zeilenschnittdatenarray.append(motorstatus)
         zeilenschnittdatenarray.append(77) // Pöatzhalter PWM
         
         // timerintervall
         let timerintervall = timerintervallFeld.integerValue
         zeilenschnittdatenarray.append(UInt8((timerintervall & 0xFF00)>>8))
         zeilenschnittdatenarray.append(UInt8(timerintervall & 0x00FF))
         
  //       print("zeilenschnittdatenarray:\t\(zeilenschnittdatenarray)")
         if schrittexInt == 0 && schritteyInt == 0
         {
            print("******  schrittexInt  0 schritteyInt  0 zeilenindex: \(zeilenindex)")
            print("\t\tdiffX: \(diffX) diffY: \(diffY)")
         }
         if zeilenschnittdatenarray.count > 0
         {
            if !(schrittexInt == 0 && schritteyInt == 0)
            {
               Schnittdatenarray.append(zeilenschnittdatenarray)
            }
         }
      } // for Zeilendaten
      
 //     print("Schnittdatenarray:\t\(Schnittdatenarray)")
     
      print("report_PCBDaten Schnittdatenarray count: \(Schnittdatenarray.count)")
      var i = 0
      for el in Schnittdatenarray
       {
         let iH = (i & 0xFF00) >> 8
         let iL = i & 0x00FF
         let index = (Int(el[26]) * 256) + Int(el[27])
   //      print("\(iH) \(iL) index: \(index)")

  //       print("\(i) \(el)")
         i += 1
      }
      
      /* 
      for el in SchritteArray
      {
         print(el)
   //      print("\(el["startpunktx"] ?? 0)\t \(el["startpunkty"] ?? 0) \t\(el["endpunktx"] ?? 0)\t \(el["endpunkty"] ?? 0) \t\(el["distanz"] ?? 0)\t \(el["schrittex"] ?? 0)\t\(el["schrittey"] ?? 0) \t\(el["zoomfaktor"] ?? 0) \t\(el["code"] ?? 0)")
       //  print("\(el["distanz"] ?? 0)\t \(el["schrittex"] ?? 0)\t\(el["schrittey"] ?? 0) \t\(el["zoomfaktor"] ?? 0) \t\(el["code"] ?? 0)")
       
      }
*/   
   }  
   @IBAction func report_send_TextDaten(_ sender: NSButton)
   {
      print("report_send_TextDaten")
      clearteensy()
      let dx = dxFeld.doubleValue
      let dy = dyFeld.doubleValue
      
      print("report_send_TextDaten dx: \(dx) dy: \(dy)")
      lastklickposition.x = 0
      lastklickposition.y = 0
      let punkt:NSPoint = NSMakePoint(CGFloat(dx), CGFloat(dy))
      var wegarray = wegArrayMitWegXY(wegx: Double(punkt.x - CGFloat(lastklickposition.x)),wegy:Double(punkt.y - CGFloat(lastklickposition.y)))
 //     var wegarray = wegArrayMitWegXY(wegx:dx, wegy:dy)
      
      wegarray[32] = DEVICE_JOY
      Schnittdatenarray.removeAll(keepingCapacity: true)
      cncstepperposition = 0
      if Schnittdatenarray.count == 0 // Array im Teensy loeschen
      {
         teensy.write_byteArray[25] = 1 //erstes Element
         teensy.write_byteArray[24] = 0xE0 // Stopp
         if teensy.dev_present() > 0
         {
            let senderfolg = teensy.send_USB()
            print("joystickAktion clear senderfolg: \(senderfolg)")
         }
         
      }
      wegarray[25] = 3 
      
      wegarray[24] = 0xB3
      
      var zeilenposition:UInt8 = 0
      Schnittdatenarray.append(wegarray)
     
      /*
      for zeilenindex in stride(from: 0, to: Schnittdatenarray.count-1, by: 1)
      {
         zeilenposition = 0
         if zeilenindex == 0
         {
            
            zeilenposition |= (1<<FIRST_BIT); // Erstes Element, Start
         }
         if zeilenindex == Schnittdatenarray.count - 1
         {
            zeilenposition |= (1<<LAST_BIT);
         }
         
         Schnittdatenarray[zeilenindex][25] = zeilenposition // innere Elemente
         
      }
 */
      print("sendTextdaten Schnittdatenarray: \(Schnittdatenarray)")
      
      if Schnittdatenarray.count == 1
      {
         print("report_send_TextDaten start CNC")
         write_CNC_Abschnitt()   
         
         if teensy.readtimervalid() == true
         {
            //print("PCB readtimer valid vor")
         }
         else 
         {
            //print("PCB readtimer not valid vor")
            var start_read_USB_erfolg = teensy.start_read_USB(true)
         }
      }
   }// report_send_TextDaten
 
   @IBAction func report_flip_TextDaten(_ sender: NSButton)
   {
      print("report_flip_TextDaten")
      let buf = dxFeld.doubleValue
      dxFeld.doubleValue = dyFeld.doubleValue
      dyFeld.doubleValue = buf
   }
   
   @IBAction func report_inv_TextDaten(_ sender: NSButton)
   {
      print("report_inv_TextDaten")
      let buf = dxFeld.doubleValue
      dxFeld.doubleValue = dxFeld.doubleValue * (-1)
      dyFeld.doubleValue = dyFeld.doubleValue * (-1)
   }
   
   
   @IBAction func report_dx_Stepper(_ sender: NSStepper) // 
   {
      print("report_dx_Stepper IntVal: \(sender.integerValue)")
      
      let intpos = sender.integerValue 
      dxFeld.doubleValue = Double(intpos)
      
      
   }

   @IBAction func report_dy_Stepper(_ sender: NSStepper) // 
   {
      print("report_dy_Stepper IntVal: \(sender.integerValue)")
      
      let intpos = sender.integerValue 
      dyFeld.doubleValue = Double(intpos)
      
      
   }

   
   @IBAction func report_goXY(_ sender: NSButton) // 
   {
      // left: 1, right: 2, up: 3, down: 4
      print("Joystick report_goXY tag: \(sender.tag)")
      var dx = 0
      var dy = 0
      let schrittweite = 10
      switch sender.tag
      {
      case 1: // right
         dx = schrittweite
         break
      case 2: // up
         dy = schrittweite
         break
      case 3: // left
         dx = schrittweite * -1
         break
      case 4: // down
         dy = schrittweite * -1
         break
      default:
         break
      }
      lastklickposition.x = 0
      lastklickposition.y = 0
      let punkt:NSPoint = NSMakePoint(CGFloat(dx), CGFloat(dy))
      var wegarray = wegArrayMitWegXY(wegx: Double(punkt.x - CGFloat(lastklickposition.x)),wegy:Double(punkt.y - CGFloat(lastklickposition.y)))
      //     var wegarray = wegArrayMitWegXY(wegx:dx, wegy:dy)
      
      wegarray[32] = DEVICE_JOY
      Schnittdatenarray.removeAll(keepingCapacity: true)
      cncstepperposition = 0
      if Schnittdatenarray.count == 0 // Array im Teensy loeschen
      {
         wegarray[25] = 1 //erstes Element
         teensy.write_byteArray[24] = 0xE0 // Stopp
         if teensy.dev_present() > 0
         {
            let senderfolg = teensy.send_USB()
            print("joystickAktion report_goXY senderfolg: \(senderfolg)")
         }
         
      }
      wegarray[32] = DEVICE_JOY
      var zeilenposition:UInt8 = 0
      Schnittdatenarray.append(wegarray)
      /*
       for zeilenindex in stride(from: 0, to: Schnittdatenarray.count-1, by: 1)
       {
       zeilenposition = 0
       if zeilenindex == 0
       {
       
       zeilenposition |= (1<<FIRST_BIT); // Erstes Element, Start
       }
       if zeilenindex == Schnittdatenarray.count - 1
       {
       zeilenposition |= (1<<LAST_BIT);
       }
       
       Schnittdatenarray[zeilenindex][25] = zeilenposition // innere Elemente
       
       }
       */
      print("wegarray: \t\(wegarray)")
      
      if Schnittdatenarray.count == 1
      {
         print("report_goXY start CNC")
         write_CNC_Abschnitt()   
         if teensy.readtimervalid() == true
         {
            //print("PCB readtimer valid vor")
         }
         else 
         {
            //print("PCB readtimer not valid vor")
            var start_read_USB_erfolg = teensy.start_read_USB(true)
         }
      }
      
   }
   
   
   
   
   
   
   
   @IBAction func report_send_Daten(_ sender: NSButton)
   {
      print("report_send_Daten")
      
      var antwort:NSApplication.ModalResponse
      /*
       func dialogOKCancel(question: String, text: String) -> Bool {
       let alert = NSAlert()
       alert.messageText = question
       alert.informativeText = text
       alert.alertStyle = .warning
       alert.addButton(withTitle: "OK")
       alert.addButton(withTitle: "Cancel")
       return alert.runModal() == .alertFirstButtonReturn
       }
let answer = dialogOKCancel(question: "Ok?", text: "Choose your answer.")
 */
      let alert = NSAlert()
      alert.messageText = "CNC-Task starten?"
      alert.informativeText = "Der Teensy ist noch nicht eingesteckt"
      alert.alertStyle = .warning
      alert.addButton(withTitle: "Einstecken und einschalten")
      alert.addButton(withTitle: "Zurück")
      antwort = alert.runModal()
      print("antwort: \(antwort)")
      switch antwort
      {
         case .alertFirstButtonReturn: // rawValue: 1000
      
         print("antwort 1")
         break
   
         case .alertSecondButtonReturn: // rawValue: 1001
      
         print("antwort 2")
         return;
         break
         
         default:
         break
      
      }
     
 //     Plattefeld.stepperposition = 0
      cncstepperposition = 0
 //     Plattefeld.setStepperposition(pos:cncstepperposition)
      let anzabschnitte = Schnittdatenarray.count
         
//      Schnittdatenarray[0][26] = UInt8((anzabschnitte & 0xFF00) >> 8)
 //     Schnittdatenarray[0][27] = UInt8(anzabschnitte & 0x00FF)
 
      var i = 0
      for linie in Schnittdatenarray
      {
         print("\(i) \(linie)")
         i += 1
      }
      
      
      write_CNC_Abschnitt()
      
  //    readtimer?.invalidate() 
      
      
      if teensy.readtimervalid() == true
      {
         //print("PCB readtimer valid vor")
      }
      else 
      {
         //print("PCB readtimer not valid vor")
         var start_read_USB_erfolg = teensy.start_read_USB(true)
      }

      
      

//      var readtimernote:[String:Int] = ["cncstepperposition":1]
//      readtimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(USB_read(timer:)), userInfo: readtimernote, repeats: true)

      
   } // report_send_Daten
   
   
   @IBAction func report_clear(_ sender: NSButton)
   {
      print("Joystick report_clear")
      teensy.write_byteArray[24] = 0xF1
      //write_CNC_Abschnitt()
  //    if (usbstatus > 0)
  //    {
         let senderfolg = teensy.send_USB()
         print("Joystick report_clear senderfolg: \(senderfolg)")
  //    }
      teensy.clear_writearray()
      cncstepperposition = 0
      Schnittdatenarray.removeAll(keepingCapacity: true)
      Joystickfeld.clearWeg()
      Joystickfeld.needsDisplay = true
      lastklickposition.x = 0
      lastklickposition.y = 0

      print("reportclear homeX: \(homeX) homeY: \(homeY)")
      homeX = 0
      homeY = 0
      homexFeld.integerValue = homeX
      homeyFeld.integerValue = homeY

   }
   
   func write_CNC_Abschnitt()
   {
      print("Joystick write_CNC_Abschnitt cncstepperposition: \(cncstepperposition) Schnittdatenarray.count: \(Schnittdatenarray.count) ")
     
      if cncstepperposition == Schnittdatenarray.count
      {
         print("+++          write_CNC_Abschnitt cncstepperposition ist Schnittdatenarray.count >> END\n")
         
         return
      }
      if cncstepperposition < Schnittdatenarray.count
      {
         if CNC_HALT_Knopf.state == .on
         {
            // alles OFF
            print("write_CNC_Abschnitt HALT")
         }
         else
         {
            teensy.write_byteArray.removeAll()
            var tempSchnittdatenArray:[UInt8] = Schnittdatenarray[cncstepperposition]
            for el in tempSchnittdatenArray
            {
               teensy.write_byteArray.append(el)
            }
           print("cncstepperposition: \(cncstepperposition) write_byteArray: \n\(teensy.write_byteArray) byte32: \(teensy.write_byteArray[32])")
            
            
            let senderfolg = teensy.send_USB()
    //        print("write_CNC_Abschnitt senderfolg: \(senderfolg)")
 
            //          print("0: \(tempSchnittdatenArray[0]) ")
  //          print("1: \(tempSchnittdatenArray[1]) ")
  //          print("2: \(tempSchnittdatenArray[2]) ")
  //          print("3: \(tempSchnittdatenArray[3]) ")
            
            
            var schritteAX:UInt32 = UInt32(tempSchnittdatenArray[0]) | UInt32(tempSchnittdatenArray[1])<<8 | UInt32(tempSchnittdatenArray[2])<<16 | UInt32((tempSchnittdatenArray[3] & 0x7F))<<24;
            if (tempSchnittdatenArray[3] & 0x80) > 0
            {
 //              print("Motor A schritteX negativ")
            }
            
 //           print("8: \(tempSchnittdatenArray[8]) ")
 //           print("9: \(tempSchnittdatenArray[9]) ")
 //           print("10: \(tempSchnittdatenArray[10]) ")
 //           print("11: \(tempSchnittdatenArray[11]) ")
            
            var schritteAY:UInt32 = UInt32(tempSchnittdatenArray[8]) | UInt32(tempSchnittdatenArray[9])<<8 | UInt32(tempSchnittdatenArray[10])<<16 | UInt32((tempSchnittdatenArray[11] & 0x7F))<<24;
            /*
            if (tempSchnittdatenArray[11] & 0x80) > 0
            {
               print("Motor B schritteY negativ")
               
            }
 */
            print("schritteX: \(schritteAX) schritteY: \(schritteAY)")
            homeX += Int(schritteAX)
            homeY += Int(schritteAY)
   //        print("Joystick homeX: \(homeX) homeY: \(homeY)")
            homexFeld.integerValue = homeX
            homeyFeld.integerValue = homeY

            
            cncstepperposition += 1
            
         } // else

      }// if count
      
   }
   
   @objc override func usbstatusAktion(_ notification:Notification) 
   {
      let info = notification.userInfo
     // print("PCB usbstatusAktion:\t \(info)")
      let status:Int = info!["usbstatus"] as! Int // 
      print("Joystick usbstatusAktion:\t \(status)")
 //     usbstatus = Int32(status)
      
   }

   @objc override func usbattachAktion(_ notification:Notification) 
   {
      let info = notification.userInfo
     // print("PCB usbattachAktion:\t \(info)")
      let status:Int = info!["attach"] as! Int // 
     print("Joystick usbattachAktion:\t \(status)")
      if status == USBREMOVED
      {
         
        // USB_OK_Feld.image = notokimage
      }
      usbstatus = Int32(status)
      
   }
   
   @IBAction func report_home(_ sender: NSButton)
   {
      clearteensy()
      print("Joystick report_home homex: \(homeX) homey: \(homeY)")
      var dx = homexFeld.doubleValue * -1 
      var dy = homeyFeld.doubleValue * -1
      print("Joystick report_home dx: \(dx) dy: \(dy)")
      //      dx = 10
      //      dy = 0
      lastklickposition.x = 0
      lastklickposition.y = 0
      cncstepperposition = 0
      var pfeilwegarray = wegArrayMitWegXY(wegx:Double(dx), wegy:Double(dy))
      
      
      for z in 0 ... pfeilwegarray.count-1
      {
         teensy.write_byteArray[z] = pfeilwegarray[z]
         // print("\(pfeilwegarray[z])")
      }
      print("\(pfeilwegarray)")
      teensy.write_byteArray[24] = 0xA5
      teensy.write_byteArray[25] = 3
      
      
      //    homeX += Int(dx)
      //    homeY += Int(dy)
      print("Joystick report_home homeX: \(homeX) homeY: \(homeY)")
      //    homexFeld.integerValue = homeX
      //    homeyFeld.integerValue = homeY
      
      
      let senderfolg = teensy.send_USB()
      
      
   }

   
   @objc  override func mausstatusAktion(_ notification:Notification)
   {
      let info = notification.userInfo
      //print("joystick mausstatusAktion:\t \(String(describing: info))")
      let devtag = info?["devtag"] as! Int
      if devtag == 2
      {

      let pfeiltag = info?["tag"] as! Int
      var schrittweite = info?["schrittweite"] as! Int
      var dx:Int = 0
      var dy:Int = 0
      var vorzeichenx = 0;
      var vorzeicheny = 0;
 //     print("joystick mausstatusAktion devtag:\t \(devtag ) pfeiltag:\t \(pfeiltag) schrittweite: \(schrittweite)\t")
      
         switch pfeiltag
         {
         case 1: // right
            dx = schrittweite
            break
         case 2: // up
            dy = schrittweite
            break
         case 3: // left
            dx = schrittweite * (-1)
            vorzeichenx = 1
            break
         case 4: // down
            dy = schrittweite * (-1)
            vorzeicheny = 1
            break
            
          case 11:    // links oben
            dx = schrittweite * (-1)
            dy = schrittweite
            break;
         case 22:    // rechts oben
            dx = schrittweite
            dy = schrittweite
            break;
         case 33:    // rechts unten
            dx = schrittweite
            dy = schrittweite * (-1)
            break;
         case 44:    // rechts unten
            dx = schrittweite * (-1)
            dy = schrittweite * (-1)
            break;
            
            
            
            
         default:
            break
            
            
         }
         print("mausstatusAktion dx:\(dx) dy:\(dy)")
         var pfeilwegarray = wegArrayMitWegXY(wegx:Double(dx), wegy:Double(dy))
         
         pfeilwegarray[32] = 2
         
         
         for z in 0 ... pfeilwegarray.count-1
         {
            teensy.write_byteArray[z] = pfeilwegarray[z]
            // print("\(pfeilwegarray[z])")
         }
         print("pfeilwegarray: \n\(pfeilwegarray)")
         teensy.write_byteArray[24] = 0xA5
         
         
         //      homeX += Int(dx)
         //     homeY += Int(dy)
         print("mausstatusaktion homeX: \(homeX) homeY: \(homeY)")
         //     homexFeld.integerValue = homeX
         //     homeyFeld.integerValue = homeY
         
         
         let senderfolg = teensy.send_USB()
      }
   }

   
   func schrittdatenvektor(sxInt:Int,syInt:Int, szInt:Int, zeit:Double) -> [UInt8]
   {
      let sxInt_raw = (sxInt & 0x0FFFFFFF) // sxInt_raw ist >= 0
      let syInt_raw = (syInt & 0x0FFFFFFF)
      print("\n                            Joystick schrittdatenvektor sxInt: \(sxInt) syInt: \(syInt) zeit: \(zeit)")
      print("sxInt_raw: \(sxInt_raw) syInt_raw: \(syInt_raw)")
      var vektor = [UInt8]()
      //print("sxInt: \(sxInt) ")
      let sxA = UInt8(sxInt & 0x000000FF)
      let sxB = UInt8((sxInt & 0x0000FF00) >> 8)
      let sxC = UInt8((sxInt & 0x00FF0000) >> 16)
      let sxD = UInt8((sxInt & 0xFF000000) >> 24)
      //print("schrittdatenvektor sxInt: \(sxInt) sxA: \(sxA) sxB: \(sxB)")
      vektor.append(sxA)
      vektor.append(sxB)
      vektor.append(sxC)
      vektor.append(sxD)
      
      let dx:Double = (zeit / Double((sxInt_raw))) // Vorzeichen-Bit weg
       // dx >= 0 
      
      let dxIntround = round(dx)
      var dxInt = 0
      if dxIntround >= Double(Int.min) && dxIntround < Double(Int.max)
      {
         // print("delayxInt OK")
         dxInt = Int(dxIntround)
      }
      let dxA = UInt8(dxInt & 0x000000FF)
      let dxB = UInt8((dxInt & 0x0000FF00) >> 8)
      vektor.append(dxA)
      vektor.append(dxB)
      
      print("\n***   Fehlerkorrektur X")
      var korrekturintervallx:Int = 0
      if sxInt != 0
      {
         let vorzeichenx = (sxInt & 0x80000000)
         
         //         print("vorzeichenx: \(vorzeichenx)") // Richtung der Bewegung
         
         print("sxInt_raw: \(sxInt_raw) dx: \(dx) dxInt: \(dxInt)")
         let kontrolledoublex = Int(Double(sxInt_raw) * dx) // Zeit,  Kontrolle mit Double-Wert von dx
         let kontrolleintx = sxInt_raw * dxInt //           // Zeit,  Kontrolle mit Int-Wert von dx
         var diffx = Int(kontrolledoublex) - kontrolleintx // Zeitdifferenz, Rundungsfehler
         print("kontrolledoublex: \(kontrolledoublex) kontrolleintx: \(kontrolleintx) diffx: \(diffx)")
         if diffx == 0
         {
            diffx = 1
         }
         if diffx != 0
         {
            var intervallx = Double(kontrolleintx / diffx ) // Korrekturintervall zum einschieben oder entfernen von Schritten
            
            let controlx = Double(sxInt_raw) / intervallx  
            korrekturintervallx = Int(round(intervallx))  // Rundungsfehler aufteilen ueber Abschnitt: 
            // alle korrekturintervallx dexInt incrementieren oder decrementieren
            print("korrekturintervallx: \(korrekturintervallx) controlx: \(controlx)")
            
            if korrekturintervallx < 0 // negative korrektur
            {
                          print("korrekturintervallx negativ")
               korrekturintervallx *= -1
               korrekturintervallx |= 0x8000
            }
                   print("korrekturintervallx mit Vorzeichenkorr: \(korrekturintervallx) \n")
            
         } // diffx not 0
      }
      print("korrekturintervallx mit Vorzeichenkorr: \(korrekturintervallx) \n")
      vektor.append(UInt8(korrekturintervallx & 0x00FF))
      vektor.append(UInt8((korrekturintervallx & 0xFF00)>>8))


      
      let syA = UInt8(syInt & 0x000000FF)
      let syB = UInt8((syInt & 0x0000FF00) >> 8)
      let syC = UInt8((syInt & 0x00FF0000) >> 16)
      let syD = UInt8((syInt & 0xFF000000) >> 24)
      vektor.append(syA)
      vektor.append(syB)
      vektor.append(syC)
      vektor.append(syD)
      
      let dy:Double = (zeit / Double((syInt & 0x0FFFFFFF))) // Vorzeichen-Bit weg
      
      let dyIntround = round(dy)
      var dyInt = 0
      if dyIntround >= Double(Int.min) && dyIntround < Double(Int.max)
      {
         dyInt = Int(dyIntround)
      }
      let dyA = UInt8(dyInt & 0x000000FF)
      let dyB = UInt8((dyInt & 0x0000FF00) >> 8)
      vektor.append(dyA)
      vektor.append(dyB)

      
      print("+++   Fehlerkorr Y")
      var korrekturintervally:Int = 0
      if syInt != 0
      {
         let vorzeicheny = (syInt & 0x80000000)
         
         //         print("vorzeicheny: \(vorzeicheny)")
         
         print("syInt_raw: \(syInt_raw) dy: \(dy) dyInt: \(dyInt)")
         let kontrolledoubley = Int(Double(syInt_raw) * dy)
         let kontrolleinty = syInt_raw * dyInt
         var diffy = (kontrolledoubley) - kontrolleinty
         print("kontrolledoubley: \(kontrolledoubley) kontrolleinty: \(kontrolleinty) diffy: \(diffy)")
         if diffy == 0
         {
            diffy = 1
         }
         
         if diffy != 0
         {
            let intervally = Double(kontrolleinty / diffy)
            
            korrekturintervally = Int(round(intervally))
            //       
            let controly = Double(syInt_raw) / intervally
            print("korrekturintervally: \(korrekturintervally) controly_ \(controly)\n")
            
            if korrekturintervally < 0 // negative korrektur
            {
                         print("korrekturintervally negativ")
               korrekturintervally *= -1
               korrekturintervally |= 0x8000
            }
                    print("korrekturintervally mit Vorzeichenkorr: \(korrekturintervally) \n")
         } // diffy not 0
      }
      print("korrekturintervally mit Vorzeichenkorr: \(korrekturintervally) \n")
      vektor.append(UInt8(korrekturintervally & 0x00FF))
      vektor.append(UInt8((korrekturintervally & 0xFF00)>>8))
      
      // Motor C Schritte
      vektor.append(0)
      vektor.append(0)
      vektor.append(0)
      vektor.append(0)
      // Motor C delay
      vektor.append(0)
      vektor.append(0)
      vektor.append(0)
      vektor.append(0)
      
      vektor.append(0) // el 24, code
      vektor.append(0) // el 25, lage
      
      vektor.append(0) // el 26, zeilenindexh
      vektor.append(0) // el 27, zeilenindexl
      
      // motorstatus
      var motorstatus:UInt8 = 0
      var maxsteps:Double = 0
      if (fabs(dyIntround) > fabs(dxIntround)) // wer hat mehr schritte x
      {
         maxsteps = fabs(dyIntround)
         motorstatus = (1<<MOTOR_B)
      }
      else 
      {
         maxsteps = fabs(dxIntround)
         motorstatus = (1<<MOTOR_A)
      }
      vektor.append(motorstatus)
      vektor.append(77) // Pöatzhalter PWM
      
      let timerintervall = timerintervallFeld.integerValue
      vektor.append(UInt8((timerintervall & 0xFF00)>>8))
      vektor.append(UInt8(timerintervall & 0x00FF))
      vektor.append(DEVICE_JOY)
      print("schrittdatenvektor sxInt: \(sxInt) dxInt: \(dxInt) syInt: \(syInt) dyInt: \(dyInt) zeit: \(zeit)")
      return vektor
   }
   
   func wegArrayMitWegXY(wegx:Double, wegy:Double) ->[UInt8]
   {
      zoomfaktor = zoomFeld.doubleValue
      print("Joystick wegMitXY wegX: \(wegx) wegY: \(wegy)")
      var maxsteps:Double = 0
      var weg = [Double]()
      
      let distanzX = wegx *  1000000
      let distanzY = wegy *  1000000
      
      let wegX = distanzX * zoomfaktor 
      let wegY = distanzY * zoomfaktor 
      let distanz = (wegX*wegX + wegY*wegY).squareRoot()
      var speed = speedFeld.intValue
      
      if ramp_OK_Check.state == NSControl.StateValue.on
      {
         speed *= 2
      }
      let propfaktor = 2834645.67 // 14173.23
      
      
      let start = [0,0]
      let ziel = [wegX,wegY]
      
      let zeit:Double = Double(distanz)/Double(speed) //   Schnittzeit für Distanz
      
      var schrittex = Double(stepsFeld.integerValue) * distanzX  
      schrittex /= propfaktor
      var schrittexRound = round(schrittex)
      var schrittexInt:Int = 0
      if schrittexRound >= Double(Int.min) && schrittexRound < Double(Int.max)
      {
         //    print("schritteXInt OK: \(schrittexInt)")
         schrittexInt = Int(schrittexRound)
         if schrittexInt < 0 // negativer Weg
         {
 //           print("schrittexInt negativ")
            schrittexInt *= -1
            schrittexInt |= 0x80000000
         }
      }
      else
      {
         print("schritteXround zu gross")
      }
      var schrittey = Double(stepsFeld.integerValue) * distanzY 
      schrittey /= propfaktor
      var schritteyRound = round(schrittey)
      var schritteyInt:Int = 0
      if schritteyRound >= Double(Int.min) && schritteyRound < Double(Int.max)
      {
         //    print("schritteXInt OK: \(schrittexInt)")
         schritteyInt = Int(schritteyRound)
         if schritteyInt < 0 // negativer Weg
         {
//            print("schritteyInt negativ")
            schritteyInt *= -1
            schritteyInt |= 0x80000000
         }
      }
      else
      {
         print("schritteYround zu gross")
      }
      
      var wegschnittdatenarray:[UInt8] = schrittdatenvektor(sxInt:schrittexInt,syInt:schritteyInt, szInt:0, zeit:zeit  )// Array mit Daten fuer USB
      
      return wegschnittdatenarray
   }
    
 // MARK: joystick
   @objc override func joystickAktion(_ notification:Notification) 
   {
//      print("Joystick joystickAktion usbstatus:\t \(usbstatus) selectedDevice: \(selectedDevice) ident: \(self.view.identifier)")
      let sel = NSUserInterfaceItemIdentifier.init(selectedDevice)
     // if (selectedDevice == self.view.identifier)
      if (sel == self.view.identifier)
      {
         print("                                        Joystick joystickAktion passt")
         clearteensy()
         print("joystickAktion lastklickposition.x: \(lastklickposition.x) lastklickposition.y: \(lastklickposition.y) ")
         let info = notification.userInfo
         let punkt:CGPoint = info?["punkt"] as! CGPoint
         let wegindex:Int = info?["index"] as! Int // 
         let first:Int = info?["first"] as! Int
         var zeilenposition:UInt8 = 0
         //       print("Basis joystickAktion:\t \(punkt)")
         print("x: \(punkt.x) y: \(punkt.y) index: \(wegindex) first: \(first)")
         
         var wegarray = wegArrayMitWegXY(wegx: Double(punkt.x - CGFloat(lastklickposition.x)),wegy:Double(punkt.y - CGFloat(lastklickposition.y)))
         
         let diffx = Double(punkt.x - CGFloat(lastklickposition.x))
         let diffy = Double(punkt.y - CGFloat(lastklickposition.y))
         
         print("diffx: \(diffx) diffy: \(diffy) ")
         
         
         wegarray[32] = DEVICE_JOY
 //        lastklickposition.x = UInt16(punkt.x)
 //        lastklickposition.y = UInt16(punkt.y)
         /*
         if Schnittdatenarray.count == 0 // Array im Teensy loeschen
         {
            wegarray[25] = 1 //erstes Element
            teensy.write_byteArray[24] = 0xE0 // Stopp
            if teensy.dev_present() > 0
            {
               let senderfolg = teensy.send_USB()
              print("joystickAktion clear senderfolg: \(senderfolg)")
            }

         }
 */
         //teensy.write_byteArray[24] = 0xB5
         
   //      wegarray[25] |= (1<<LAST_BIT);//letztes Element
         if Schnittdatenarray.count == 0 // noch leer, wegarray ist erstes element
         {
            print("joystickAktion FIRST")
            wegarray[25] = 1  // erstes Element
   //         lastklickposition.x = 0
   //         lastklickposition.y = 0

            
         }
         else
         {
            lastklickposition.x = UInt16(punkt.x)
            lastklickposition.y = UInt16(punkt.y)

            print("joystickAktion NOT FIRST")
            wegarray[25] = 0 
         }
         wegarray[24] = 0xB3
         lastklickposition.x = UInt16(punkt.x)
         lastklickposition.y = UInt16(punkt.y)
      
         // Weg nur 1 Element Test
         //wegarray[25] = 3 
         
         
         print("wegarray: \(wegarray)")
         Schnittdatenarray.append(wegarray)
         print("Schnittdatenarray count: \t\(Schnittdatenarray.count)")
         
         for zeilenindex in stride(from: 0, to: Schnittdatenarray.count, by: 1)
         {
            zeilenposition = 0
            if zeilenindex == 0
            {
               
               zeilenposition |= (1<<FIRST_BIT); // Erstes Element, Start
            }
            if zeilenindex == Schnittdatenarray.count - 1
            {
               zeilenposition |= (1<<LAST_BIT);
            }
            print("zeilenindex: \(zeilenindex) zeilenposition: \(zeilenposition)")
            Schnittdatenarray[zeilenindex][25] = zeilenposition // innere Elemente
            Schnittdatenarray[zeilenindex][26] = UInt8((zeilenindex & 0xFF00) >> 8)
            Schnittdatenarray[zeilenindex][27] = UInt8(zeilenindex & 0x00FF)
            
            
            print("Schnittdatenarray: \(Schnittdatenarray[zeilenindex]) ")
         }
 
         print("joystickaktion Schnittdatenarray: \(Schnittdatenarray) ")
         
         if Schnittdatenarray.count == 1
         {
            
            print("\njoystickaktion start CNC")
            write_CNC_Abschnitt()   
            
       //     teensy.start_read_USB(true)
            if teensy.readtimervalid() == true
            {
               print("Joystick readtimer valid")
               
            }
            else 
            {
               print("Joystick readtimer not valid")
               
               var start_read_USB_erfolg = teensy.start_read_USB(true)
            }

         
         }
         
 //        print("Nach: lastklickposition.x: \(lastklickposition.x) lastklickposition.y: \(lastklickposition.y) ")
         
         return
            
            //        var  weg0:UInt16 = 0
            //         var  weg1:UInt16 = 0
            //         var  achse2:UInt16 = 0
            
            teensy.write_byteArray[0] = SET_ROB // Code 
         
         // Horizontal Pot0
         let w = Double(Joystickfeld.bounds.size.width) // Breite Joystickfeld
         let faktorw:Double = 1 //(Pot0_Slider.maxValue - Pot0_Slider.minValue) / w
         //      print("w: \(w) faktorw: \(faktorw)")
         var x = Double(punkt.x)
         if (x > w)
         {
            x = w
         }
         
         //       goto_x.integerValue = Int(Double(x*faktorw))
         //      joystick_x.integerValue = Int(Double(x*faktorw))
         //       goto_x_Stepper.integerValue = Int(Double(x*faktorw))
         let weg0 = UInt32(Double(x*faktorw) *   stepsFeld.doubleValue)
         //print("x: \(x) weg0: \(weg0)")
         teensy.write_byteArray[SCHRITTEX_A] = UInt8((weg0 & 0xFF00) >> 8) // hb
         teensy.write_byteArray[SCHRITTEX_B] = UInt8((weg0 & 0x00FF) & 0xFF) // lb
         
         
         let h = Double(Joystickfeld.bounds.size.height)
         let faktorh:Double = 1 //(Pot1_Slider.maxValue - Pot1_Slider.minValue) / h
         
         let faktorz = 1
         //     print("h: \(h) faktorh: \(faktorh)")
         var y = Double(punkt.y)
         if (y > h)
         {
            y = h
         }
         let z = 0
         //       goto_y.integerValue = Int(Double(y*faktorh))
         //       joystick_y.integerValue = Int(Double(y*faktorh))
         //        goto_y_Stepper.integerValue = Int(Double(y*faktorh))
         //  let weg1 = UInt16(Double(y*faktorh) * FAKTOR1)
         let weg1 = UInt32(Double(y*faktorh) * stepsFeld.doubleValue)
         //print("y: \(y) weg1: \(weg1)")
         teensy.write_byteArray[DELAYX_A] = UInt8((weg1 & 0xFF00) >> 8) // hb
         teensy.write_byteArray[DELAYX_B] = UInt8((weg1 & 0x00FF) & 0xFF) // lb
         
         let weg2 =  UInt32(Double(z*faktorz)  * stepsFeld.doubleValue)
         teensy.write_byteArray[SCHRITTEY_A] = UInt8((weg2 & 0xFF00) >> 8) // hb
         teensy.write_byteArray[SCHRITTEY_B] = UInt8((weg2 & 0x00FF) & 0xFF) // lb
         
         
         let message:String = info?["message"] as! String
         if ((message == "mousedown") && (first >= 0))// Polynom ohne mousedragged
         {
            teensy.write_byteArray[0] = SET_RING
            let anz = schnittPfad?.anzahlPunkte()
            if (wegindex > 1)
            {
               print("")
               print("basis joystickAktion cont weg0: \(weg0) weg1: \(weg1)  weg2: \(weg2) anz: \(String(describing: anz)) wegindex: \(wegindex)")
               
               let lastposition = schnittPfad?.pfadarray.last
               
               let lastx:Int = Int(lastposition!.x)
               let nextx:Int = Int(weg0)
               let hypx:Int = (nextx - lastx) * (nextx - lastx)
               
               let lasty:Int = Int(lastposition!.y)
               let nexty:Int = Int(weg1)
               let hypy:Int = (nexty - lasty) * (nexty - lasty)
               
               let lastz:Int = Int(lastposition!.z)
               let nextz:Int = Int(weg2)
               let hypz:Int = (nextz - lastz) * (nextz - lastz)
               
               print("joystickAktion lastx: \(lastx) nextx: \(nextx) lasty: \(lasty) nexty: \(nexty)")
               
               let hyp:Double = (sqrt((Double(hypx + hypy + hypz))))
               var anzahlsteps:UInt16 = 0
               //             let anzahlsteps = hyp/schrittweiteFeld.doubleValue
               //             print("Basis joystickAktion hyp: \(hyp) anzahlsteps: \(anzahlsteps) ")
               
               teensy.write_byteArray[schrittezA] = UInt8((Int(hyp) & 0xFF00) >> 8) // hb
               teensy.write_byteArray[schrittezB] = UInt8((Int(hyp) & 0x00FF) & 0xFF) // lb
               
               teensy.write_byteArray[delayzC] = UInt8((Int(anzahlsteps) & 0xFF00) >> 8) // hb
               teensy.write_byteArray[delayzD] = UInt8((Int(anzahlsteps) & 0x00FF) & 0xFF) // lb
               
               teensy.write_byteArray[delayzA] = UInt8(((wegindex-1) & 0xFF00) >> 8) // hb // hb // Start, Index 0
               teensy.write_byteArray[delayzB] = UInt8(((wegindex-1) & 0x00FF) & 0xFF) // lb
               
               print("Joystick joystickAktion hypx: \(hypx) hypy: \(hypy) hypz: \(hypz) hyp: \(hyp)")
               
            }
            else
            {
               print("basis joystickAktion start weg0: \(weg0) weg1: \(weg1)  weg2: \(weg2) anz: \(anz) wegindex: \(wegindex)")
               teensy.write_byteArray[schrittezA] = 0 // hb // Start, keine Hypo
               teensy.write_byteArray[schrittezB] = 0 // lb
               teensy.write_byteArray[delayzA] = 0 // hb // Start, Index 0
               teensy.write_byteArray[delayzB] = 0 // lb
               
            }
            
            //           schnittPfad?.addPosition(newx: weg0, newy: weg1, newz: 0)
         }
         
         //       if (teensy.dev_present > 0 )
         //     {
         //         let senderfolg = teensy.send_USB()
         //         print("joystickAktion senderfolg: \(senderfolg)")
         //       }
      }
      else
      {
         print("Joystick joystickAktion passt nicht")
      }
      
   }
   
   
   @objc override func newDataAktion(_ notification:Notification) 
   {
      // analog readUSB() in USB_Stepper
      
  /*    
      //print("newDataAktion")
      let lastData = teensy.getlastDataRead()
      
     // print("lastData:\t \(lastData[1])\t\(lastData[2])   ")
      var ii = 0
      while ii < 10
      {
  //       print("\(lastData[ii])\t")
         ii = ii+1
      }
      
      //let u = ((Int32(lastData[1])<<8) + Int32(lastData[2]))
      //print("hb: \(lastData[1]) lb: \(lastData[2]) u: \(u)")
      
     // let info = notification.userInfo
      
      //print("info: \(String(describing: info))")
 */
      print("Joystick newDataAktion")
      var data:[UInt8] = notification.userInfo?["data"] as! [UInt8]
      print("von teensy: data: \(String(describing: data)) ") // data: Optional([0, 9, 51, 0,....
      var i = 0
            
      let taskcode = data[0]
      let codehex = String(format:"%02X", taskcode)
      
       
      if taskcode == 0
         {
            print("newDataAktion taskcode: NULL")
            return
      }
      let device = data[24]
      
      print("\n\t                            Joystick newDataAktion taskcode hex: \(codehex) device: \(device)")
    
      var notificationDic = [String:Any]()
      
      let abschnittnummer:Int = Int((data[5] << 8) | data[6])
      let ladeposition = data[8]
      
 //     Plattefeld.setStepperposition(pos:abschnittnummer)
      
//      print("Joystick newDataAktion  taskcode: \(taskcode) hex: \(codehex) abschnittnummer: \(abschnittnummer) ladeposition: \(ladeposition)")
      let timeintervall =  Int((data[14] << 8) | data[15])
      
      var AnschlagSet:IndexSet = IndexSet()
      let nc = NotificationCenter.default
      
      // MARK: DEVICE_JOY
      
 //     device = DEVICE_JOY
      if device == DEVICE_JOY
      
      {
         switch taskcode
         {
         case 0xA1: 
            print("Joystick newDataAktion  A1") // sendstatus 3, Abschnitt fertig
            let abschnittnummer = Int((data[5] << 8) | data[6])
            print("Joystick newDataAktion  A1 abschnittnummer: \(abschnittnummer) Schnittdatenarray.count: \(Schnittdatenarray.count)")
            if abschnittnummer <= (Schnittdatenarray.count - 1)
            {
               print("A1 newDataAktion noch Daten da")
               write_CNC_Abschnitt()
            }
            else
            {
               print("A1 newDataAktion keine Daten mehr")
               if teensy.readtimervalid() == true
               {
                  teensy.readtimer?.invalidate()
               }
               Joystickfeld.clearWeg()
               Joystickfeld.needsDisplay = true
               cncstepperposition = 0

            }

            
            
            break // A1
         case 0xAD:
            print("Joystick newDataAktion  AD TASK END ")
            var abschnittnum = Int((data[5] << 8) | data[6])
            
            let ladepos =  Int(data[8] )
            print("Joystick newDataAktion  AD abschnittnum: \(abschnittnum) ladepos: \(ladepos) Schnittdatenarray.count: \(Schnittdatenarray.count) cncstepperposition: \(cncstepperposition)")
            //         Plattefeld.setStepperposition(pos:ladepos+1)
            abschnittnum += 1
            if abschnittnum < (Schnittdatenarray.count - 1)
            {
               print("AD newDataAktion noch Daten da")
               write_CNC_Abschnitt()
            }
            else
            {
               print("AD newDataAktion keine Daten mehr da")
            }
            // print("newDataAktion  AD abschnittnummer: \(abschnittnum) ladepos: \(ladepos)")
            notificationDic["taskcode"] = taskcode
   //         nc.post(name:Notification.Name(rawValue:"usbread"),
   //                 object: nil,
   //                 userInfo: notificationDic)        
            break
            
         case 0xAF:
            
            print("Joystick newDataAktion  AF next ")
            let abschnittnum = Int((data[5] << 8) | data[6])
            let ladepos =  Int(data[8] )
            print("newDataAktion  AF abschnittnum: \(abschnittnum) ladepos: \(ladepos)")
            
            break
            
         case 0xE1:
            print("newDataAktion Joystick E1 mouseup HALT")
            //Schnittdatenarray.removeAll()
            if teensy.readtimervalid() == true
            {
                teensy.readtimer?.invalidate()
            }
            //cncstepperposition = 0
            break
            
         case 0xEA:
            print("newDataAktion  home gemeldet")
            break
         case 0xD0:
            print("Joystick newDataAktion  letzter Abschnitt abschnittnummer: \(abschnittnummer)")
            //      Plattefeld.setStepperposition(pos:abschnittnummer)
            let ladepos =  Int(data[8] )
            notificationDic["taskcode"] = taskcode
            nc.post(name:Notification.Name(rawValue:"usbread"),
                    object: nil,
                    userInfo: notificationDic)
            break
          
         case 0xD1:
            // 
            print("DEVICE 2 newDataAktion  D1 Schnittdatenarray.count: \(Schnittdatenarray.count) cncstepperposition; \(cncstepperposition)")
            let abschnittnummer = Int((data[5] << 8) | data[6])
            print("Joystick newDataAktion  D1 abschnittnummer: \(abschnittnummer) Schnittdatenarray.count: \(Schnittdatenarray.count)")
            if abschnittnummer < (Schnittdatenarray.count - 1)
            {
               print("D1 newDataAktion noch Daten da")
 //              write_CNC_Abschnitt()
            }
            else
            {
               print("D1 newDataAktion keine Daten mehr")
   //            if readtimer?.isValid == true
   //            {
   //               readtimer?.invalidate()
   //            }
  //             Joystickfeld.clearWeg()
  //             Joystickfeld.needsDisplay = true
   //            cncstepperposition = 0
               
            }
            //write_CNC_Abschnitt()
            
            
         case 0xB2: // Joystick
         
            print("DEVICE 2 newDataAktion  B2 ") 
            
            
         break;
            
         default:
            //Plattefeld.setStepperposition(pos:abschnittnummer)
            break
         }// switch taskcode
         
         
         
         //      print("newDataAktion writecncabschnitt")
         
         // **************************************
  //       write_CNC_Abschnitt()
         // **************************************
         
         //      print("newDataAktion  end\n\n")
  
      } // if DEVICE_MILL

   } // newDataAktion
   
    @IBAction  func report_horizontalCheckbox(_ sender: NSButton)
    {
      print("report_horizontalCheckbox IntVal: \(sender.intValue)")
      var sortedarray = [[String:Int]]()
      switch sender.state
      {
      case .off:
         print("horizontal_checkbox: off")
         sortedarray = sortDicArray_opt(origDicArray: circledicarray,key0:"cx", key1:"cy", order: false)
      case .on:
         print("horizontal_checkbox: on")
         sortedarray = sortDicArray_opt(origDicArray: circledicarray,key0:"cx", key1:"cy", order: true)
         
      default:
         break
      }
      var circlearray = [[Int]]()
      var zeilendicindex:Int = 0
      for zeilendic in sortedarray
      {
         let cx:Int = (zeilendic["cx"]!)
         let cy:Int = (zeilendic["cy"]!)
         
         //print("\(zeilendicindex) \(cx) \(cy)")
         let zeilendicarray = [zeilendicindex,cx,cy]
         circlearray.append(zeilendicarray)
         zeilendicindex += 1
      }
      
      let l = Plattefeld.setWeg(newWeg: circlearray, scalefaktor: 400 , transform:  transformfaktor)
      self.fahrtweg.integerValue = l
   }
   
   @IBAction  func report_linearCheckbox(_ sender: NSButton)
   {
      print("report_linearCheckbox IntVal: \(sender.intValue)")
      let state = horizontal_checkbox.state
      var order = false
      if state == .on
      {
         order = true
      }
      var sortedarray = [[String:Int]]()
      sortedarray = sortDicArray_opt(origDicArray: circledicarray,key0:"cx", key1:"cy", order: order)
      
        var circlearray = [[Int]]()
      var zeilendicindex:Int = 0
      for zeilendic in sortedarray
      {
         let cx:Int = (zeilendic["cx"]!)
         let cy:Int = (zeilendic["cy"]!)
         
         //print("\(zeilendicindex) \(cx) \(cy)")
         let zeilendicarray = [zeilendicindex,cx,cy]
         circlearray.append(zeilendicarray)
         zeilendicindex += 1
      }
      
      let l = Plattefeld.setWeg(newWeg: circlearray, scalefaktor: 400 , transform:  transformfaktor)
      self.fahrtweg.integerValue = l
   }

   
   //MARK: Slider 0
   @IBAction override func report_Slider0(_ sender: NSSlider)
   {
      teensy.write_byteArray[0] = SET_0 // Code 
      print("report_Slider0 IntVal: \(sender.intValue)")
      
      let pos = sender.doubleValue
      
      let intpos = UInt16(pos * FAKTOR0)
      let Ustring = formatter.string(from: NSNumber(value: intpos))
      
      //print("report_Slider0 pos: \(pos) intpos: \(intpos)  Ustring: \(Ustring ?? "0")")
      // Pot0_Feld.stringValue  = Ustring!
      Pot0_Feld.integerValue  = Int(intpos)
      Pot0_Stepper_L.integerValue  = Int(sender.minValue) // Stepper min setzen
      Pot0_Stepper_L_Feld.integerValue = Int(sender.minValue)
      Pot0_Stepper_H.integerValue  = Int(sender.maxValue) // Stepper max setzen
      Pot0_Stepper_H_Feld.integerValue = Int(sender.maxValue)
      
      teensy.write_byteArray[SCHRITTEX_A] = UInt8((intpos & 0xFF00) >> 8) // hb
      teensy.write_byteArray[SCHRITTEX_B] = UInt8((intpos & 0x00FF) & 0xFF) // lb
      
      if (usbstatus > 0)
      {
         let senderfolg = teensy.send_USB()
         print("rBasis report_Slider0 senderfolg: \(senderfolg)")
      }
   }
   @IBAction override func report_Pot0_Stepper_L(_ sender: NSStepper) // untere Grenze
   {
      print("report_Pot0_Stepper_L IntVal: \(sender.integerValue)")
      
      let intpos = sender.integerValue 
      Pot0_Stepper_L_Feld.integerValue = intpos
      
      Pot0_Slider.minValue = sender.doubleValue 
      print("report_Pot0_Stepper_L Pot0_Slider.minValue: \(Pot0_Slider.minValue)")
      
   }
   
   @IBAction override func report_Pot0_Stepper_H(_ sender: NSStepper)// Obere Grenze
   {
      print("report_Pot0_Stepper_H IntVal: \(sender.integerValue)")
      
      let intpos = sender.integerValue 
      Pot0_Stepper_H_Feld.integerValue = intpos
      
      Pot0_Slider.maxValue = sender.doubleValue 
      print("report_Pot0_Stepper_H Pot0_Slider.maxValue: \(Pot0_Slider.maxValue)")
      
   }
   @IBAction override func report_set_Pot0(_ sender: NSTextField)
   {
      teensy.write_byteArray[0] = SET_0 // Code 
      
      // senden mit faktor 1000
      //let u = Pot0_Feld.doubleValue 
      let Pot0_wert = Pot0_Feld.doubleValue * 100
      let Pot0_intwert = UInt(Pot0_wert)
      
      let Pot0_HI = (Pot0_intwert & 0xFF00) >> 8
      let Pot0_LO = Pot0_intwert & 0x00FF
      
      print("report_set_Pot0 Pot0_wert: \(Pot0_wert) Pot0 HI: \(Pot0_HI) Pot0 LO: \(Pot0_LO) ")
      let 
      intpos = sender.intValue 
      self.Pot0_Slider.doubleValue = Pot0_wert //sender.doubleValue
      self.Pot0_Stepper_L.doubleValue = Pot0_wert//sender.doubleValue
      
      teensy.write_byteArray[SCHRITTEX_A] = UInt8(Pot0_LO)
      teensy.write_byteArray[SCHRITTEX_B] = UInt8(Pot0_HI)
      
      if (usbstatus > 0)
      {
         let senderfolg = teensy.send_USB()
         if (senderfolg < BUFFER_SIZE)
         {
            print("report_set_Pot0 U: %d",senderfolg)
         }
      }
   }
   

   
   
   // MARK:Slider 1
   @IBAction override func report_Slider1(_ sender: NSSlider)
   {
      teensy.write_byteArray[0] = SET_1 // Code
      print("report_Slider1 IntVal: \(sender.intValue)")
      
      let pos = sender.doubleValue
      let intpos = UInt16(pos * FAKTOR0)
      let Istring = formatter.string(from: NSNumber(value: intpos))
      print("intpos: \(intpos) IString: \(Istring)") 
      Pot1_Feld.integerValue  = Int(intpos)
      
      Pot1_Stepper_L.integerValue  = Int(sender.minValue) // Stepper min setzen
      Pot1_Stepper_L_Feld.integerValue = Int(sender.minValue)
      Pot1_Stepper_H.integerValue  = Int(sender.maxValue) // Stepper max setzen
      Pot1_Stepper_H_Feld.integerValue = Int(sender.maxValue)
      
      
      
      teensy.write_byteArray[DELAYX_A] = UInt8((intpos & 0xFF00) >> 8) // hb
      teensy.write_byteArray[DELAYX_B] = UInt8((intpos & 0x00FF) & 0xFF) // lb
      
      if (usbstatus > 0)
      {
         let senderfolg = teensy.send_USB()
      }
   }
   
   @IBAction override func report_Pot1_Stepper_L(_ sender: NSStepper) // untere Grenze
   {
      print("report_Pot1_Stepper_L IntVal: \(sender.integerValue)")
      
      let intpos = sender.integerValue 
      Pot1_Stepper_L_Feld.integerValue = intpos
      
      Pot1_Slider.minValue = sender.doubleValue 
      print("report_Pot1_Stepper_L Pot1_Slider.minValue: \(Pot1_Slider.minValue)")
      
   }
   
   @IBAction override func report_Pot1_Stepper_H(_ sender: NSStepper)// Obere Grenze
   {
      print("report_Pot1_Stepper_H IntVal: \(sender.integerValue)")
      
      let intpos = sender.integerValue 
      Pot1_Stepper_H_Feld.integerValue = intpos
      
      Pot1_Slider.maxValue = sender.doubleValue 
      print("report_Pot1_Stepper_H Pot1_Slider.maxValue: \(Pot1_Slider.maxValue)")
      
   }
// MARK:goto  
   @IBAction override func report_goto_0(_ sender: NSButton)
   {
      print("report_goto_0")
      var x = goto_x.integerValue
      if x > Int(Pot0_Slider.maxValue)
      {
         x = Int(Pot0_Slider.maxValue)
      }
      var y = goto_y.integerValue
      if y > Int(Pot1_Slider.maxValue)
      {
         y = Int(Pot1_Slider.maxValue)
      }
      
      print("report_goto_0  x: \(x) y: \(y)")
      self.goto_0(x:Double(x),y:Double(y),z: 0)
   }
   
   override func goto_0(x:Double, y:Double, z:Double)
   {
      teensy.write_byteArray[0] = GOTO_0
      print("goto_0 x: \(x) y: \(y)")
      // achse 0
      let intposx = UInt16(x * FAKTOR0)
      goto_x_Stepper.integerValue = Int(x) //Int(intposx)
      teensy.write_byteArray[SCHRITTEX_A] = UInt8((intposx & 0xFF00) >> 8) // hb
      teensy.write_byteArray[SCHRITTEX_B] = UInt8((intposx & 0x00FF) & 0xFF) // lb
      
      // Achse 1
      let intposy = UInt16(y * FAKTOR1)
      goto_y_Stepper.integerValue = Int(y)
      teensy.write_byteArray[DELAYX_A] = UInt8((intposy & 0xFF00) >> 8) // hb
      teensy.write_byteArray[DELAYX_B] = UInt8((intposy & 0x00FF) & 0xFF) // lb
      
      if (usbstatus > 0)
      {
         let senderfolg = teensy.send_USB()
      }
      
      
   }
   @IBAction override func report_goto_x_Stepper(_ sender: NSStepper)
   {
      //teensy.write_byteArray[0] = SET_0 // Code 
      print("report_goto_x_Stepper IntVal: \(sender.intValue)")
      let intpos = sender.integerValue 
      goto_x.integerValue = intpos
      let intposx = UInt16(Double(intpos ) * FAKTOR0)
      teensy.write_byteArray[SCHRITTEX_A] = UInt8((intposx & 0xFF00) >> 8) // hb
      teensy.write_byteArray[SCHRITTEX_B] = UInt8((intposx & 0x00FF) & 0xFF) // lb
      
      let w = Double(Joystickfeld.bounds.size.width) // Breite Joystickfeld
      let invertfaktorw:Double = Double(w / (Pot0_Slider.maxValue - Pot0_Slider.minValue)) 
      
      var currpunkt:NSPoint = Joystickfeld.weg.currentPoint
      currpunkt.x = CGFloat(Double(intpos) * invertfaktorw)
      Joystickfeld.weg.line(to: currpunkt)
      Joystickfeld.needsDisplay = true 
      if (usbstatus > 0)
      {
         let senderfolg = teensy.send_USB()
      }
   }
   
   @IBAction override func report_goto_y_Stepper(_ sender: NSStepper)
   {
      //teensy.write_byteArray[0] = SET_0 // Code 
      //print("report_goto_y_Stepper IntVal: \(sender.intValue)")
      let intpos = sender.integerValue 
      goto_y.integerValue = intpos
      let intposy = UInt16(Double(intpos ) * FAKTOR0)
      teensy.write_byteArray[DELAYX_A] = UInt8((intposy & 0xFF00) >> 8) // hb
      teensy.write_byteArray[DELAYX_B] = UInt8((intposy & 0x00FF) & 0xFF) // lb
      
      let h = Double(Joystickfeld.bounds.size.width) // Breite Joystickfeld
      let invertfaktorh:Double = Double(h / (Pot1_Slider.maxValue - Pot1_Slider.minValue)) 
      
      var currpunkt:NSPoint = Joystickfeld.weg.currentPoint
      currpunkt.y = CGFloat(Double(intpos) * invertfaktorh)
      Joystickfeld.weg.line(to: currpunkt)
      Joystickfeld.needsDisplay = true 
      
      if (usbstatus > 0)
      {
         let senderfolg = teensy.send_USB()
      }
   }
   
    
   
   
   
// MARK: Ring
   
   
   @IBAction override func report_clear_Ring(_ sender: NSButton)
   {
      print("report_clear_Ring ")
      /*
      teensy.write_byteArray[0] = CLEAR_RING
      teensy.write_byteArray[SCHRITTEX_A] = UInt8(((ACHSE0_START) & 0xFF00) >> 8) // hb
      teensy.write_byteArray[SCHRITTEX_B] = UInt8(((ACHSE0_START) & 0x00FF) & 0xFF) // lb
      
      teensy.write_byteArray[DELAYX_A] = UInt8(((ACHSE1_START) & 0xFF00) >> 8) // hb
      teensy.write_byteArray[DELAYX_B] = UInt8(((ACHSE1_START) & 0x00FF) & 0xFF) // lb
      
      teensy.write_byteArray[SCHRITTEY_A] = UInt8(((ACHSE2_START) & 0xFF00) >> 8) // hb
      teensy.write_byteArray[SCHRITTEY_B] = UInt8(((ACHSE2_START) & 0x00FF) & 0xFF) // lb
      
      teensy.write_byteArray[schrittezA] = 0 // hb
      teensy.write_byteArray[schrittezB] = 0 // lb
      
      teensy.write_byteArray[delayzA] = 0 // hb
      teensy.write_byteArray[delayzB] = 0 // lb
 */
      Joystickfeld.clearWeg()
      schnittPfad?.clearPfadarray()
      lastklickposition.x = 0
      lastklickposition.y = 0

      //Schnittdatenarray.removeAll(keepingCapacity: true)
      if (usbstatus > 0)
      {
 //        let senderfolg = teensy.send_USB()
      }
      
   }

   
   
   
    
} // ViewController
