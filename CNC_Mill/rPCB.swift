//
//  rBasis.swift
//  Robot_Interface
//
//  Created by Ruedi Heimlicher on 06.08.2019.
//  Copyright © 2019 Ruedi Heimlicher. All rights reserved.
//

import Cocoa

let USBATTACHED:Int     =      5
let USBREMOVED:Int      =      6

class rPCB: rViewController 
{
   
   var PCB_Test = 0
   
   var circledicarray = [[String:Int]]()
   
    var circlefloatdicarray = [[String:Double]]()
   
   var circlearray = [[Int]]() // Koordinaten der Punkte

   var circlefloatarray = [[Double]]() // Koordinaten der Punkteals double
   
   var maxdiff:Double = 100 // maximale differenz fuer doppelte Punkte
   var maxfloatdiff:Double = 5 // maximale differenz fuer doppelte Float-Punkte
   
   var zoomfaktor:Double = 1.0
   
 //  var transformfaktor:Double = 0.3527777777779440
   var transformfaktor:Double = 1
   
    var Schnittdatenarray = [[UInt8]]()
   var Schnittdatenarray_n = [[UInt8]]()
   
   
   var CNC_DatendicArray = [[String:String]]()
   
   var lastklickposition:position = position()
   
   var lastcncindex:Int = 0 // letzte  CNC-position in circlearray
   
   var mouseistdown:Int = 0
   
   var selectetDataTableRow = 0
   
//   var pfeilschrittweite:Int = 0
   var tsp_nn = rTSP_NN()
  // var schnittPfad = rSchnittPfad()
 //  var usbstatus: Int32 = 0
   
 //  var teensy = usb_teensy()
   
   @IBOutlet weak var readSVG_Knopf: NSButton!
   
    @IBOutlet weak var PCB_Data_Knopf: NSButton!
   
   @IBOutlet weak var DataSendTaste: NSButton!
   @IBOutlet weak var ClearPCBTaste: NSButton!
   @IBOutlet weak var linear_checkbox: NSButton!
   @IBOutlet weak var horizontal_checkbox:NSButton!
   
   @IBOutlet weak var zoomFeld: NSTextField!
   
   @IBOutlet weak var fahrtweg: NSTextField!
   @IBOutlet weak var speedFeld: NSTextField!
 
   @IBOutlet weak var timerintervallFeld: NSTextField!
   
   @IBOutlet weak var stepsFeld: NSTextField!
   @IBOutlet weak var ramp_OK_Check: NSButton!

   @IBOutlet weak var NN_OK_Check: NSButton! // NearestNeighbour
   
   @IBOutlet weak var dxFeld: NSTextField!
   @IBOutlet weak var dyFeld: NSTextField!
   
   @IBOutlet weak var dx_Stepper: NSStepper!
   @IBOutlet weak var dy_Stepper: NSStepper!

   @IBOutlet weak var homexFeld: NSTextField!
   @IBOutlet weak var homeyFeld: NSTextField!

   @IBOutlet  var dataTable: NSTableView!
   
    @IBOutlet weak var drillKnopf: NSButton!
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
      
      transformfaktor = INTEGERFAKTOR/10/propfaktor
      
      
      let sup = self.view.superview
      //print("DeviceTab superview: \(String(describing: sup)) ident: \(String(describing: sup?.identifier))")
      
