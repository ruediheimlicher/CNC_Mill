//
//  rBasis.swift
//  Robot_Interface
//
//  Created by Ruedi Heimlicher on 06.08.2019.
//  Copyright © 2019 Ruedi Heimlicher. All rights reserved.
//

import Cocoa

class rPCB: rViewController 
{
   
   var circledicarray = [[String:Int]]()
   
  // var servoPfad = rServoPfad()
 //  var usbstatus: Int32 = 0
   
 //  var teensy = usb_teensy()
   
   @IBOutlet weak var readSVG_Knopf: NSButton!
   
   @IBOutlet weak var horizontal_checkbox: NSButton!
   @IBOutlet weak var fahrtweg: NSTextField!
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
   
   
   var achse0_start:UInt16  = ACHSE0_START;
   var achse0_max:UInt16   = ACHSE0_MAX;
   
   
   
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
   
   
   
   
   let U_DIVIDER:Float = 9.8
   let ADC_REF:Float = 3.26
   
   let ACHSE0_BYTE_H = 4
   let ACHSE0_BYTE_L = 5
   
   let ACHSE1_BYTE_H = 6
   let ACHSE1_BYTE_L = 7
   
   
   let ACHSE2_BYTE_H = 16
   let ACHSE2_BYTE_L = 17
   
   
   let ACHSE3_BYTE_H = 18
   let ACHSE3_BYTE_L = 19
   
   let HYP_BYTE_H = 22 // Hypotenuse
   let HYP_BYTE_L = 23
   
   let INDEX_BYTE_H = 24
   let INDEX_BYTE_L = 25
   
   let STEPS_BYTE_H = 26
   let STEPS_BYTE_L = 27
*/
   
   override func viewDidAppear() 
   {
      print ("PCB viewDidAppear selectedDevice: \(selectedDevice)")
   }
   