      //USB_OK.backgroundColor = NSColor.greenColor()
      // Do any additional setup after loading the view.
      let newdataname = Notification.Name("newdata")
      NotificationCenter.default.addObserver(self, selector:#selector(newDataAktion(_:)),name:newdataname,object:nil)
 //     NotificationCenter.default.addObserver(self, selector:#selector(joystickAktion(_:)),name:NSNotification.Name(rawValue: "joystick"),object:nil)
      NotificationCenter.default.addObserver(self, selector:#selector(usbstatusAktion(_:)),name:NSNotification.Name(rawValue: "usb_status"),object:nil)
 //     NotificationCenter.default.addObserver(self, selector:#selector(usbattachAktion(_:)),name:NSNotification.Name(rawValue: "usb_attach"),object:nil)

      NotificationCenter.default.addObserver(self, selector:#selector(dataTableAktion(_:)),name:NSNotification.Name(rawValue: "datatable"),object:nil)

      
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
 //     let wegarray = wegArrayMitWinkel(winkel: 1.0, distanz: 124)
    
     dataTable.doubleAction = #selector(handleDoubleClick)
      updatePfeilschrittweite(sw: pfeilschrittweite + 1)
      
      /*
      let tagarray = [1,2,3,4,11,22,33,44]
      for pfeiltag in tagarray
      {
      var taste = self.view.viewWithTag(pfeiltag) as? rPfeiltaste
      taste?.setSchrittweite(sw: pfeilschrittweite)
      }
 */
      var schritteweitearray:[String] = ["1","2","4","8","16"]
      schritteweitepop.removeAllItems()
      schritteweitepop.addItems(withTitles: schritteweitearray)
      schritteweitepop.selectItem(withTitle: schritteweitearray[2])
  
   }
   func updatePfeilschrittweite(sw:Int)
    {
      let tagarray = [1,2,3,4,11,22,33,44]
      for pfeiltag in tagarray
      {
         var taste = self.view.viewWithTag(pfeiltag) as? rPfeiltaste
         taste?.setSchrittweite(sw: sw)
      }

   }
   
   @objc func handleDoubleClick()
   {
      
      let clickedRow = dataTable.clickedRow
      print("tableView doubleClick clickedRow: \(clickedRow)")
      
   }
   
   func tableViewSelectionDidChange(_ notification: Notification) 
   {
 //     print("tableView  tableViewSelectionDidChange notification: \(notification)")
      let selectedRow = (notification.object as! NSTableView).selectedRow
 //      print("tableView  tableViewSelectionDidChange selectedRow: \(selectedRow)")
      
      let nc = NotificationCenter.default
      var notificationDic = [String:Any]()
      notificationDic["selrow"] = selectedRow
      nc.post(name:Notification.Name(rawValue:"datatable"),
              object: nil,
              userInfo: notificationDic)        

   }
   
   @objc func handleClickedRow()
   {
      
      let clickedRow = dataTable.clickedRow
      print("tableView  clickedRow: \(clickedRow)")
      selectetDataTableRow = clickedRow
      
   }

 /*  
   func openFile() -> URL? 
   { 
      let myFileDialog = NSOpenPanel() 
      myFileDialog.runModal() 
      return myFileDialog.url 
   }  
   */

   
   func sortDicArray_float(origDicArray:[[String:Double]], key0:String, key1: String, order:Bool) -> [[String:Double]]
   {
      print("sortDicArray_float anz: \(origDicArray.count) order: \(order)")
      var returnDicArray:[[String:Double]] = [[String:Double]]()
      // https://useyourloaf.com/blog/sorting-an-array-of-dictionaries
      
      var linear = 0
      if linear_checkbox.state == .on
      {
         print("linear on")
         linear = 1
      }
      // Array nach cx sortieren
      var cxDicArray:[[String:Double]] = [[String:Double]]()
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
      
      
      var equalarray = [[[String:Double]]]()
      var equaldicarray = [[String:Double]]() // Zeilen mit gleichem cx sammeln
      var equaldic:[String:Double] = [keyA:0] // startwert
      var eqindex = 0 
      var oldcx:Double = 0
      for el in cxDicArray
      {
         oldcx = equaldic[keyA]! // Wert von cx: Dics mit gleichem Wert suchen und in equalarray sammeln
         let cx:Double = el[keyA]! // aktueller wert
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
               var equaldicarraysorted = [[String:Double]]()
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
      
      
  /*    
      print("sortDicArray_float equalarray anz: \(equalarray.count)")  
      
      for statusel in equalarray
      {
         print("statusel: \(statusel)") 
      }
  */    
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

    
   @IBAction func report_testPCB(_ sender: NSButton)
   {
      let URLString = "file:///Users/ruediheimlicher/Desktop/CNC_SVG/BBB.svg"
      
      let path = Bundle.main.path(forResource: "AAA.txt", ofType: nil)!
   
     // let content = try! String(contentsOfFile: path, encoding: String.Encoding.utf8)
 //     let myStringText = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
      clearteensy()
      //reading
      do {
         print("testPCB")
         
         //let SVG_data = try String(contentsOf: fileURL, encoding: .utf8)
          let SVG_data =  try! String(contentsOfFile: path, encoding: String.Encoding.utf8)
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
                        var partB = element.replacingOccurrences(of: "\"", with: "")
                        partB = partB.replacingOccurrences(of: "/>", with: "")
                        //                      print("i: \(i) \tz:\t \(z)\tpartB: \t\(partB)")
                        
                        z += 1
                        let partfloat = (partB as NSString).doubleValue * INTEGERFAKTOR // Vorbereitung Int
                        let partint = Int(partfloat)
                        if partint > 0xFFFFFFFF
                        {
                           print("partint zu  gross*** partfloat: \(partfloat) partint: \(partint)")
                        }
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
         /*
         print("report_readSVG circlearray count: \(circlearray.count)")
         var ii = 0
         for el in circlearray
         {
            print("\(ii)\t\(el[1])\t \(el[2])")
            ii += 1
         }
          */        
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
         /*
         print("report_readSVG circlearray vor.  count: \(circlearray.count)")
         for el in circlearray
         {
            
            print("\(el[0] )\t \(el[1] ) \(el[2])")
         }
         */
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
         print("report_readSVG circlearray nach. count: \(circlearray.count)")
         for el in circlearray
         {
            
            print("\(el[0] )\t \(el[1] )\t \(el[2])")
         }
         */
         circlearray.append(circlearray[0])
         
         let l = Plattefeld.setWeg(newWeg: circlearray, scalefaktor: 800, transform:  transformfaktor)
         fahrtweg.integerValue = l
         
      //   var CNC_DatendicArray = [[String:Any]]()
         let formater = NumberFormatter()
         formater.groupingSeparator = "."
         formater.maximumFractionDigits = 3
         formater.numberStyle = .decimal
         for zeilendaten in circlearray
         {
            let z = Double(zeilendaten[1])/INTEGERFAKTOR
            let cx = formater.string(from: NSNumber(value: Double(zeilendaten[1])/INTEGERFAKTOR))
           // print("cx: \(cx)")
            let cy = formater.string(from: NSNumber(value: Double(zeilendaten[2])/INTEGERFAKTOR))
            //print("cy: \(cy)")
           
            var zeilendic = [String:String]()
            zeilendic["ind"] = String(zeilendaten[0])
            zeilendic["X"] = cx
            zeilendic["Y"] = cy
            /*
            var zeilendic = [String:Double]()
            zeilendic["ind"] = Double(zeilendaten[0])
            zeilendic["X"] = Double(zeilendaten[1])/1000000
            zeilendic["Y"] = Double(zeilendaten[1])/1000000
            */
            CNC_DatendicArray.append(zeilendic)
         }
          
      }
      catch 
      {
         print("readSVG error")
         /* error handling here */
         return
      }
   //   report_clear(ClearPCBTaste)
      
      report_PCB_Daten(PCB_Data_Knopf)
      PCB_Test = 1
      /*
      let kreuzarray = kreuz(startnummer: Schnittdatenarray.count)
      
      for el in kreuzarray
      {
   //
         Schnittdatenarray.append(el)
      }
      let endindex = Schnittdatenarray.endIndex - 1
      Schnittdatenarray[endindex][24] = 3
 */
      report_send_Daten(DataSendTaste)

   }
   
   func flipSVG(svgarray:[[Double]])->[[Double]]
   {
      // find maxY
      var fliparray = [[Double]]()
      var maxY:Double = 0
      for zeile in svgarray
      {
         if zeile[2] > maxY
         {
            maxY = zeile[2]
         }
      }
      print("flipSVG maxY: \(maxY)")
      for zeile in svgarray
      {
         var tempzeile = zeile
         tempzeile[2] = maxY - zeile[2] + 10
         fliparray.append(tempzeile)
      }
      return fliparray
   }
   
   @IBAction func report_readSVG(_ sender: NSButton)
   {
      let SVG_URL = openFile()
      // https://stackoverflow.com/questions/10016475/create-nsscrollview-programmatically-in-an-nsview-cocoa
      guard let fileURL = SVG_URL else { return  }
      
 //     print("report_readSVG fileURL: \(fileURL)")
      circledicarray.removeAll()
      circlefloatarray.removeAll()
      circlefloatdicarray.removeAll()
      //reading
      do {
         print("readSVG")
         
         let SVG_data = try String(contentsOf: fileURL, encoding: .utf8)
         //print("SVGdata: \(SVG_data)")
         //let anz = SVG_data.count
         //print("SVGdata count: \(anz)")
         let SVG_text = SVG_data.components(separatedBy: "\n")
         // print("SVG_text: \(SVG_text)")
         let SVG_array = Array(SVG_text)
         var i=0
         var circle = 0
         var circlenummer = 0
         circlearray = [[Int]]()
         var circleelementarray = [Int]()
         var circlefloatelementarray = [Double]()
         var circleelementdic = [String:Int]()
         
         var circlefloatelementdic = [String:Double]()
         var width_ok = 0
         var widthfloat:Double = 0
         var height_ok = 0
         var heightfloat:Double = 0
         var z = 0
         for zeile in SVG_array
         {
       //     print("i: \(i) zeile: \(zeile)")
            let trimmzeile = zeile.trimmingCharacters(in: .whitespaces)
            
            if trimmzeile.contains("width") && (width_ok == 0)
            {
               width_ok = 1
               //print("SVGdata widthzeile: \(trimmzeile)")
               let zeilenarray = trimmzeile.split(separator: "=")
               if zeilenarray.count == 2
               {
                  //print("SVGdata width: \(zeilenarray[1]) string: \(zeilenarray[1] as NSString)")
                  widthfloat = ((zeilenarray[1].replacingOccurrences(of: "\"", with: ""))as NSString).doubleValue
                  print("SVGdata widthfloat: \(widthfloat)")
               }
            }  
            if trimmzeile.contains("height") && (height_ok == 0)
            {
               height_ok = 1
               //print("SVGdata heightzeile: \(trimmzeile)")
               let zeilenarray = trimmzeile.split(separator: "=")
               if zeilenarray.count == 2
               {
                  //print("SVGdata width: \(zeilenarray[1]) string: \(zeilenarray[1] as NSString)")
                  heightfloat = ((zeilenarray[1].replacingOccurrences(of: "\"", with: ""))as NSString).doubleValue
                  print("SVGdata heightfloat: \(heightfloat)")
               }
            }  
            
            
            if (trimmzeile.contains("circle") || trimmzeile.contains("ellipse"))
            {
              // print("i: \(i) trimmzeile: \(trimmzeile)")
               circle = 6
               circlenummer = i
               circleelementarray.removeAll()
               circlefloatelementarray.removeAll()
               circleelementdic = [:]
               circlefloatelementdic = [:]
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
                        circlefloatelementarray.append(Double(circlenummer))
                        continue
                     }
                     else if zeilenindex == 1
                     { 
                        //var partAraw = element.split(separator:"=")
                        //print("partAraw: \(partAraw)")
                        //var partA =  String(element.split(separator:"=")[1])
                        
                        var partB = element.replacingOccurrences(of: "\"", with: "")
                        partB = partB.replacingOccurrences(of: "/>", with: "")
  //                      print("i: \(i) \tz:\t \(z)\tpartB: \t\(partB)")
                        
                        z += 1
                        let partfloat = (partB as NSString).doubleValue  
                        circlefloatelementarray.append(partfloat)
                        let partint = Int(partfloat * INTEGERFAKTOR)// Vorbereitung Int
                        if partint > 0xFFFFFFFF
                        {
                           print("partint zu  gross*** partfloat: \(partfloat) partint: \(partint)")
                        }
                        //print("partB: \(partB) partfloat: \(partfloat) partint: \(partint)")
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
                     circleelementdic["index"] = i
                     circleelementdic["cx"] = circleelementarray[1]
                     circleelementdic["cy"] = circleelementarray[2]
                     
                     circledicarray.append(circleelementdic) // [[String:Int]]
                     
                     circlefloatelementdic["index"] = Double(i)
                     circlefloatelementdic["cx"] = circlefloatelementarray[1]
                     circlefloatelementdic["cy"] = circlefloatelementarray[2]
                   
                     circlefloatdicarray.append(circlefloatelementdic)
                     circlefloatarray.append(circlefloatelementarray)
                  }
                  
               }
               
               circle -= 1
            }
                        i = i+1
            
            
            
         }
         /*
         print("report_readSVG circlearray count: \(circlearray.count)")
         var ii = 0
         for el in circlearray
         {
            print("\(ii)\t\(el[1])\t \(el[2])")
            ii += 1
         }
          
         print("report_readSVG circlefloatarray count: \(circlefloatarray.count)")
         var  iii = 0
         for el in circlefloatarray
         {
            print("\(iii)\t\(el[1])\t \(el[2])")
            iii += 1
         }
          */
         
    /*     
         print("report_readSVG circledicarray")
         var iii = 0
         for el in circledicarray
         {
            print("\(iii) \(el)")
            iii += 1
         }
*/
 
         
         // https://useyourloaf.com/blog/sorting-an-array-of-dictionaries/
         var sortedarray = [[String:Int]]()
         var sortedfloatarray = [[String:Double]]()
         
         var sortedarray_opt = [[String:Int]]()
     //    sortedarray_opt = sortDicArray_opt(origDicArray: circledicarray,key0:"cx", key1:"cy", order: false)
         
        // Doppelte Punkte suchen
         
         var doppelarray = [[String:Int]]()
         
         
         print("vor sort circlefloatdicarray count: \(circlefloatdicarray.count)")
         print("nach sort sortedfloatarray count: \(sortedfloatarray.count)")
         switch horizontal_checkbox.state
         {
         case .off:
            print("horizontal_checkbox: off")
            sortedarray = sortDicArray_opt(origDicArray: circledicarray,key0:"cx", key1:"cy", order: false)
 
            sortedfloatarray = sortDicArray_float(origDicArray: circlefloatdicarray,key0:"cx", key1:"cy", order: false)
         
         case .on:
            print("horizontal_checkbox: on")
            sortedarray = sortDicArray_opt(origDicArray: circledicarray,key0:"cx", key1:"cy", order: true)
 
            sortedfloatarray = sortDicArray_float(origDicArray: circlefloatdicarray,key0:"cx", key1:"cy", order: true)
         
         default:
            break
         }
         //print(circledicarray)
         print("nach sort circlefloatdicarray count: \(circlefloatdicarray.count)")
         print("nach sort sortedfloatarray count: \(sortedfloatarray.count)")
         /*
         print("report_readSVG sortedarray")
         var iii = 0
         iii = 0
         for el in sortedarray
         {
            print("\(iii) \(el)")
            iii += 1
         }
          */
         /*
         print("report_readSVG sortedfloatarray")
         var aa = 0
         for el in sortedfloatarray
         {
            print("\(aa) \(el)")
            aa += 1
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
         /*
         print("report_readSVG circlearray vor.  count: \(circlearray.count)")
         for el in circlearray
         {
            print("\(el[0] )\t \(el[1] ) \(el[2])")
         }
         for pos in 0..<circlearray.count
         {
            circlearray[pos][0] = pos
         }
         */
         // Integer
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

         
         

         // float
         circlefloatarray.removeAll()
   //      var zeilendicindex:Int = 0
         zeilendicindex = 0
         for zeilendic in sortedfloatarray
         {
            let cx:Double = (zeilendic["cx"]!) 
            let cy:Double = (zeilendic["cy"]!) 
            
           // print("\(zeilendicindex) \(cx) \(cy)")
            let zeilendicarray:[Double] = [Double(zeilendicindex),cx,cy]
            circlefloatarray.append(zeilendicarray)
            zeilendicindex += 1
         }
         
         /*
         print("report_readSVG circlefloatarray vor.  count: \(circlefloatarray.count)")
         for el in circlefloatarray
         {
            print("\(el[0] )\t \(el[1] ) \(el[2])")
         }
         */
 
         
       //  var 
         doppelindex = 0
         var doppelcount = 0
         
          // float
         doppelindex = 0
         doppelcount = 0
         for datazeile in circlefloatarray
         {
            if doppelindex < circlefloatarray.count
            {
               let akt = circlefloatarray[doppelindex]
               var next = [Double]()
               var n = 1
               while doppelindex + n < circlefloatarray.count // naechste Zeilen absuchen
               {
                  next = circlefloatarray[doppelindex+n]
                  var diffX:Double = (Double((next[1] - akt[1]))) 
                  //print(" zeile: \(doppelindex) n: \(n)\t diffX: \(diffX)")
                  
                  if fabs(diffX) < maxfloatdiff
                  {
                     //print("diffX < maxdiff  zeile: \(doppelindex) n: \(n)\t diffX: \(diffX)")
                     var diffY:Double = (Double((next[2] - akt[2])))
                     
                     if fabs(diffY) < maxfloatdiff
                     {
                        doppelcount+=1
                        //print(" *** diff zu klein akt zeile: \(doppelindex) n: \(n)\t diffX: \(diffX) diffY: \(diffY) ")
                        circlefloatarray.remove(at: doppelindex + n)
                        n -= 1 // ein element weniger, next ist bei n-1
                     }
                     
                  }
                  n += 1
               }
            } // if < count
            doppelindex += 1
         } // for datazeile
         print("report_readSVG  doppelcount 2: \(doppelcount )")
         
         /*
         print("report_readSVG circlearray nach. count: \(circlearray.count)")
         for el in circlearray
         {
            
            print("\(el[0] )\t \(el[1] )\t \(el[2])")
            
         }
         */
         /*
         print("report_readSVG circlefloatarray nach. count: \(circlefloatarray.count)")
         for el in circlefloatarray
         {
            
            print("\(el[0] )\t \(el[1] )\t \(el[2])")
         }
        */
        circlefloatarray = flipSVG(svgarray: circlefloatarray)
         /*
         for el in circlefloatarray
         {
            
            print("\(el[0] )\t \(el[1] )\t \(el[2])")
         }
        */
         
         tsp_nn.setkoordinaten(koord: circlefloatarray)
         tsp_nn.firstrun()
         tsp_nn.nearestneighbour()
         let nn_array = tsp_nn.weg
         //print("nn_array: \(nn_array)")
         
   //      var nn_floatarray = [[Double]]() // array fuer nn-punkte
        
         /*
         var mill_floatarray = [[Double]]() //
         
         for zeilenindex in stride(from: 0, to: circlefloatarray.count, by: 1)
         {
            //print("zeilenindex: \(zeilenindex) data: \(circlefloatarray[zeilenindex])")
            if  NN_OK_Check.state == NSControl.StateValue.on // nearest neighbour
            {
               let millindex = nn_array[zeilenindex]
               mill_floatarray.append(circlefloatarray[millindex])
            }
            else
            {
               mill_floatarray.append(circlefloatarray[zeilenindex])
            }
         }
 */
         var mill_floatarray = mill_floatArray(circarray: circlefloatarray) //
         
         /*
         for ii in nn_array
         {
            nn_floatarray.append(circlefloatarray[ii])
         }
         */
         /*
         print("nn_floatarray")
         for el in nn_floatarray
         {
            print("\(el)")
            //     iii += 1
         }
 */
         /*
         print("mill_floatarray A")
         for el in mill_floatarray
         {
            print("\(el)")
            //     iii += 1
         }
*/
         setPCB_Output(floatarray: mill_floatarray, scale: 5, transform: transformfaktor)
       /*
         print("mill_floatarray B")
         for el in mill_floatarray
         {
            print("\(el)")
            //     iii += 1
         }
*/
         
           
         let zeile:IndexSet = [0]
 //        dataTable.selectRowIndexes(zeile, byExtendingSelection: false)
         dataTable.reloadData()
//         lastcncindex = 0 // Zeile 0 in circlearray
         
         /*
         print("mill_floatarray C")
         for el in mill_floatarray
         {
            print("\(el)")
            //     iii += 1
         }
          */
         var PCBDaten = PCB_Daten(floatarray: mill_floatarray)
         
         /*
         print("mill_floatarray C")
         for el in mill_floatarray
         {
            print("\(el)")
            //     iii += 1
         }

         print("report_readSVG PCBDaten")
         
         //var iii = 0
         for el in PCBDaten
         {
            print("\(el)")
       //     iii += 1
         }
         
         print("report_readSVG circlefloatarray")
         for el in circlefloatarray
         {
            print("\(el)")
            //     iii += 1
         }
          */
         //PCBDaten[25] = [UInt8(3)]
         Schnittdatenarray.append(contentsOf:PCBDaten)
    //     report_PCB_Daten(DataSendTaste)
         stepperschritteFeld.integerValue = Schnittdatenarray.count
      }
      catch 
      {
         print("readSVG error")
         /* error handling here */
         return
      }
      print("report_readSVG Schnittdatenarray")
      for el in Schnittdatenarray
      {
         print("\(el)")
      }

   }
   
   func mill_floatArray(circarray:[[Double]])->[[Double]]
   {
      tsp_nn.setkoordinaten(koord: circlefloatarray)
      tsp_nn.firstrun()
      tsp_nn.nearestneighbour()
      let nn_array = tsp_nn.weg
      //print("nn_array: \(nn_array)")
      
      //    var nn_floatarray = [[Double]]() // array fuer nn-punkte
      
      var mill_floatarray = [[Double]]() //
      
      for zeilenindex in stride(from: 0, to: circarray.count, by: 1)
      {
         //print("zeilenindex: \(zeilenindex) data: \(circlefloatarray[zeilenindex])")
         if  NN_OK_Check.state == NSControl.StateValue.on // nearest neighbour
         {
            let millindex = nn_array[zeilenindex]
            mill_floatarray.append(circlefloatarray[millindex])
         }
         else
         {
            mill_floatarray.append(circlefloatarray[zeilenindex])
         }
      }
      
      /*
       for ii in nn_array
       {
       nn_floatarray.append(circlefloatarray[ii])
       }
       
       
       print("nn_floatarray")
       for el in nn_floatarray
       {
       print("\(el)")
       //     iii += 1
       }
       */
      /*
      print("mill_floatarray")
      for el in mill_floatarray
      {
         print("\(el)")
         //     iii += 1
      }
      */
      return mill_floatarray
      
   }
   
   func setPCB_Output(floatarray: [[Double]], scale: Int, transform: Double)
   {
      print("setPCB_Output Start")
      /*
      print("circlearray: \(circlearray.count)")
      for el in circlearray
      {
         
         print("\(el[0] )\t \(el[1] )\t \(el[2])")
      }
      
      print("floatarray: \(floatarray.count)")
      for el in floatarray
      {
         print("\(el[0] )\t \(el[1] )\t \(el[2])")
      }
*/
 //     Plattefeld.setStepperposition(pos: 0)
      let l = Plattefeld.setfloatWeg(newWeg: floatarray, scalefaktor: scale, transform:  transform)
      fahrtweg.integerValue = l
//      let l = Plattefeld.setWeg(newWeg: circlearray, scalefaktor: scale, transform:  transform)
//      fahrtweg.integerValue = l
      
      // https://stackoverflow.com/questions/44630702/formatting-numbers-in-swift-3
      let formater = NumberFormatter()
      formater.groupingSeparator = "."
      formater.maximumFractionDigits = 3
      formater.minimumFractionDigits = 3
      formater.numberStyle = .decimal
      CNC_DatendicArray.removeAll()
      for zeilendaten in floatarray
      {
//         print("zeilendaten: \(zeilendaten)")
         let z = Double(zeilendaten[1])/INTEGERFAKTOR
         let cx = formater.string(from: NSNumber(value: Double(zeilendaten[1])))// /INTEGERFAKTOR))
         //print("cx: \(cx)")
         let cy = formater.string(from: NSNumber(value: Double(zeilendaten[2])))// /INTEGERFAKTOR))
         //print("cy: \(cy)")
         
         var zeilendic = [String:String]()
         zeilendic["ind"] = String(Int(zeilendaten[0]))
         zeilendic["X"] = cx
         zeilendic["Y"] = cy
         //cx: Optional("3.985") cy: Optional("26.298")
   //      print("zeilendic: \(zeilendic)")
         CNC_DatendicArray.append(zeilendic)

         /*
          print("report_readSVG CNC_DatendicArray")
         for el in CNC_DatendicArray
         {
            print("\(el["ind"] ) \(el["X"] ) \(el["Y"] )")
         }
          */
         
         let zeile:IndexSet = [0]
  //       dataTable.selectRowIndexes(zeile, byExtendingSelection: false)
         dataTable.reloadData()
         lastcncindex = 0 // Zeile 0 in circlearray
          
      }
      
      //print("setPCB_Output End")
   } // setPCB_Outpu

   func PCB_Daten(floatarray:[[Double]])->[[UInt8]]
    {
    //  var speed = speedFeld.intValue
      var PCB_Datenarray = [[UInt8]]()
      Schnittdatenarray.removeAll()
      Schnittdatenarray_n.removeAll()
      
//      var SchritteArray:[[String:Any]] = [[:]]
      zoomfaktor = zoomFeld.doubleValue
 //     let steps = stepsFeld.intValue // Schritte fuer 1mm
      var code:UInt8 = 0
      
      var maxsteps:Double = 0
      //var relevanteschritte
      var zeilenposition = 0
//      var zeilenanzahl = circlefloatarray.count

      var xhome = 0
      var yhome = 0

//      for zeilenindex in stride(from: 0, to: circlefloatarray.count-1, by: 1)
          
      
      for zeilenindex in stride(from: 0, to: floatarray.count-1, by: 1)
      
      {
//         print("vor: \t xhome: \(xhome) yhome: \(yhome)")
         zeilenposition = 0
         if zeilenindex == 0
         {
            zeilenposition |= (1<<FIRST_BIT); // Erstes Element, Start
         }
         if zeilenindex == floatarray.count - 2
         {
            zeilenposition |= (1<<LAST_BIT);
         }
         
  //       let next = circlefloatarray[zeilenindex+1] // next punkt
  //       let akt = circlefloatarray[zeilenindex] // aktueller punkt

         let next = floatarray[zeilenindex+1] // next punkt
         let akt = floatarray[zeilenindex] // aktueller punkt

         
         // Differenz X
         let diffX:Double = ((next[1] - akt[1]))

         // Differenz Y
         let diffY:Double = ((next[2] - akt[2]))
         if diffX == 0 && diffY == 0
         {
            print(" stride *********    differenz null zeile: \(zeilenindex)")
            continue
         }

         // dic aufbauen
         var position:UInt16 = 0
         
         var zeilendic:[String:Any] = [:]
         
         
         let aktX = (akt[1]) //
         let aktY = (akt[2]) //
         let nextX = (next[1])
         let nextY = (next[2])
//print("vor: \t diffX: \(diffX) diffY: \(diffY)")
         var wegArray = wegArrayMitWegXY(wegx: diffX, wegy: diffY)
//         print("set_PCB_Daten wegArray\n\(wegArray)")
         
         wegArray[25] = UInt8(zeilenposition)
         wegArray[26] = UInt8((zeilenindex & 0xFF00)<<8)
         wegArray[27] = UInt8((zeilenindex & 0x00FF))

          
         PCB_Datenarray.append(wegArray)
         
      } // for zeilenindex
      return PCB_Datenarray
   }
   
   @IBAction func report_PCB_Daten(_ sender: NSButton)
   {
      // s SteuerdatenVonDic in CNC.m
      /*
       [KoordinatenTabelle addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:PositionA.x],@"ax",[NSNumber numberWithFloat:PositionA.y],@"ay",[NSNumber numberWithFloat:PositionB.x],@"bx", [NSNumber numberWithFloat:PositionB.y],@"by",[NSNumber numberWithInt:index],@"index",[NSNumber numberWithInt:0],@"lage",[NSNumber numberWithFloat:aktuellepwm*red_pwm],@"pwm",nil]];
       */
      //      print("report_PCB_Daten propfaktor: \(propfaktor)")
      
      var speed = speedFeld.intValue
      
      if ramp_OK_Check.state == NSControl.StateValue.on
      {
         speed *= 2
      }
      //    propfaktor = 283464.567 // 14173.23
      //     propfaktor = 4000
      
      Schnittdatenarray.removeAll()
      Schnittdatenarray_n.removeAll()
      
      var SchritteArray:[[String:Any]] = [[:]]
      zoomfaktor = zoomFeld.doubleValue
      let steps = stepsFeld.intValue // Schritte fuer 1mm
      var code:UInt8 = 0
      
      var maxsteps:Double = 0
      //var relevanteschritte
      var zeilenposition = 0
      var zeilenanzahl = circlearray.count
      //      print("report_PCB_Daten circlearray vor doppelcheck count: \(zeilenanzahl)")
      //      var doppelindex:Int = 0
      
      zeilenanzahl = circlearray.count
      //    print("report_PCB_Daten circlearray nach doppelcheck count: \(zeilenanzahl)")
      
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
      
      
      var homedataarray = [[Int]]() 
      var xhome = 0
      var yhome = 0
      
      //     print("report_PCB_Daten: \t speed: \(speed) ")
      for zeilenindex in stride(from: 0, to: circlearray.count-1, by: 1)
      {
         //        print("vor: \t xhome: \(xhome) yhome: \(yhome)")
         zeilenposition = 0
         if zeilenindex == 0
         {
            zeilenposition |= (1<<FIRST_BIT); // Erstes Element, Start
         }
         if zeilenindex == circlearray.count - 2
         {
            zeilenposition |= (1<<LAST_BIT);
         }
         
         let next = circlearray[zeilenindex+1] // next punkt
         let akt = circlearray[zeilenindex] // aktueller punkt
         
         
         
         //        let next = circlefloatarray[zeilenindex+1] // next punkt
         //        let akt = circlefloatarray[zeilenindex] // aktueller punkt
         
         
         
         // Differenz X
         let diffX:Double = (Double((next[1] - akt[1]))) //* zoomfaktor
         
         
         // Differenz Y
         let diffY:Double = (Double((next[2] - akt[2]))) //* zoomfaktor
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
         
         
         let aktX = (akt[1]) //
         let aktY = (akt[2]) //
         let nextX = (next[1])
         let nextY = (next[2])
         
         // Beginn wegArrayMitWegXY
         
         
         let distanzX = Double(nextX - aktX)  * zoomfaktor  
         let distanzY = Double(nextY - aktY)  * zoomfaktor  
         
         //        print("reportPCB zeilenindex: \t\(zeilenindex) \tdiffX: \t\(diffX) \tdistanzX: \t\(distanzX)  \tdiffY: \t\(diffY) \tdistanzY: \t\(distanzY)")
         //      print("reportPCB zeilenindex: \tdistanzX: \t\(distanzX) \tdistanzY: \t\(distanzY)")
         if distanzX == 0 && distanzY == 0
         {
            print(" stride *********    differenz null zeile: \(zeilenindex)")
            continue
         }
         
         //       var distanz = Double(hypotf(Float(distanzX),Float(distanzY)))
         //       let distanzA = (distanzX * distanzX + distanzY * distanzY).squareRoot() // ohne zoomfaktor
         //let distanz = (diffX * diffX + diffY * diffY).squareRoot()
         let distanz = (distanzX * distanzX + distanzY * distanzY).squareRoot()
         
         
         //      let distanzstring = String(distanz)
         print(" ")
         //      print("++++   reportPCB zeilenindex: \(zeilenindex) distanzX: \(distanzX)  distanzY: \(distanzY)  distanz: \(distanz)")
         zeilendic["startpunktx"] = aktX
         zeilendic["startpunkty"] = aktY
         zeilendic["endpunktx"] = nextX
         zeilendic["endpunkty"] = nextY
         zeilendic["distanz"] = distanz
         
         // Zeit fuer Abschnitt
         let zeit:Double = Double(distanz)/Double(speed) //   Schnittzeit für Distanz
         
         //      print("reportPCB zeilenindex: \(zeilenindex)  zeit: \(zeit)")
         
         // Schritte X
         var schrittex = Double(stepsFeld.integerValue) * distanzX 
         schrittex /= propfaktor
         let schrittexRound = round(schrittex)
         var schrittexInt:Int = 0
         if schrittexRound >= Double(Int.min) && schrittexRound < Double(Int.max)
         {
            schrittexInt = Int(schrittexRound)
            //          print("schritteXInt OK: \(schrittexInt)")
            xhome = xhome + schrittexInt
            if Double(schrittexInt) > maxsteps
            {
               maxsteps = Double(schrittexInt)
            }
            if schrittexInt < 0 // negativer Weg
            {
               //            print("schritteX negativ")
               schrittexInt *= -1
               schrittexInt |= 0x80000000
            }
         }
         else
         {
            print("schritteXround zu gross")
         }
         
         zeilendic["schrittex"] = schrittexInt
         
         // Schritte Y
         var schrittey = Double(stepsFeld.integerValue) * distanzY  
         //let schrittey = distanzY
         schrittey /= propfaktor
         let schritteyRound = round(schrittey)
         var schritteyInt:Int = 0
         if schritteyRound >= Double(Int.min) && schritteyRound < Double(Int.max)
         {
            //    print("schritteYInt OK: \(schritteyInt)")
            schritteyInt = Int(schritteyRound)
            yhome += schritteyInt
            
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
         //        print("schrittey: \(schritteyInt) ")
         
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
         //   SchritteArray.append(zeilendic)
         
         let schrittezInt = 0
         
         var zeilenschnittdatenarray = [UInt8]()
         
         //         print("+++           report_PCB vor schnittdatenvektor schrittexInt: \(schrittexInt) schritteyInt: \(schritteyInt) schrittezInt: \(schrittezInt) zeit: \(zeit) speed: \(speed)")
         let xmm = schrittex / Double(steps)
         let ymm = schrittey / Double(steps)
         //         print("report_PCB xmm: \(xmm) ymm: \(ymm)")
         
         var zeilenschnittdatenarray_n:[UInt8] =  schrittdatenvektor(sxInt:schrittexInt,syInt:schritteyInt, szInt:schrittezInt, zeit:zeit  )// Array mit Daten fuer USB
         
         zeilenschnittdatenarray_n[25] = UInt8(zeilenposition)
         zeilenschnittdatenarray_n[26] = UInt8((zeilenindex & 0xFF00)<<8)
         zeilenschnittdatenarray_n[27] = UInt8((zeilenindex & 0x00FF))
         
         //        print("zeilenschnittdatenarray_n: \(zeilenschnittdatenarray_n)")
         
         if zeilenschnittdatenarray_n.count > 0
         {
            if !(schrittexInt == 0 && schritteyInt == 0)
            {
               //             Schnittdatenarray_n.append(zeilenschnittdatenarray_n)
               Schnittdatenarray.append(zeilenschnittdatenarray_n)
            }
         }
         
         continue
         
         
         /*    
          
          
          // 
          
          let sxInt_raw = (schrittexInt & 0x0FFFFFFF)
          let syInt_raw = (schritteyInt & 0x0FFFFFFF)
          let szInt_raw = (schrittezInt & 0x0FFFFFFF)
          print("report_PCB schrittdatenvektor sxInt_raw: \(sxInt_raw) syInt_raw: \(syInt_raw) szInt_raw: \(szInt_raw) zeit: \(zeit)")
          
          // Schritte X
          print("schrittexInt: \(schrittexInt) ")
          let schrittexA = UInt8(schrittexInt & 0x000000FF)
          let schrittexB = UInt8((schrittexInt & 0x0000FF00) >> 8)
          let schrittexC = UInt8((schrittexInt & 0x00FF0000) >> 16)
          let schrittexD = UInt8((schrittexInt & 0xFF000000) >> 24)
          print("report_PCB schrittexInt: \(schrittexInt) schrittexA: \(schrittexA) schrittexB: \(schrittexB)")
          
          
          
          zeilenschnittdatenarray.append(schrittexA)
          zeilenschnittdatenarray.append(schrittexB)
          zeilenschnittdatenarray.append(schrittexC)
          zeilenschnittdatenarray.append(schrittexD)
          
          var delayx:Double = 0
          var delayxInt:Int = 0
          var korrekturintervallx:Int = 0
          
          //         let delayx:Double = (zeit * 1000.0/Double((schrittexInt & 0x0FFFFFFF))) // Vorzeichen-Bit weg
          delayx = (zeit / Double((schrittexInt & 0x0FFFFFFF))) // Vorzeichen-Bit weg
          
          let delayxIntround = round(delayx)
          
          if delayxIntround >= Double(Int.min) && delayxIntround < Double(Int.max)
          {
          // print("delayxInt OK")
          delayxInt = Int(delayxIntround)
          }
          //      print("delayx: \(delayx) \t delayxInt: \(delayxInt) \tdelayy: \(delayy) \t delayyInt: \(delayyInt)")
          
          let delayxA = UInt8(delayxInt & 0x00FF)
          let delayxB = UInt8((delayxInt & 0xFF00) >> 8)
          zeilenschnittdatenarray.append(delayxA)
          zeilenschnittdatenarray.append(delayxB)
          
          print("Fehlerkorrektur X")
          
          if schrittexInt != 0   
          { 
          
          let vorzeichenx = (schrittexInt & 0x80000000)
          
          //           print("vorzeichenx: \(vorzeichenx)")
          
          print("schrittexInt: \(schrittexInt) delayx: \(delayx) delayxInt: \(delayxInt)")
          
          let kontrolledoublex = Int(Double(schrittexInt) * delayx) //  Kontrolle mit Double-Wert von dx
          let kontrolleintx = schrittexInt * delayxInt //               Kontrolle mit Int-Wert von dx
          var diffx = Int(kontrolledoublex) - kontrolleintx // differenz, Rundungsfehler
          if diffx == 0
          {
          diffx = 1
          }
          
          
          print("kontrolledoublex: \(kontrolledoublex) kontrolleintx: \(kontrolleintx) diffx: \(diffx)")
          
          let intervallx = Double(kontrolleintx / diffx)
          korrekturintervallx = Int(round(intervallx)) // Rundungsfehler aufteilen ueber Abschnitt: 
          // alle korrekturintervallx dexInt incrementieren oder decrementieren
          //      print("korrekturintervallx: \(korrekturintervallx)")
          
          if korrekturintervallx < 0 // negative korrektur
          {
          print("korrekturintervallx negativ")
          korrekturintervallx *= -1
          korrekturintervallx |= 0x8000
          }
          print("korrekturintervallx mit Vorzeichenkorr: \(korrekturintervallx) \n")
          }
          
          
          //       korrekturintervallx = 0
          zeilenschnittdatenarray.append(UInt8(korrekturintervallx & 0x00FF))
          zeilenschnittdatenarray.append(UInt8((korrekturintervallx & 0xFF00)>>8))
          
          
          //         let delayxC = UInt8((delayxInt & 0x00FF0000) >> 16)
          //         let delayxD = UInt8((delayxInt & 0xFF000000) >> 24)
          //print("delayxA: \(delayxA) ")
          //print("delayxB: \(delayxB) ")
          //print("delayxC: \(delayxC) ")
          //print("delayxD: \(delayxD) ")
          //      zeilenschnittdatenarray.append(delayxC)
          //      zeilenschnittdatenarray.append(delayxD)
          
          // Schritte Y
          print("*** schritteyInt: \(schritteyInt) ")
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
          
          //      var schritteY_check:UInt32 = UInt32(schritteyA) | UInt32(schritteyB)<<8 | UInt32(schritteyC)<<16 | UInt32(schritteyD)<<24;
          //       print("schritteY_check: \(schritteY_check) ")
          
          var delayy:Double = 0
          var delayyInt:Int = 0
          var korrekturintervally:Int = 0
          if schritteyInt != 0
          {
          delayy = (zeit / Double((schritteyInt & 0x0FFFFFFF)))
          //    let delayy:Double = (zeit * 1000.0/Double((schritteyInt & 0x0FFFFFFF)))
          let delayyIntround = round(delayy)
          if delayyIntround >= Double(Int.min) && delayyIntround < Double(Int.max)
          {
          // print("schritteYInt OK")
          delayyInt = Int(delayyIntround)
          }
          
          let delayyA = UInt8(delayyInt & 0x000000FF)
          let delayyB = UInt8((delayyInt & 0x0000FF00) >> 8)
          zeilenschnittdatenarray.append(delayyA)
          zeilenschnittdatenarray.append(delayyB)
          
          print("Fehlerkorrektur Y")
          
          let vorzeicheny = (schritteyInt & 0x80000000)
          
          print("vorzeicheny: \(vorzeicheny)")
          
          print("schritteyInt: \(schritteyInt) delayy: \(delayy) delayyInt: \(delayyInt)")
          let kontrolledoubley = Int(Double(schritteyInt) * delayy) //  Kontrolle mit Double-Wert von dx
          let kontrolleinty = schritteyInt * delayyInt //               Kontrolle mit Int-Wert von dx
          var diffy = Int(kontrolledoubley) - kontrolleinty // differenz, Rundungsfehler
          
          if diffy == 0
          {
          diffy = 1
          }
          
          print("kontrolledoubley: \(kontrolledoubley) kontrolleinty: \(kontrolleinty) diffy: \(diffy)")
          
          let intervally = Double(kontrolleinty / diffy)
          korrekturintervally = Int(round(intervally)) // Rundungsfehler aufteilen ueber Abschnitt: 
          // alle korrekturintervallx dexInt incrementieren oder decrementieren
          print("korrekturintervally: \(korrekturintervally)")
          
          if korrekturintervally < 0 // negative korrektur
          {
          print("korrekturintervally negativ")
          korrekturintervally *= -1
          korrekturintervally |= 0x8000
          }
          print("korrekturintervally mit Vorzeichenkorr: \(korrekturintervally) \n")
          }
          
          
          //       korrekturintervally = 0
          zeilenschnittdatenarray.append(UInt8(korrekturintervally & 0x00FF))
          zeilenschnittdatenarray.append(UInt8((korrekturintervally & 0xFF00)>>8))
          
          
          
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
          zeilenschnittdatenarray.append(DEVICE_MILL)
          //       print("zeilenschnittdatenarray:\t\(zeilenschnittdatenarray)")
          if schrittexInt == 0 && schritteyInt == 0
          {
          print("******  schrittexInt  0 schritteyInt  0 zeilenindex: \(zeilenindex)")
          print("\t\tdiffX: \(diffX) diffY: \(diffY)")
          }
          print("zeilenschnittdatenarray: \(zeilenschnittdatenarray)")
          
          
          if zeilenschnittdatenarray.count > 0
          {
          if !(schrittexInt == 0 && schritteyInt == 0)
          {
          //              Schnittdatenarray.append(zeilenschnittdatenarray)
          }
          }
          
          print("nach: \t xhome: \(xhome) yhome: \(yhome)")
          homedataarray.append([xhome,yhome])
          */
      } // for Zeilendaten
      print("homedataarray:\t\(homedataarray)")
      
      homexFeld.integerValue = xhome
      homeyFeld.integerValue = yhome
      
      print("report_PCB_Daten Schnittdatenarray:")
      for linie in Schnittdatenarray
      {
         print("\(linie) ")
         
      }
      print("Schnittdatenarray_n:")
      for linie in Schnittdatenarray_n
      {
         print("\(linie) ")
         
      }
      
      
      print("report_PCBDaten Schnittdatenarray count: \(Schnittdatenarray.count)")
      /*
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
       */
      /* 
       for el in SchritteArray
       {
       print(el)
       //      print("\(el["startpunktx"] ?? 0)\t \(el["startpunkty"] ?? 0) \t\(el["endpunktx"] ?? 0)\t \(el["endpunkty"] ?? 0) \t\(el["distanz"] ?? 0)\t \(el["schrittex"] ?? 0)\t\(el["schrittey"] ?? 0) \t\(el["zoomfaktor"] ?? 0) \t\(el["code"] ?? 0)")
       //  print("\(el["distanz"] ?? 0)\t \(el["schrittex"] ?? 0)\t\(el["schrittey"] ?? 0) \t\(el["zoomfaktor"] ?? 0) \t\(el["code"] ?? 0)")
       
       }
       */   
   }// report_PCB_Daten
 
   @IBAction func report_NN(_ sender: NSButton)
   {
      print("report_NN")
      let state = sender.state
      var nn = false
      if state == .on
      {
         nn = true
      }
      print("report_NN nn: \(nn)")
      if circlefloatarray.count == 0
      {
         print("report_NN circlefloatarray leer")
         return
      }
      Schnittdatenarray.removeAll()
      print("report_NN circlefloatarray.count: \(circlefloatarray.count)")
      var mill_floatarray = mill_floatArray(circarray: circlefloatarray) //
      setPCB_Output(floatarray: mill_floatarray, scale: 5, transform: transformfaktor)
      var PCBDaten = PCB_Daten(floatarray: mill_floatarray)
      
      print("report_readSVG PCBDaten")
      Schnittdatenarray.append(contentsOf:PCBDaten)
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
      
      if (PCB_Test == 0)
      {
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
      }
      else 
      {
         PCB_Test = 0
      }
      
      Plattefeld.stepperposition = 0
      cncstepperposition = 0
      
 //     Plattefeld.setStepperposition(pos:cncstepperposition)
      let anzabschnitte = Schnittdatenarray.count
         
//      Schnittdatenarray[0][26] = UInt8((anzabschnitte & 0xFF00) >> 8)
 //     Schnittdatenarray[0][27] = UInt8(anzabschnitte & 0x00FF)
      if Schnittdatenarray.count == 0 // Array im Teensy loeschen
      {
         teensy.write_byteArray[25] = 1 //erstes Element
         teensy.write_byteArray[24] = 0xF1 // Stopp
         if teensy.dev_present() > 0
         {
            let senderfolg = teensy.send_USB()
            //            print("joystickAktion report_goXY senderfolg: \(senderfolg)")
         }
         return
      }

      /*
      var i = 0
      for linie in Schnittdatenarray
      {
         print("\(i) \(linie)")
         i += 1
      }
      */
      if teensy.readtimervalid() == true
      {
         //print("PCB readtimer valid vor")
         
      }
      else 
      {
         //print("PCB readtimer not valid vor")
         
         var start_read_USB_erfolg = teensy.start_read_USB(true)
      }
      
      
      Plattefeld.setStepperposition(pos: 0) // Ersten Punkt markieren
      Schnittdatenarray[0][24] = 0xB5 //
      write_CNC_Abschnitt()
      
      if teensy.readtimervalid() == true
      {
         //print("PCB readtimer valid nach")
         
      }
      else 
      {
         print("PCB readtimer not valid nach")
      
 //     var start_read_USB_erfolg = teensy.start_read_USB(true)
      }
      
      
  //    var start_read_USB_erfolg = teensy.start_read_USB(true)

//      var readtimernote:[String:Int] = ["cncstepperposition":1]
//      readtimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(USB_read(timer:)), userInfo: readtimernote, repeats: true)

      
   } // report_send_Daten
   
   @IBAction func report_send_Step(_ sender: NSButton)
   {
      print("PCB report_send_Step")
   }
   
   @IBAction func report_clear(_ sender: NSButton)
   {
      print("PCB report_clear")
      teensy.write_byteArray[24] = 0xF1
      
      //write_CNC_Abschnitt()
      //    if (usbstatus > 0)
      //    {
      let senderfolg = teensy.send_USB()
      print("PCB report_clear senderfolg: \(senderfolg)")
      //    }
      cncstepperposition = 0
      teensy.clear_writearray()
      Schnittdatenarray.removeAll()
      circlearray.removeAll()
      CNC_DatendicArray.removeAll()
      dataTable.reloadData()
      Plattefeld.clearWeg()
      Plattefeld.needsDisplay = true
      lastklickposition.x = 0
      lastklickposition.y = 0

      print("PCB reportclear homeX: \(homeX) homeY: \(homeY)")
      homeX = 0
      homeY = 0
      homexFeld.integerValue = 0
      homeyFeld.integerValue = 0
      
      
   }
   
   @IBAction func report_home(_ sender: NSButton)
   {
      
      print("PCB report_home homex: \(homeX) homey: \(homeY)")
      Schnittdatenarray.removeAll()
      var dx = homexFeld.doubleValue * -1 
      var dy = homeyFeld.doubleValue * -1
      
 //     dx = -500
 //     dy = 0
      print("PCB report_home dx: \(dx) dy: \(dy)")
//      dx = 10
//      dy = 0
      lastklickposition.x = 0
      lastklickposition.y = 0

      cncstepperposition = 0
      var homewegarray = wegArrayMitWegXY(wegx:Double(dx), wegy:Double(dy))
      
      
      for z in 0 ... homewegarray.count-1
      {
         teensy.write_byteArray[z] = homewegarray[z]
         // print("\(pfeilwegarray[z])")
      }
      print("homewegarray")
      print("\(homewegarray)")
      teensy.write_byteArray[24] = 0xA5
      teensy.write_byteArray[25] = 3
      
      
  //    homeX += Int(dx)
  //    homeY += Int(dy)
 //     print("report_home homeX: \(homeX) homeY: \(homeY)")
  //    homexFeld.integerValue = homeX
  //    homeyFeld.integerValue = homeY
      
      if teensy.readtimervalid() == true
      {
         //print("PCB readtimer valid vor")
         
      }
      else 
      {
         //print("PCB readtimer not valid vor")
         
         var start_read_USB_erfolg = teensy.start_read_USB(true)
      }

      let senderfolg = teensy.send_USB()
      print("PCB report home senderfolg: \(senderfolg)")

   }
   
   
   func schrittdatenvektor(sxInt:Int,syInt:Int,szInt:Int, zeit:Double) -> [UInt8]
   {
      print("\n+++++++++++                               schrittdatenvektor sxInt: \(sxInt) syInt: \(syInt) szInt: \(szInt) zeit: \(zeit)")
      let sxInt_raw = (sxInt & 0x0FFFFFFF)
      let syInt_raw = (syInt & 0x0FFFFFFF)
      let szInt_raw = (szInt & 0x0FFFFFFF)
      print("\tschrittdatenvektor sxInt_raw: \(sxInt_raw) syInt_raw: \(syInt_raw) szInt_raw: \(szInt_raw) zeit: \(Int(zeit))")

      var vektor = [UInt8]()
      //print("sxInt: \(sxInt) ")
      let sxA = UInt8(sxInt & 0x000000FF)
      let sxB = UInt8((sxInt & 0x0000FF00) >> 8)
      let sxC = UInt8((sxInt & 0x00FF0000) >> 16)
      let sxD = UInt8((sxInt & 0xFF000000) >> 24)
//      print("schrittdatenvektor sxInt: \(sxInt) sxA: \(sxA) sxB: \(sxB)")
      vektor.append(sxA)
      vektor.append(sxB)
      vektor.append(sxC)
      vektor.append(sxD)
      
      let dx:Double = (zeit / Double((sxInt & 0x0FFFFFFF))) // Vorzeichen-Bit weg
      
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
      
//      print("Fehlerkorrektur X")
      var korrekturintervallx:Int = 0
      if sxInt != 0
      {
         let vorzeichenx = (sxInt & 0x80000000)
         
//         print("vorzeichenx: \(vorzeichenx)") // Richtung der Bewegung
         print("\n+++++++++++++++++++++++++++++++++++++++++++++")
         print("sxInt_raw: \(sxInt_raw) dx: \(dx) dxInt: \(dxInt)")
         let kontrolledoublex = (Double(sxInt_raw) * dx) //  Kontrolle mit Double-Wert von dx
         let kontrolleintx = sxInt_raw * dxInt //               Kontrolle mit Int-Wert von dx
         var diffx = Int(kontrolledoublex) - kontrolleintx // differenz, Rundungsfehler
         print("kontrolledoublex: \(kontrolledoublex) kontrolleintx: \(kontrolleintx) diffx: \(diffx)")
         if diffx == 0
         {
            diffx = 1
         }
         var intervallx = Double(kontrolleintx / diffx)
         
         
         let controlx = Double(sxInt_raw) / intervallx
         korrekturintervallx = Int(round(intervallx)) // Rundungsfehler aufteilen ueber Abschnitt: 
         // alle korrekturintervallx Schritte dexInt incrementieren oder decrementieren
        print("korrekturintervallx: \(korrekturintervallx) controlx: \(controlx)")
        print("\(sxInt_raw)\t\(dx)\t\(dxInt)\t\(kontrolledoublex)\t\(kontrolleintx)\t\(diffx)\t\(korrekturintervallx)\t\(controlx)")
         print("+++++++++++++++++++++++++++++++++++++++++++++\n") 
         if korrekturintervallx < 0 // negative korrektur
         {
//            print("korrekturintervallx negativ")
            korrekturintervallx *= -1
            korrekturintervallx |= 0x8000
         }
//         print("korrekturintervallx mit Vorzeichenkorr: \(korrekturintervallx) controlx: \(controlx)\n")
      }
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
      
      
//      print("Fehlerkorr Y")
      var korrekturintervally:Int = 0
      if syInt != 0
      {
         let vorzeicheny = (syInt & 0x80000000)
         
         //print("vorzeicheny: \(vorzeicheny)")
         print("\n+++++++++++++++++++++++++++++++++++++++++++++")
         print("syInt_raw: \(syInt_raw) dy: \(dy) dyInt: \(dyInt)")
         let kontrolledoubley = Int(Double(syInt_raw) * dy)
         let kontrolleinty = syInt_raw * dyInt
         var diffy = (kontrolledoubley) - kontrolleinty
         print("kontrolledoubley: \(kontrolledoubley) kontrolleinty: \(kontrolleinty) diffy: \(diffy) vorzeicheny: \(vorzeicheny)")
         if diffy == 0
         {
            diffy = 1
         }
         let intervally = Double(kontrolleinty / diffy)
         
         let controly = Double(syInt_raw) / intervally
         korrekturintervally = Int(round(intervally))
         
         print("korrekturintervally: \(korrekturintervally)  controly: \(controly)\n")
         
  print("+++++++++++++++++++++++++++++++++++++++++++++\n")       
         if korrekturintervally < 0 // negative korrektur
         {
 //           print("korrekturintervally negativ")
            korrekturintervally *= -1
            korrekturintervally |= 0x8000
         }
 //        print("korrekturintervally mit Vorzeichenkorr: \(korrekturintervally)  controly: \(controly)\n")
      }
      vektor.append(UInt8(korrekturintervally & 0x00FF))
      vektor.append(UInt8((korrekturintervally & 0xFF00)>>8))
      
      // Motor C Schritte
      if szInt == 0
      {
      vektor.append(0)
      vektor.append(0)
      vektor.append(0)
      vektor.append(0)
      // Motor C delay
      vektor.append(0)
      vektor.append(0)
      vektor.append(0)
      vektor.append(0)
      }
      else
      {
         let szA = UInt8(szInt & 0x000000FF)
         let szB = UInt8((szInt & 0x0000FF00) >> 8)
         let szC = UInt8((szInt & 0x00FF0000) >> 16)
         let szD = UInt8((szInt & 0xFF000000) >> 24)
         vektor.append(szA)
         vektor.append(szB)
         vektor.append(szC)
         vektor.append(szD)

         let dz:Double = (zeit / Double((szInt & 0x0FFFFFFF))) // Vorzeichen-Bit weg
         
         let dzIntround = round(dz)
         var dzInt = 0
         if dzIntround >= Double(Int.min) && dzIntround < Double(Int.max)
         {
            // print("delayxInt OK")
            dzInt = Int(dzIntround)
         }
         let dzA = UInt8(dzInt & 0x000000FF)
         let dzB = UInt8((dzInt & 0x0000FF00) >> 8)
         vektor.append(dzA)
         vektor.append(dzB)
         
         // keine Fehlerkorrektur
         vektor.append(0)
         vektor.append(0)
        
         
      }
      vektor.append(0) // el 24, code
      vektor.append(0) // el 25, lage
      
      vektor.append(0) // el 26, zeilenindexh
      vektor.append(0) // el 27, zeilenindexl
      
      // motorstatus
      var motorstatus:UInt8 = 0
      var maxsteps:Int = 0
//      print("\tschrittdatenvektor sxInt_raw: \(sxInt_raw) syInt_raw: \(syInt_raw) szInt_raw: \(szInt_raw) zeit: \(Int(zeit))")
/*
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
 */
      if (abs(syInt_raw) > abs(sxInt_raw)) // wer hat mehr schritte x
      {
         maxsteps = abs(syInt_raw)
         motorstatus = (1<<MOTOR_B)
      }
      else 
      {
         maxsteps = abs(sxInt_raw)
         motorstatus = (1<<MOTOR_A)
      }
     
      if (sxInt == 0) && (syInt == 0) && (szInt != 0)
      {
         motorstatus = (1<<MOTOR_C)
      }
      print("schrittdatenvektor motorstatus: \(motorstatus)")
      vektor.append(motorstatus)
      vektor.append(77) // Platzhalter PWM
      
      let timerintervall = timerintervallFeld.integerValue
      vektor.append(UInt8((timerintervall & 0xFF00)>>8))
      vektor.append(UInt8(timerintervall & 0x00FF))
      vektor.append(DEVICE_MILL)
      
      // Drill
      vektor.append(0)
      vektor.append(0)
      vektor.append(0)
      vektor.append(0)

 //     print("schrittdatenvektor sxInt: \(sxInt) dxInt: \(dxInt) syInt: \(syInt) dyInt: \(dyInt) zeit: \(zeit)")
      return vektor
   }
   
   func wegArrayMitWegXY(wegx:Double, wegy:Double) ->[UInt8]
   {
       
      zoomfaktor = zoomFeld.doubleValue
 //     print("PCB wegArrayMitWegXY wegX: \(wegx) wegY: \(wegy) propfaktor: \(propfaktor)")
      var maxsteps:Double = 0
      var weg = [Double]()
      
      let distanzX = wegx *  INTEGERFAKTOR
      let distanzY = wegy *  INTEGERFAKTOR
 
      //     let distanzZ = wegz *  1000000
      
      let wegX = distanzX * zoomfaktor 
      let wegY = distanzY * zoomfaktor 
      let distanz = (wegX*wegX + wegY*wegY).squareRoot()
//      print("++++          wegArrayMitWegXY  distanzX: \(distanzX)  distanzY: \(distanzY)  distanz: \(distanz)")
      var speed = speedFeld.intValue
      
      if ramp_OK_Check.state == NSControl.StateValue.on
      {
         speed *= 2
      }
      /*
      SVG: 72 dpi / inch
       1 p > 0.3528mm
       1mm > 2.8346p
       Multiplikator in readSVG: 1000000 (INTEGERFAKTOR)
      
       */
      
      let propfaktor = 2834645.67 // 72 dpi > 25.4mm
      
      
      let start = [0,0]
      let ziel = [wegX,wegY]
      
      let zeit:Double = Double(distanz)/Double(speed) //   Schnittzeit für Distanz
      
     // print("********           wegArrayMitWegXY zeit: \(zeit) ")
      
      var schrittex = Double(stepsFeld.integerValue) * distanzX  
 //     var schrittex = Double(stepsFeld.integerValue) * wegX  
      
      
      schrittex /= propfaktor // Umrechnung in mm
      let schrittexmm = schrittex/stepsFeld.doubleValue
 //     print("wegArrayMitWegXY schrittex mm: \(schrittexmm)")
      
      var schrittexRound = round(schrittex)
      var schrittexInt:Int = 0
      if schrittexRound >= Double(Int.min) && schrittexRound < Double(Int.max)
      {
            
         schrittexInt = Int(schrittexRound)
       //  print("wegArrayMitWegXY schritteXInt OK: \(schrittexInt)")
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
     // var schrittey = Double(stepsFeld.integerValue) * wegY
      
      schrittey /= propfaktor
      let schritteymm = schrittey/stepsFeld.doubleValue
//     print("wegArrayMitWegXY schrittey mm: \(schritteymm)")
      var schritteyRound = round(schrittey)
      var schritteyInt:Int = 0
      if schritteyRound >= Double(Int.min) && schritteyRound < Double(Int.max)
      {
         
         schritteyInt = Int(schritteyRound)
//         print("wegArrayMitWegXY schritteyInt OK: \(schritteyInt)")
         if schritteyInt < 0 // negativer Weg
         {
 //           print("schritteyInt negativ")
            schritteyInt *= -1
            schritteyInt |= 0x80000000
         }
      }
      else
      {
         print("schritteYround zu gross")
      }
      
      let schrittezInt = 0
//      print("+++           wegArrayMitWegXY vor schnittdatenvektor schrittexInt: \(schrittexInt) schritteyInt: \(schritteyInt) schrittezInt: \(schrittezInt) zeit: \(zeit) speed: \(speed)")

      var wegschnittdatenarray:[UInt8] = schrittdatenvektor(sxInt:schrittexInt,syInt:schritteyInt, szInt:0, zeit:zeit  )// Array mit Daten fuer USB
      
      return wegschnittdatenarray
   }
   

   
   @IBAction func report_goXY(_ sender: NSButton) // 
   {
      // left: 1, right: 2, up: 3, down: 4
      print("PCB report_goXY tag: \(sender.tag) propfaktor: \(propfaktor)")
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
      case 13: // test
         dy = 20
         dx = 20
         break
         
      default:
         break
      }
      lastklickposition.x = 0
      lastklickposition.y = 0

        var wegarray = wegArrayMitWegXY(wegx: Double(dx),wegy:Double(dy))
     
      
      //     var wegarray = wegArrayMitWegXY(wegx:dx, wegy:dy)
      
      wegarray[32] = DEVICE_MILL
      Schnittdatenarray.removeAll(keepingCapacity: true)
      cncstepperposition = 0
      if Schnittdatenarray.count == 0 // Array im Teensy loeschen
      {
         wegarray[25] = 1 //erstes Element
         //teensy.write_byteArray[24] = 0xE0 // Stopp
         if teensy.dev_present() > 0
         {
            let senderfolg = teensy.send_USB()
            print("report_goXY report_goXY senderfolg: \(senderfolg)")
         }
         
      }
      
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
         
         
         teensy.start_read_USB(true)
      }
      
   }
   
   func write_CNC_Abschnitt()
   {
      print("+++              PCB write_CNC_Abschnitt cncstepperposition: \(cncstepperposition) Schnittdatenarray.count: \(Schnittdatenarray.count)")
      stepperpositionFeld.integerValue = cncstepperposition
      
      if cncstepperposition == Schnittdatenarray.count
      {
         print("write_CNC_Abschnitt cncstepperposition ist Schnittdatenarray.count")
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
            var schritteAX:UInt32 = UInt32(tempSchnittdatenArray[0]) | UInt32(tempSchnittdatenArray[1])<<8 | UInt32(tempSchnittdatenArray[2])<<16 | UInt32((tempSchnittdatenArray[3] & 0x7F))<<24;
            //      print("schritteAX: \(schritteAX) ")
            var schritteAY:UInt32 = UInt32(tempSchnittdatenArray[8]) | UInt32(tempSchnittdatenArray[9])<<8 | UInt32(tempSchnittdatenArray[10])<<16 | UInt32((tempSchnittdatenArray[11] & 0x7F))<<24;
            //    print("schritteAY: \(schritteAY) ")
            print("     schritteAX: \(schritteAX) schritteAY: \(schritteAY)")
            
            for element in tempSchnittdatenArray
            {
               teensy.write_byteArray.append(element)
            }
          print("cncstepperposition: \(cncstepperposition) write_byteArray: \(teensy.write_byteArray)")
            print("    write_byteArray24: \(teensy.write_byteArray[24])")
            
            
            let senderfolg = teensy.send_USB()
            print("write_CNC_Abschnitt senderfolg: \(senderfolg)")
            /*
            
            print("0: \(tempSchnittdatenArray[0]) ")
            print("1: \(tempSchnittdatenArray[1]) ")
            print("2: \(tempSchnittdatenArray[2]) ")
            print("3: \(tempSchnittdatenArray[3]) ")
            */
            

            cncstepperposition += 1
            
            
            
         } // else

      }// if count
      
   }
   
   @objc override func usbstatusAktion(_ notification:Notification) 
   {
      let info = notification.userInfo
     // print("PCB usbstatusAktion:\t \(info)")
      let status:Int = info!["usbstatus"] as! Int // 
      print("PCB usbstatusAktion:\t \(status)")
 //     usbstatus = Int32(status)
      
   }

   @objc override func usbattachAktion(_ notification:Notification) 
   {
      let info = notification.userInfo
     // print("PCB usbattachAktion:\t \(info)")
      let status:Int = info!["attach"] as! Int // 
     print("PCB usbattachAktion:\t \(status)")
      if status == USBREMOVED
      {
         
        // USB_OK_Feld.image = notokimage
      }
      //usbstatus = Int32(status)
      
   }

   @objc  override func mausstatusAktion(_ notification:Notification)
   {
      let info = notification.userInfo
      print("PCB mausstatusAktion:\t \(String(describing: info))")
      let devtag = info?["devtag"] as! Int
      if devtag == 1
      {
      let pfeiltag = info?["tag"] as! Int
      var schrittweite = info?["schrittweite"] as! Int
      schrittweite = pfeilschrittweite
         var dx:Int = 0
      var dy:Int = 0
      var vorzeichenx = 0;
      var vorzeicheny = 0;
      print("PCB mausstatusAktion devtag:\t \(devtag ) pfeiltag:\t \(pfeiltag ) schrittweite: \(schrittweite)\t")
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
            //dx |= 0x80000000
            vorzeichenx = 1
            break
         case 4: // down
            dy = schrittweite * (-1)
            //dy |= 0x80000000
            vorzeicheny = 1
            break
         default:
            break
            
            
         }
         print("mausstatusAktion dx: \(dx) dy: \(dy)")
         var pfeilwegarray = wegArrayMitWegXY(wegx:Double(dx), wegy:Double(dy))
         
         pfeilwegarray[32] = 1
        
         
         
         for z in 0 ... pfeilwegarray.count-1
         {
            teensy.write_byteArray[z] = pfeilwegarray[z]
    //         print("\(z) \(pfeilwegarray[z])")
         }
         print("mausstatusAktion pfeilwegarray")
         print("\(pfeilwegarray)")
         teensy.write_byteArray[24] = 0xB5
         
         
         //      homeX += Int(dx)
         //     homeY += Int(dy)
        // print("mausstatusaktion homeX: \(homeX) homeY: \(homeY)")
         //     homexFeld.integerValue = homeX
         //     homeyFeld.integerValue = homeY
         if teensy.readtimervalid() == true
         {
            //print("PCB readtimer valid vor")
            
         }
         else 
         {
            //print("PCB readtimer not valid vor")
            
            var start_read_USB_erfolg = teensy.start_read_USB(true)
         }

         
         let senderfolg = teensy.send_USB()
      }
   }

 @objc func dataTableAktion(_ notification:Notification) 
 {
   let info = notification.userInfo
   let zeilenindex:Int = info?["selrow"] as! Int
   let datazeile = circlearray[zeilenindex]
   //print("dataTableAktion zeilenindex: \(zeilenindex) datazeile: \(datazeile) lastcncindex: \(lastcncindex)")
   let lastX = circlearray[lastcncindex][1]
   let lastY = circlearray[lastcncindex][2]
   let aktX = datazeile[1]
   let aktY = datazeile[2]
   var maxsteps:Double = 0
   var zeilendic:[String:Any] = [:]
   var position:UInt8 = 0
   lastcncindex = zeilenindex
 //  print("dataTableAktion zoomfaktor: \(zoomfaktor)")
   let diffX:Double = (Double(aktX - lastX)) * zoomfaktor
   let diffY:Double = (Double(aktY - lastY)) * zoomfaktor
   
   
   let distanzX = Double(aktX - lastX)  * zoomfaktor  
   let distanzY = Double(aktY - lastY)  * zoomfaktor  
   
   let dx = (Double(aktX - lastX))/propfaktor
   let dy = (Double(aktY - lastY))/propfaktor
   
   
   var dataTableWeg = wegArrayMitWegXY(wegx:dx, wegy:dy)
   dataTableWeg[32] = DEVICE_MILL
   dataTableWeg[24] = 0xB5
   dataTableWeg[25] = 3 
   
   
  // print("dataTableAktion dataTableWeg: \(dataTableWeg)")
   if Schnittdatenarray.count > zeilenindex
   {
//      print("dataTableAktion zeilenindex: \(zeilenindex)\n Schnittdatenarray : \(Schnittdatenarray[zeilenindex])")
   }
   
   Schnittdatenarray.append(dataTableWeg)
   
   if Schnittdatenarray.count > 0
   {
      print("dataTableAktion start CNC cncstepperposition: \(cncstepperposition)")
      write_CNC_Abschnitt()   
      
      teensy.start_read_USB(true)
   }
   
   }
   