   override func viewDidLoad() 
    {
        super.viewDidLoad()
        // Do view setup here.
      self.view.window?.acceptsMouseMovedEvents = true
      //let view = view[0] as! NSView
      self.view.wantsLayer = true
      
      hintergrundfarbe  = NSColor.init(red: 0.15, 
                                    green: 0.15, 
                                    blue: 0.85, 
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
  //    NotificationCenter.default.addObserver(self, selector:#selector(joystickAktion(_:)),name:NSNotification.Name(rawValue: "joystick"),object:nil)
      NotificationCenter.default.addObserver(self, selector:#selector(usbstatusAktion(_:)),name:NSNotification.Name(rawValue: "usb_status"),object:nil)
      
      
      // servoPfad
      servoPfad?.setStartposition(x: 0x800, y: 0x800, z: 0)
      
      // Pot 0
      /*
      Pot0_Slider.integerValue = Int(ACHSE0_START)
      Pot0_Feld.integerValue = Int(ACHSE0_START)
      let intpos0 = UInt16(Float(ACHSE0_START) * FAKTOR0)
      Pot0_Feld.integerValue = Int(UInt16(Float(ACHSE0_START) * FAKTOR0))
      Pot0_Stepper_L.integerValue = 0
      Pot0_Stepper_L_Feld.integerValue = 0
      Pot0_Stepper_H.integerValue = Int(Pot0_Slider.maxValue)
      Pot0_Stepper_H_Feld.integerValue = Int(Pot0_Slider.maxValue)
      
      // Pot 1
      Pot1_Slider.integerValue = Int(ACHSE1_START)
      //Pot1_Feld.integerValue = Int(ACHSE1_START)
      let intpos1 = UInt16(Float(ACHSE1_START) * FAKTOR1)
      Pot1_Feld.integerValue = Int(UInt16(Float(ACHSE1_START) * FAKTOR1))
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
      
      teensy.write_byteArray[ACHSE0_BYTE_H] = UInt8(((ACHSE0_START) & 0xFF00) >> 8) // hb
      teensy.write_byteArray[ACHSE0_BYTE_L] = UInt8(((ACHSE0_START) & 0x00FF) & 0xFF) // lb
      
      teensy.write_byteArray[ACHSE1_BYTE_H] = UInt8(((ACHSE1_START) & 0xFF00) >> 8) // hb
      teensy.write_byteArray[ACHSE1_BYTE_L] = UInt8(((ACHSE1_START) & 0x00FF) & 0xFF) // lb
      
      teensy.write_byteArray[0] = SET_0
  
   
   }
   
 /*  
   func openFile() -> URL? 
   { 
      let myFileDialog = NSOpenPanel() 
      myFileDialog.runModal() 
      return myFileDialog.url 
   }  
   */
   
   func sortDicArray_opt(origDicArray:[[String:Int]], key0:String, key1: String, order:Bool) -> [[String:Int]]
   {
      print("sortDicArray_opt anz: \(origDicArray.count) order: \(order)")
      var returnDicArray:[[String:Int]] = [[String:Int]]()
      // https://useyourloaf.com/blog/sorting-an-array-of-dictionaries
      
      
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
      
       print("cxDicArray anz: \(cxDicArray.count)") 
      
      for el in cxDicArray
      {
         print("\(el["cx"] ?? 0)\t \(el["cy"] ?? 0)")
      }
       
      
      var equalarray = [[[String:Int]]]()
      var equaldicarray = [[String:Int]]() // Zeilen mit gleichem cx sammeln
      var equaldic = [keyA:0] // startwert
      var eqindex = 0 
      var oldcx = 0
      for el in cxDicArray
      {
         oldcx = equaldic["cx"]! // Wert von cx: Dics mit gleichem Wert suchen und in equalarray sammeln
         let cx = el["cx"]! // aktueller wert
         print("****                   eqindex 0: \(eqindex) cx: \(cx)")
         if cx == oldcx // Punkt mit gleichem cx, in equaldicarray einsetzen
         {
            equaldicarray.append(el)
            print("eqindex A: \(eqindex) cx: \(cx)")
         }
         else // neuer Wert. 
         {
             // bisherigen equaldicarray in eaqualarray einfügen
            if equaldicarray.count > 0 // Array mit Inhalt
            {
               // equaldicarray mit gleichem cx nach cy sortieren
               var equaldicarraysorted = [[String:Int]]()
               equaldicarraysorted = equaldicarray.sorted {
                  guard let s1 = $0[key1], let s2 = $1[key1] else 
                  {
                     return false
                  }
                  return s1 < s2
               }

               print("eqindex B: \(eqindex) cx: \(cx)")
               equalarray.append(equaldicarraysorted)
               equaldicarray.removeAll() // aufräumen
            }
            
            // neues Element in leerem equaldicarray einsetzen
            print("eqindex C: \(eqindex) cx: \(cx)")
            equaldicarray.append(el)
            
            equaldic = el // aktualisieren
         }
         eqindex += 1
         if eqindex == origDicArray.count // letztes, einzelnes Element noch einsetzen
         {
            print("eqindex last: \(eqindex)  cx: \(cx)")
            equalarray.append(equaldicarray)
         }
      }
        
      

      print("equalarray anz: \(equalarray.count)")  
      
       for el in equalarray
       {
         print("el: \(el)") 
      }
       
      print("equalarray anz: \(equalarray.count)") 
      for el in equalarray
      {
         if el.count > 0
         {
            
            for e in el
            {
               print("\(e["cx"] ?? 0)\t \(e["cy"] ?? 0)")
               returnDicArray.append(e)
            }
         }
      }
      print("returnDicArray anz: \(returnDicArray.count)")  
      
         for el in returnDicArray
         {
            print("\(el["cx"] ?? 0)\t \(el["cy"] ?? 0)")
         }
      return returnDicArray
   }
   
   
   func sortDicArray(origDicArray:[[String:Int]], key0:String, key1: String, order:Bool) -> [[String:Int]]
   {
      print("sortDicArray")
      var returnDicArray:[[String:Int]] = [[String:Int]]()
      let keyarray = Array(origDicArray[0].keys)
//      let key0 = keyarray[0]
 //     let key1 = keyarray[1]
      print("keyarray: \(key0) \(key1)")
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
   
   
   @IBAction func report_readSVG(_ sender: NSButton)
   {
      let SVG_URL = openFile()
      // https://stackoverflow.com/questions/10016475/create-nsscrollview-programmatically-in-an-nsview-cocoa
      guard let fileURL = SVG_URL else { return  }
      
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
         var circlearray = [[Int]]()
         var circleelementarray = [Int]()
         
         var circleelementdic = [String:Int]()
         
         for zeile in SVG_array
         {
            //print("i: \(i) zeile: \(zeile)")
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
                  
                  //print("\tdata: \(trimmzeile)")
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
                        
                        
                        
                        //var partA = element.split(separator:"=")[1]
                        //  print("partA: \(partA)")
                        let partB = element.replacingOccurrences(of: "\"", with: "")
                        //print("partB: \(partB)")
                        let partfloat = (partB as NSString).floatValue * 1000 // Vorbereitung Int
                        let partint = Int(partfloat)
                        circleelementarray.append(partint)
                     }
                     zeilenindex += 1
                  }
               }
               if circle == 1
               {
                  //print("i: \(i) circleelementarray: \(circleelementarray)")
                  if circleelementarray.count > 0
                  {
                     circlearray.append(circleelementarray)
                  //   circleelementdic["id"] = circleelementarray[0]  // nirgends verwendet
                     circleelementdic["cx"] = circleelementarray[1]
                     circleelementdic["cy"] = circleelementarray[2]
                     circledicarray.append(circleelementdic)
                  }
               }
               
               circle -= 1
            }
            
            
            
            
            
            
            
            i = i+1
         }
    //     print("PCB circlearray")
    //     print(circlearray)
   //      let sorted = circlearray.sorted()
   //      print("PCB circledicarray")
   //      print(circledicarray)
         
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

   //      servoPfad?.addSVG_Pfadarray(newPfad: circlearray)
         let l = Plattefeld.setWeg(newWeg: circlearray)
         fahrtweg.integerValue = l
         
      }
      catch 
      {
         print("readSVG error")
         /* error handling here */
         return
      }
      
      
   }
 
   @objc func usbstatusAktion(_ notification:Notification) 
   {
      let info = notification.userInfo
      let status:Int = info?["usbstatus"] as! Int // 
      //print("Basis usbstatusAktion:\t \(status)")
      usbstatus = Int32(status)
   }

   
 // MARK: joystick
   @objc override func joystickAktion(_ notification:Notification) 
   {
      print("Basis joystickAktion usbstatus:\t \(usbstatus) selectedDevice: \(selectedDevice) ident: \(self.view.identifier)")
      let sel = NSUserInterfaceItemIdentifier.init(selectedDevice)
     // if (selectedDevice == self.view.identifier)
      if (sel == self.view.identifier)
      {
  //       print("Basis joystickAktion passt")
         
         let info = notification.userInfo
         let punkt:CGPoint = info?["punkt"] as! CGPoint
         let wegindex:Int = info?["index"] as! Int // 
         let first:Int = info?["first"] as! Int
  //       print("Basis joystickAktion:\t \(punkt)")
  //       print("x: \(punkt.x) y: \(punkt.y) index: \(wegindex) first: \(first)")
         
         teensy.write_byteArray[0] = SET_ROB // Code 
         
         // Horizontal Pot0
         let w = Double(Joystickfeld.bounds.size.width) // Breite Joystickfeld
         let faktorw:Double = (Pot0_Slider.maxValue - Pot0_Slider.minValue) / w
         //      print("w: \(w) faktorw: \(faktorw)")
         var x = Double(punkt.x)
         if (x > w)
         {
            x = w
         }
         goto_x.integerValue = Int(Float(x*faktorw))
         joystick_x.integerValue = Int(Float(x*faktorw))
         goto_x_Stepper.integerValue = Int(Float(x*faktorw))
         let achse0 = UInt16(Float(x*faktorw) * FAKTOR0)
         //print("x: \(x) achse0: \(achse0)")
         teensy.write_byteArray[ACHSE0_BYTE_H] = UInt8((achse0 & 0xFF00) >> 8) // hb
         teensy.write_byteArray[ACHSE0_BYTE_L] = UInt8((achse0 & 0x00FF) & 0xFF) // lb
         
         
         let h = Double(Joystickfeld.bounds.size.height)
         let faktorh:Double = (Pot1_Slider.maxValue - Pot1_Slider.minValue) / h
         
         let faktorz = 1
         //     print("h: \(h) faktorh: \(faktorh)")
         var y = Double(punkt.y)
         if (y > h)
         {
            y = h
         }
         let z = 0
         goto_y.integerValue = Int(Float(y*faktorh))
         joystick_y.integerValue = Int(Float(y*faktorh))
         goto_y_Stepper.integerValue = Int(Float(y*faktorh))
         let achse1 = UInt16(Float(y*faktorh) * FAKTOR1)
         //print("y: \(y) achse1: \(achse1)")
         teensy.write_byteArray[ACHSE1_BYTE_H] = UInt8((achse1 & 0xFF00) >> 8) // hb
         teensy.write_byteArray[ACHSE1_BYTE_L] = UInt8((achse1 & 0x00FF) & 0xFF) // lb
         let achse2 =  UInt16(Float(z*faktorz) * FAKTOR2)
         teensy.write_byteArray[ACHSE2_BYTE_H] = UInt8((achse2 & 0xFF00) >> 8) // hb
         teensy.write_byteArray[ACHSE2_BYTE_L] = UInt8((achse2 & 0x00FF) & 0xFF) // lb
         
         
         let message:String = info?["message"] as! String
         if ((message == "mousedown") && (first >= 0))// Polynom ohne mousedragged
         {
            teensy.write_byteArray[0] = SET_RING
            let anz = servoPfad?.anzahlPunkte()
            if (wegindex > 1)
            {
               print("")
               print("basis joystickAktion cont achse0: \(achse0) achse1: \(achse1)  achse2: \(achse2) anz: \(String(describing: anz)) wegindex: \(wegindex)")
               
               let lastposition = servoPfad?.pfadarray.last
               
               let lastx:Int = Int(lastposition!.x)
               let nextx:Int = Int(achse0)
               let hypx:Int = (nextx - lastx) * (nextx - lastx)
               
               let lasty:Int = Int(lastposition!.y)
               let nexty:Int = Int(achse1)
               let hypy:Int = (nexty - lasty) * (nexty - lasty)
               
               let lastz:Int = Int(lastposition!.z)
               let nextz:Int = Int(achse2)
               let hypz:Int = (nextz - lastz) * (nextz - lastz)
               
               print("joystickAktion lastx: \(lastx) nextx: \(nextx) lasty: \(lasty) nexty: \(nexty)")
               
               let hyp:Float = (sqrt((Float(hypx + hypy + hypz))))
               
               let anzahlsteps = hyp/schrittweiteFeld.floatValue
               print("Basis joystickAktion hyp: \(hyp) anzahlsteps: \(anzahlsteps) ")
               
               teensy.write_byteArray[HYP_BYTE_H] = UInt8((Int(hyp) & 0xFF00) >> 8) // hb
               teensy.write_byteArray[HYP_BYTE_L] = UInt8((Int(hyp) & 0x00FF) & 0xFF) // lb
               
               teensy.write_byteArray[STEPS_BYTE_H] = UInt8((Int(anzahlsteps) & 0xFF00) >> 8) // hb
               teensy.write_byteArray[STEPS_BYTE_L] = UInt8((Int(anzahlsteps) & 0x00FF) & 0xFF) // lb
               
               teensy.write_byteArray[INDEX_BYTE_H] = UInt8(((wegindex-1) & 0xFF00) >> 8) // hb // hb // Start, Index 0
               teensy.write_byteArray[INDEX_BYTE_L] = UInt8(((wegindex-1) & 0x00FF) & 0xFF) // lb
               
               print("Basis joystickAktion hypx: \(hypx) hypy: \(hypy) hypz: \(hypz) hyp: \(hyp)")
               
            }
            else
            {
               print("basis joystickAktion start achse0: \(achse0) achse1: \(achse1)  achse2: \(achse2) anz: \(anz) wegindex: \(wegindex)")
               teensy.write_byteArray[HYP_BYTE_H] = 0 // hb // Start, keine Hypo
               teensy.write_byteArray[HYP_BYTE_L] = 0 // lb
               teensy.write_byteArray[INDEX_BYTE_H] = 0 // hb // Start, Index 0
               teensy.write_byteArray[INDEX_BYTE_L] = 0 // lb
               
            }
            
            servoPfad?.addPosition(newx: achse0, newy: achse1, newz: 0)
         }
         
         if (usbstatus > 0)
         {
            let senderfolg = teensy.send_USB()
            print("joystickAktion senderfolg: \(senderfolg)")
         }
      }
      else
      {
 //        print("Basis joystickAktion passt nicht")
      }
      
   }
   
   
   @objc override func newDataAktion(_ notification:Notification) 
   {
      let lastData = teensy.getlastDataRead()
      print("lastData:\t \(lastData[1])\t\(lastData[2])   ")
      var ii = 0
      while ii < 10
      {
         //print("ii: \(ii)  wert: \(lastData[ii])\t")
         ii = ii+1
      }
      
      let u = ((Int32(lastData[1])<<8) + Int32(lastData[2]))
      //print("hb: \(lastData[1]) lb: \(lastData[2]) u: \(u)")
      let info = notification.userInfo
      
      //print("info: \(String(describing: info))")
      //print("new Data")
      let data = notification.userInfo?["data"]
      //print("data: \(String(describing: data)) \n") // data: Optional([0, 9, 51, 0,....
      
      
      //print("lastDataRead: \(lastDataRead)   ")
      var i = 0
      while i < 10
      {
         //print("i: \(i)  wert: \(lastDataRead[i])\t")
         i = i+1
      }
      
      if let d = notification.userInfo!["usbdata"]
      {
         
         //print("d: \(d)\n") // d: [0, 9, 56, 0, 0,... 
         let t = type(of:d)
         //print("typ: \(t)\n") // typ: Array<UInt8>
         
         //print("element: \(d[1])\n")
         
         print("d as string: \(String(describing: d))\n")
         if d != nil
         {
            //print("d not nil\n")
            var i = 0
            while i < 10
            {
               //print("i: \(i)  wert: \(d![i])\t")
               i = i+1
            }
            
         }
         
         
         //print("dic end\n")
      }
      
      //let dic = notification.userInfo as? [String:[UInt8]]
      //print("dic: \(dic ?? ["a":[123]])\n")
      
   }
   
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
      
      let l = Plattefeld.setWeg(newWeg: circlearray)
      self.fahrtweg.integerValue = l
      
   }
   
   //MARK: Slider 0
   @IBAction override func report_Slider0(_ sender: NSSlider)
   {
      teensy.write_byteArray[0] = SET_0 // Code 
      print("report_Slider0 IntVal: \(sender.intValue)")
      
      let pos = sender.floatValue
      
      let intpos = UInt16(pos * FAKTOR0)
      let Ustring = formatter.string(from: NSNumber(value: intpos))
      
      //print("report_Slider0 pos: \(pos) intpos: \(intpos)  Ustring: \(Ustring ?? "0")")
      // Pot0_Feld.stringValue  = Ustring!
      Pot0_Feld.integerValue  = Int(intpos)
      Pot0_Stepper_L.integerValue  = Int(sender.minValue) // Stepper min setzen
      Pot0_Stepper_L_Feld.integerValue = Int(sender.minValue)
      Pot0_Stepper_H.integerValue  = Int(sender.maxValue) // Stepper max setzen
      Pot0_Stepper_H_Feld.integerValue = Int(sender.maxValue)
      
      teensy.write_byteArray[ACHSE0_BYTE_H] = UInt8((intpos & 0xFF00) >> 8) // hb
      teensy.write_byteArray[ACHSE0_BYTE_L] = UInt8((intpos & 0x00FF) & 0xFF) // lb
      
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
      //let u = Pot0_Feld.floatValue 
      let Pot0_wert = Pot0_Feld.floatValue * 100
      let Pot0_intwert = UInt(Pot0_wert)
      
      let Pot0_HI = (Pot0_intwert & 0xFF00) >> 8
      let Pot0_LO = Pot0_intwert & 0x00FF
      
      print("report_set_Pot0 Pot0_wert: \(Pot0_wert) Pot0 HI: \(Pot0_HI) Pot0 LO: \(Pot0_LO) ")
      let 
      intpos = sender.intValue 
      self.Pot0_Slider.floatValue = Pot0_wert //sender.floatValue
      self.Pot0_Stepper_L.floatValue = Pot0_wert//sender.floatValue
      
      teensy.write_byteArray[ACHSE0_BYTE_H] = UInt8(Pot0_LO)
      teensy.write_byteArray[ACHSE0_BYTE_L] = UInt8(Pot0_HI)
      
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
      
      let pos = sender.floatValue
      let intpos = UInt16(pos * FAKTOR0)
      let Istring = formatter.string(from: NSNumber(value: intpos))
      print("intpos: \(intpos) IString: \(Istring)") 
      Pot1_Feld.integerValue  = Int(intpos)
      
      Pot1_Stepper_L.integerValue  = Int(sender.minValue) // Stepper min setzen
      Pot1_Stepper_L_Feld.integerValue = Int(sender.minValue)
      Pot1_Stepper_H.integerValue  = Int(sender.maxValue) // Stepper max setzen
      Pot1_Stepper_H_Feld.integerValue = Int(sender.maxValue)
      
      
      
      teensy.write_byteArray[ACHSE1_BYTE_H] = UInt8((intpos & 0xFF00) >> 8) // hb
      teensy.write_byteArray[ACHSE1_BYTE_L] = UInt8((intpos & 0x00FF) & 0xFF) // lb
      
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
      self.goto_0(x:Float(x),y:Float(y),z: 0)
   }
   
   override func goto_0(x:Float, y:Float, z:Float)
   {
      teensy.write_byteArray[0] = GOTO_0
      print("goto_0 x: \(x) y: \(y)")
      // achse 0
      let intposx = UInt16(x * FAKTOR0)
      goto_x_Stepper.integerValue = Int(x) //Int(intposx)
      teensy.write_byteArray[ACHSE0_BYTE_H] = UInt8((intposx & 0xFF00) >> 8) // hb
      teensy.write_byteArray[ACHSE0_BYTE_L] = UInt8((intposx & 0x00FF) & 0xFF) // lb
      
      // Achse 1
      let intposy = UInt16(y * FAKTOR1)
      goto_y_Stepper.integerValue = Int(y)
      teensy.write_byteArray[ACHSE1_BYTE_H] = UInt8((intposy & 0xFF00) >> 8) // hb
      teensy.write_byteArray[ACHSE1_BYTE_L] = UInt8((intposy & 0x00FF) & 0xFF) // lb
      
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
      let intposx = UInt16(Float(intpos ) * FAKTOR0)
      teensy.write_byteArray[ACHSE0_BYTE_H] = UInt8((intposx & 0xFF00) >> 8) // hb
      teensy.write_byteArray[ACHSE0_BYTE_L] = UInt8((intposx & 0x00FF) & 0xFF) // lb
      
      let w = Double(Joystickfeld.bounds.size.width) // Breite Joystickfeld
      let invertfaktorw:Float = Float(w / (Pot0_Slider.maxValue - Pot0_Slider.minValue)) 
      
      var currpunkt:NSPoint = Joystickfeld.weg.currentPoint
      currpunkt.x = CGFloat(Float(intpos) * invertfaktorw)
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
      let intposy = UInt16(Float(intpos ) * FAKTOR0)
      teensy.write_byteArray[ACHSE1_BYTE_H] = UInt8((intposy & 0xFF00) >> 8) // hb
      teensy.write_byteArray[ACHSE1_BYTE_L] = UInt8((intposy & 0x00FF) & 0xFF) // lb
      
      let h = Double(Joystickfeld.bounds.size.width) // Breite Joystickfeld
      let invertfaktorh:Float = Float(h / (Pot1_Slider.maxValue - Pot1_Slider.minValue)) 
      
      var currpunkt:NSPoint = Joystickfeld.weg.currentPoint
      currpunkt.y = CGFloat(Float(intpos) * invertfaktorh)
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
      teensy.write_byteArray[0] = CLEAR_RING
      teensy.write_byteArray[ACHSE0_BYTE_H] = UInt8(((ACHSE0_START) & 0xFF00) >> 8) // hb
      teensy.write_byteArray[ACHSE0_BYTE_L] = UInt8(((ACHSE0_START) & 0x00FF) & 0xFF) // lb
      
      teensy.write_byteArray[ACHSE1_BYTE_H] = UInt8(((ACHSE1_START) & 0xFF00) >> 8) // hb
      teensy.write_byteArray[ACHSE1_BYTE_L] = UInt8(((ACHSE1_START) & 0x00FF) & 0xFF) // lb
      
      teensy.write_byteArray[ACHSE2_BYTE_H] = UInt8(((ACHSE2_START) & 0xFF00) >> 8) // hb
      teensy.write_byteArray[ACHSE2_BYTE_L] = UInt8(((ACHSE2_START) & 0x00FF) & 0xFF) // lb
      
      teensy.write_byteArray[HYP_BYTE_H] = 0 // hb
      teensy.write_byteArray[HYP_BYTE_L] = 0 // lb
      
      teensy.write_byteArray[INDEX_BYTE_H] = 0 // hb
      teensy.write_byteArray[INDEX_BYTE_L] = 0 // lb
      Joystickfeld.clearWeg()
      servoPfad?.clearPfadarray()
      
      if (usbstatus > 0)
      {
         let senderfolg = teensy.send_USB()
      }
      
   }

   
   
   
    
} // ViewController