   func drillMoveArray(wegz:Double) ->[UInt8] // z-Richtung +: up -: down
   {
      zoomfaktor = zoomFeld.doubleValue
      print("PCB drillUp wegz: \(wegz) ")
      let distanzZ = wegz *  INTEGERFAKTOR
      
      let wegZ = distanzZ * zoomfaktor 
      var speed = speedFeld.intValue
      if ramp_OK_Check.state == NSControl.StateValue.on
      {
         speed *= 2
      }

      let distanz = abs(wegZ)
//      print("distanz: \(distanz)")
      let propfaktor = 2834645.67 // 14173.23
      let zeit:Double = Double((distanz))/Double(speed) //   Schnittzeit für Distanz
      
      
      var schrittez = Double(stepsFeld.integerValue) * distanzZ 
      schrittez /= propfaktor
      let schrittezRound = round(schrittez)
      var schrittezInt:Int = 0
      if schrittezRound >= Double(Int.min) && schrittezRound < Double(Int.max)
      {
         //    
         schrittezInt = Int(schrittezRound)
 //        print("schrittezInt OK: \(schrittezInt)")
         if schrittezInt < 0 // negativer Weg
         {
 //           print("schrittezInt negativ")
            schrittezInt *= -1
            schrittezInt |= 0x80000000
         }
      }
      else
      {
         print("schritteZround zu gross")
      }
 //     motorstatus = (1<<MOTOR_C)
      var drillschnittdatenarray:[UInt8] = schrittdatenvektor(sxInt:0, syInt:0, szInt:schrittezInt, zeit:zeit  )// Array mit Daten fuer USB
      
//      print("drillschnittdatenarray: \(drillschnittdatenarray)")
      return drillschnittdatenarray
   }
   
   @IBAction func report_move_Drill(_ sender: NSButton)
   {
      print("\n+++++++     report_move_Drill tag: \(sender.tag)")
      var drillweg = 50
      var drilltag = sender.tag
      if drilltag == 222
      {
         drillweg *= -1
      }
      
     
      var drillWegArray = drillMoveArray(wegz: Double(drillweg))
      drillWegArray[24] = 0xB5
      drillWegArray[29] = 0 // PWM
      drillWegArray[25] = 3
      drillWegArray[32] = DEVICE_MILL
      Schnittdatenarray.append(drillWegArray)
      
      if Schnittdatenarray.count > 0
      {
         print("dataTableAktion start CNC")
         write_CNC_Abschnitt()   
         
         teensy.start_read_USB(true)
      }

   }
   @IBAction func report_Drill(_ sender: NSButton)
   {
      print("\n+++++++     report_Drill tag: \(sender.tag) ")
      drill(weg:20)
      return
      let stepperpos = stepperpositionFeld.integerValue
      var drillweg = 20
      var drillWegArray = drillMoveArray(wegz: Double(drillweg))
      drillWegArray[24] = 0xBA
      drillWegArray[29] = 0 // PWM
      drillWegArray[25] = 0 // lage
      drillWegArray[32] = DEVICE_MILL
      print("report_Drill cncstepperposition: \(cncstepperposition)");
      print(" Schnittdatenarray vor insert count:\(Schnittdatenarray.count)")
      for line in Schnittdatenarray
      {
         print(line)
      }
      Schnittdatenarray.insert(drillWegArray, at: cncstepperposition)  
      print(" Schnittdatenarray nach insert: ")
      for line in Schnittdatenarray
      {
         print(line)
      }

      if teensy.readtimervalid() == true
      {
         //print("PCB readtimer valid vor")
      }
      else 
      {
         var start_read_USB_erfolg = teensy.start_read_USB(true)
      }

      if Schnittdatenarray.count > 0
      {
         print("report_Drill write CNC")
         write_CNC_Abschnitt()   
         print("report_Drill cncstepperposition nach: \(cncstepperposition)");
         
      }


   }
   
   @objc func drill(weg:Int)
   {
      print("\n+++++++     drill weg: \(weg)")
      let count = Schnittdatenarray.count
      print("drill Schnittdatenarray.count: \(count)");
      let stepperpos = stepperpositionFeld.integerValue
      print("drill stepperpos: \(stepperpos)");
      var drillweg = weg
      var drillWegArray = drillMoveArray(wegz: Double(drillweg))
      drillWegArray[24] = 0xBA
      drillWegArray[29] = 0 // PWM
      drillWegArray[25] = 3 // lage
      drillWegArray[32] = DEVICE_MILL
      drillWegArray[33] = 0 // drillstatus
      print("\n*********************************************************")
      print("report_Drill cncstepperposition: \(cncstepperposition)");
      print(" Schnittdatenarray vor insert count:\(Schnittdatenarray.count)")
      for line in Schnittdatenarray
      {
         print(line)
      }
      print("*********************************************************")
      Schnittdatenarray.insert(drillWegArray, at: cncstepperposition) 
      print("\n*********************************************************")
      print(" Schnittdatenarray nach insert: ")
      for line in Schnittdatenarray
      {
         print(line)
      }
      print("*********************************************************\n")
      if teensy.readtimervalid() == true
      {
         //print("PCB readtimer valid vor")
      }
      else 
      {
         var start_read_USB_erfolg = teensy.start_read_USB(true)
      }
      
      if Schnittdatenarray.count > 0
      {
         print("report_Drill write CNC")
         write_CNC_Abschnitt()   
         print("report_Drill cncstepperposition nach: \(cncstepperposition)");
         
      }
      
      
      
   }
 // MARK: joystickaktion
   @objc override func joystickAktion(_ notification:Notification) 
   {
  //    print("PCB joystickAktion usbstatus:\t \(usbstatus) selectedDevice: \(selectedDevice) ident: \(self.view.identifier)")
      let sel = NSUserInterfaceItemIdentifier.init(selectedDevice)
     // if (selectedDevice == self.view.identifier)
      if (sel == self.view.identifier)
      {
        print("PCB joystickAktion passt")
         
         let info = notification.userInfo
         let punkt:CGPoint = info?["punkt"] as! CGPoint
         let wegindex:Int = info?["index"] as! Int // 
         let first:Int = info?["first"] as! Int
  //       print("Basis joystickAktion:\t \(punkt)")
         print("x: \(punkt.x) y: \(punkt.y) index: \(wegindex) first: \(first)")
         
         
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
         goto_x.integerValue = Int(Double(x*faktorw))
         joystick_x.integerValue = Int(Double(x*faktorw))
         goto_x_Stepper.integerValue = Int(Double(x*faktorw))
         let weg0 = UInt16(Double(x*faktorw) * FAKTOR0)
         //print("x: \(x) weg0: \(weg0)")
         teensy.write_byteArray[SCHRITTEX_A] = UInt8((weg0 & 0xFF00) >> 8) // hb
         teensy.write_byteArray[SCHRITTEX_B] = UInt8((weg0 & 0x00FF) & 0xFF) // lb
         
         
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
         goto_y.integerValue = Int(Double(y*faktorh))
         joystick_y.integerValue = Int(Double(y*faktorh))
         goto_y_Stepper.integerValue = Int(Double(y*faktorh))
         let weg1 = UInt16(Double(y*faktorh) * FAKTOR1)
         //print("y: \(y) weg1: \(weg1)")
         teensy.write_byteArray[DELAYX_A] = UInt8((weg1 & 0xFF00) >> 8) // hb
         teensy.write_byteArray[DELAYX_B] = UInt8((weg1 & 0x00FF) & 0xFF) // lb
         let achse2 =  UInt16(Double(z*faktorz) * FAKTOR2)
         teensy.write_byteArray[SCHRITTEY_A] = UInt8((achse2 & 0xFF00) >> 8) // hb
         teensy.write_byteArray[SCHRITTEY_B] = UInt8((achse2 & 0x00FF) & 0xFF) // lb
         
         
         let message:String = info?["message"] as! String
         if ((message == "mousedown") && (first >= 0))// Polynom ohne mousedragged
         {
            teensy.write_byteArray[0] = SET_RING
            let anz = schnittPfad?.anzahlPunkte()
            if (wegindex > 1)
            {
               print("")
               print("basis joystickAktion cont weg0: \(weg0) weg1: \(weg1)  achse2: \(achse2) anz: \(String(describing: anz)) wegindex: \(wegindex)")
               
               let lastposition = schnittPfad?.pfadarray.last
               
               let lastx:Int = Int(lastposition!.x)
               let nextx:Int = Int(weg0)
               let hypx:Int = (nextx - lastx) * (nextx - lastx)
               
               let lasty:Int = Int(lastposition!.y)
               let nexty:Int = Int(weg1)
               let hypy:Int = (nexty - lasty) * (nexty - lasty)
               
               let lastz:Int = Int(lastposition!.z)
               let nextz:Int = Int(achse2)
               let hypz:Int = (nextz - lastz) * (nextz - lastz)
               
               print("joystickAktion lastx: \(lastx) nextx: \(nextx) lasty: \(lasty) nexty: \(nexty)")
               
               let hyp:Double = (sqrt((Double(hypx + hypy + hypz))))
               
               let anzahlsteps = hyp/schrittweiteFeld.doubleValue
               print("Basis joystickAktion hyp: \(hyp) anzahlsteps: \(anzahlsteps) ")
               
               teensy.write_byteArray[schrittezA] = UInt8((Int(hyp) & 0xFF00) >> 8) // hb
               teensy.write_byteArray[schrittezB] = UInt8((Int(hyp) & 0x00FF) & 0xFF) // lb
               
               teensy.write_byteArray[delayzC] = UInt8((Int(anzahlsteps) & 0xFF00) >> 8) // hb
               teensy.write_byteArray[delayzD] = UInt8((Int(anzahlsteps) & 0x00FF) & 0xFF) // lb
               
               teensy.write_byteArray[delayzA] = UInt8(((wegindex-1) & 0xFF00) >> 8) // hb // hb // Start, Index 0
               teensy.write_byteArray[delayzB] = UInt8(((wegindex-1) & 0x00FF) & 0xFF) // lb
               
               print("Basis joystickAktion hypx: \(hypx) hypy: \(hypy) hypz: \(hypz) hyp: \(hyp)")
               
            }
            else
            {
               print("basis joystickAktion start weg0: \(weg0) weg1: \(weg1)  achse2: \(achse2) anz: \(anz) wegindex: \(wegindex)")
               teensy.write_byteArray[schrittezA] = 0 // hb // Start, keine Hypo
               teensy.write_byteArray[schrittezB] = 0 // lb
               teensy.write_byteArray[delayzA] = 0 // hb // Start, Index 0
               teensy.write_byteArray[delayzB] = 0 // lb
               
            }
            
            schnittPfad?.addPosition(newx: weg0, newy: weg1, newz: 0)
         }
         
         if (usbstatus > 0)
         {
            let senderfolg = teensy.send_USB()
            print("joystickAktion senderfolg: \(senderfolg)")
         }
      }
      else
      {
  //       print("PCB joystickAktion passt nicht")
      }
      
   }
   
 // MARK: NEWDATAAKTION 
   @objc override func newDataAktion(_ notification:Notification) 
   {
      // analog readUSB() in USB_Stepper
      
      
      print("PCB newDataAktion")
  //    let lastData = teensy.getlastDataRead()
      
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
      //print("new Data")
      
      var data1 = notification.userInfo?["data"] 
      var data:[UInt8] = notification.userInfo?["data"] as! [UInt8] // teensy.read_byteArray
//      print("von teensy: data: \(String(describing: data)) ") // data: Optional([0, 9, 51, 0,....
      var i = 0
            
      let taskcode = data[0]
      let codehex = String(format:"%02X", taskcode)
      
      print("newDataAktion taskcode: \(taskcode) hex: \(codehex)")
      
      if taskcode == 0
         {
            print("newDataAktion taskcode: NULL")
            return
      }
      var notificationDic = [String:Any]()
      let cncstatus:UInt8 = data[20] // cncstatus
      
      let abschnittnummer:Int = Int((data[5] << 8) | data[6])
      let ladeposition = data[8]
      
 //     Plattefeld.setStepperposition(pos:abschnittnummer)
      
 //     print("PCB newDataAktion  taskcode: \(taskcode) hex: \(codehex) abschnittnummer: \(abschnittnummer) ladeposition: \(ladeposition)")
      let timeintervall =  Int((data[14] << 8) | data[15])
      
      var AnschlagSet:IndexSet = IndexSet()
      let nc = NotificationCenter.default
      var device = data[24]
//      print("PCB newDataAktion  device: \(device)")
// MARK: *** DEVICE_MILL       
      if device == DEVICE_MILL
      {
         print("DEVICE_MILL")
         
         
         switch taskcode
         {
         case 0xA1:
            print("PCB newDataAktion  A1 abschnitte: \(Schnittdatenarray.count)") // mehrere Schritte
            let ladepos =  Int(data[8] )
            Plattefeld.setStepperposition(pos:ladepos)
            
            let state = steppercontKnopf.state
            
            if state == .off
            {
               print("PCB newDataAktion  A1 return");
               
               
               return;
            }

            
            
            break;
            
         case 0xAD:
            print("PCB newDataAktion  AD TASK END ")
            let abschnittnum = Int((data[5] << 8) | data[6])
            
            let ladepos =  Int((data[7] << 8) | data[8] )
            print("newDataAktion  AD ladepos: \(ladepos)")
            Plattefeld.setStepperposition(pos:ladepos+1)
            print("newDataAktion  AD abschnittnummer: \(abschnittnum) ladepos: \(ladepos)")
            notificationDic["taskcode"] = taskcode
            nc.post(name:Notification.Name(rawValue:"usbread"),
                    object: nil,
                    userInfo: notificationDic)     
            if teensy.readtimervalid() == true
            {
               print("PCB AD readtimer valid")
               //teensy.readtimer?.invalidate()
            }

            break
            
         case 0xAF:
            
            print("newDataAktion  AF next ")
            let abschnittnum = Int((data[5] << 8) | data[6])
            let ladepos =  Int(data[8] )
            print("newDataAktion  AF abschnittnum: \(abschnittnum) ladepos: \(ladepos)")
            
            break

         case 0xB6:
            print("newDataAktion  B6 Abschnitt 0 abschnitte: \(Schnittdatenarray.count)")
             // Data angekommen
            /*
            let state = steppercontKnopf.state
             if state == .off
             {
               
               print("PCB newDataAktion  B6 return");
  //             return;
             }
          */
            
             
         break
         
         case 0xBB:
            print("newDataAktion  B8 Drill ")
            let stepperpos = stepperpositionFeld.integerValue 
            let datacount = Schnittdatenarray.count
            print("newDataAktion  B8 stepperpos: \(stepperpos) datacount: \(datacount)")
            let drillstatus:UInt8 = data[22]
            print("newDataAktion  B8 drillstatus: \(drillstatus)")
            if drillstatus > 1
            {
               //drillWegArray[25] = 0xFF;
               //teensy.write_byteArray.removeAll(keepingCapacity: true)
               
 //              teensy.write_byteArray[24] = 0xBA
 //              teensy.write_byteArray[25] = 0xFF
               
              // if (usbstatus > 0)
              // {
//                  let senderfolg = teensy.send_USB()
//                  print("newDataAktion BB senderfolg: \(senderfolg)")
               //}
               //return
               break
            }
             
            var drillweg = -20
            var drillWegArray = drillMoveArray(wegz: Double(drillweg))
            drillWegArray[24] = 0xBA
            drillWegArray[29] = 0 // PWM
            drillWegArray[25] = 3 // lage
            
 
            drillWegArray[32] = DEVICE_MILL
            drillWegArray[33] = drillstatus
            print("\n*********************************************************")
            print("BB cncstepperposition: \(cncstepperposition)");
            print(" Schnittdatenarray vor insert count:\(Schnittdatenarray.count)")
            for line in Schnittdatenarray
            {
               print(line)
            }
            print("*********************************************************")

            Schnittdatenarray.insert(drillWegArray, at: datacount)  
            print("\n*********************************************************")
            print(" Schnittdatenarray nach insert: ")
            for line in Schnittdatenarray
            {
               print(line)
            }
            print("*********************************************************\n")

            //print(" Schnittdatenarray nach insert: \(Schnittdatenarray)")
            if teensy.readtimervalid() == true
            {
               //print("PCB readtimer valid vor")
            }
            else 
            {
               var start_read_USB_erfolg = teensy.start_read_USB(true)
            }
            /*
            if Schnittdatenarray.count > 0
            {
               print("report_Drill")
               write_CNC_Abschnitt()   
               return
            }
             */
            break
            
         case 0xE1:
            print("newDataAktion  E1 mouseup HALT")
            Schnittdatenarray.removeAll()
            if teensy.readtimervalid() == true
            {
               teensy.readtimer?.invalidate()
            }
            cncstepperposition = 0
            break
            
         case 0xEA:
            print("newDataAktion  home gemeldet")
            break
         case 0xD0:
            print("newDataAktion  letzter Abschnitt abschnittnummer: \(abschnittnummer)")
            Plattefeld.setStepperposition(pos:abschnittnummer)
            let ladepos =  Int(data[8] )
            notificationDic["taskcode"] = taskcode
            nc.post(name:Notification.Name(rawValue:"usbread"),
                    object: nil,
                    userInfo: notificationDic)
            break
            
         case 0xC5:
            let motor = data[1]
            let anschlagstatus = data[12]
            let richtung = data[13]
            let cncstatus = data[20]
            let anschlagcode = data[14]
            print("newDataAktion  C5 Anschlag")
            print("  motor: \(motor)  \nanschlagstatus: \(anschlagstatus)  \nrichtung: \(richtung) \ncncstatus: \(cncstatus) \nanschlagcode: \(anschlagcode)")
            

            
            
         default:
            print("newDataAktion default abschnittnummer: \(abschnittnummer)")
            Plattefeld.setStepperposition(pos:abschnittnummer)
            break
         }// switch taskcode
         
         
         
         //      print("newDataAktion writecncabschnitt")
         
         // **************************************
         let state = steppercontKnopf.state
        
            // print("newDataAktion writecncabschnitt steppercontKnopf state: \(state)")
         
         if state == .on
         {
            print("newDataAktion writecncabschnitt go cncstepperposition: \(cncstepperposition) Schnittdatenarray.count: \(Schnittdatenarray.count)")
            if cncstepperposition < Schnittdatenarray.count
            { 
             write_CNC_Abschnitt()
            }
         }
        
         // **************************************
         
         //      print("newDataAktion  end\n\n")
      } // if DEVICE
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
   
   func kreuz(startnummer:Int)->[[UInt8]]
   {
      var index = startnummer
      var kreuzarray = [[UInt8]]()
      var dx:Double = 20
      var dy:Double = 20
      var lastkreuzpunktx = [0,0]
      var kreuzwegarray = wegArrayMitWegXY(wegx: dx , wegy: dy) // rechts oben
//      kreuzwegarray[24] = 0xB3
      kreuzwegarray[25] = 0
      kreuzwegarray[32] = 1
      kreuzwegarray[26] = UInt8((index & 0xFF00) >> 8)
      kreuzwegarray[27] = UInt8(index & 0x00FF)
      index += 1
      startnummer
      kreuzarray.append(kreuzwegarray)
      kreuzwegarray = wegArrayMitWegXY(wegx: -2*dx , wegy: -2*dy) // links unten
 //     kreuzwegarray[24] = 0xB3
      kreuzwegarray[32] = 1
      kreuzwegarray[25] = 0
      kreuzwegarray[26] = UInt8((index & 0xFF00) >> 8)
      kreuzwegarray[27] = UInt8(index & 0x00FF)
      index += 1

      kreuzarray.append(kreuzwegarray)
      kreuzwegarray = wegArrayMitWegXY(wegx: dx , wegy: dy) // mitte 
 //     kreuzwegarray[24] = 0xB3
      kreuzwegarray[32] = 1
      kreuzwegarray[25] = 0
      kreuzwegarray[26] = UInt8((index & 0xFF00) >> 8)
      kreuzwegarray[27] = UInt8(index & 0x00FF)
      index += 1

      kreuzarray.append(kreuzwegarray)
      kreuzwegarray = wegArrayMitWegXY(wegx: -dx , wegy: dy) // links oben 
 //     kreuzwegarray[24] = 0xB3
      kreuzwegarray[32] = 1
      kreuzwegarray[25] = 0
      kreuzwegarray[26] = UInt8((index & 0xFF00) >> 8)
      kreuzwegarray[27] = UInt8(index & 0x00FF)
      index += 1

      kreuzarray.append(kreuzwegarray)
      kreuzwegarray = wegArrayMitWegXY(wegx: 2*dx , wegy: -2*dy) // rechts unten
  //    kreuzwegarray[24] = 0xB3
      kreuzwegarray[32] = 1
      kreuzwegarray[25] = 0
      kreuzwegarray[26] = UInt8((index & 0xFF00) >> 8)
      kreuzwegarray[27] = UInt8(index & 0x00FF)
      index += 1

      kreuzarray.append(kreuzwegarray)
      kreuzwegarray = wegArrayMitWegXY(wegx: -dx , wegy: dy) // mitte
 //     kreuzwegarray[24] = 0xB3
      kreuzwegarray[25] = 0
      kreuzwegarray[32] = 1
      kreuzwegarray[26] = UInt8((index & 0xFF00) >> 8)
      kreuzwegarray[27] = UInt8(index & 0x00FF)
      index += 1

      kreuzarray.append(kreuzwegarray)
      print("kreuzarray: \(kreuzarray)")
      
      return kreuzarray
   }
   
   @IBAction func report_send_TextDaten(_ sender: NSButton)
   {
      print("report_send_TextDaten")
  //    clearteensy()
      let dx = dxFeld.doubleValue
      let dy = dyFeld.doubleValue
      
      print("report_send_TextDaten dx: \(dx) dy: \(dy)")
      lastklickposition.x = 0
      lastklickposition.y = 0
      let punkt:NSPoint = NSMakePoint(CGFloat(dx), CGFloat(dy))
      var wegarray = wegArrayMitWegXY(wegx: Double(punkt.x - CGFloat(lastklickposition.x)),wegy:Double(punkt.y - CGFloat(lastklickposition.y)))
      //     var wegarray = wegArrayMitWegXY(wegx:dx, wegy:dy)
      
      wegarray[32] = DEVICE_MILL
      Schnittdatenarray.removeAll(keepingCapacity: true)
      cncstepperposition = 0
      if Schnittdatenarray.count == 0 // Array im Teensy loeschen
      {
         teensy.write_byteArray[25] = 1 //erstes Element
         //teensy.write_byteArray[24] = 0xE0 // Stopp
         if teensy.dev_present() > 0
         {
 //           let senderfolg = teensy.send_USB()
 //           print("PCB report_send_TextDaten clear senderfolg: \(senderfolg)")
         }
         
      }
      
      wegarray[25] = 3 // nur 1 Abschnitt
      
      wegarray[24] = 0xB3
      
      var zeilenposition:UInt8 = 0
      Schnittdatenarray.append(wegarray)
      stepperschritteFeld.integerValue = Schnittdatenarray.count
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
            print("PCB report home start_read_USB_erfolg: \(start_read_USB_erfolg)")
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
   
   @IBAction  func report_SchrittweitePop(_ sender:NSPopUpButton)
    {
      let s:String = sender.titleOfSelectedItem ?? "4"
      pfeilschrittweite = Int(sender.titleOfSelectedItem ?? "4")!
      //print("report_SchrittweitePop Val: \(Int(sender.titleOfSelectedItem!))")
      print("report_SchrittweitePop pfeilschrittweite: \(pfeilschrittweite ?? 4)")
  //   updatePfeilschrittweite(sw: <#T##Int#>)
      
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
      Joystickfeld.clearWeg()
      schnittPfad?.clearPfadarray()
      
      if (usbstatus > 0)
      {
         let senderfolg = teensy.send_USB()
      }
      
   }

   
   
   
    
} // ViewController

//MARK: dataTable
extension rPCB: NSTableViewDataSource
{
   func numberOfRows(in tableView: NSTableView) -> Int {
      return (CNC_DatendicArray.count)
      
   }
   
   func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
      let zeile = CNC_DatendicArray[row]
      //print("p: \(person)")
      let cell = tableView.makeView(withIdentifier: (tableColumn!.identifier), owner: self) as? NSTableCellView
      cell?.textField?.stringValue = (zeile[tableColumn!.identifier.rawValue]!)
      
      return cell
   }
}
