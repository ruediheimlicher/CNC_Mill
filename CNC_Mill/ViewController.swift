//
//  ViewController.swift
//  CNC_Mill
//
//  Created by Ruedi Heimlicher on 30.05.2020.
//  Copyright © 2020 Ruedi Heimlicher. All rights reserved.
//

// Wichtig:
// https://stackoverflow.com/questions/48070396/how-to-get-list-of-hid-devices-in-a-swift-cocoa-application
// in entitlements

// https://github.com/Arti3DPlayer/USBDeviceSwift/wiki/HID-device-communication


import Cocoa

public var lastDataRead = Data.init(count:64)

var globalusbstatus = 0

// 

class  rPfeiltaste  : NSButton
{
   // in IB: Inherits from target anklicken!!
   var  richtung:Int
   var pfeiltimer: Timer?
   var schrittweite:Int

   @IBOutlet weak var  Taste:NSButton!

   required init?(coder aDecoder: NSCoder) 
{
   self.richtung = 1
   self.schrittweite = 0
   super.init(coder: aDecoder)
  // Swift.print("Pfeiltaste req init")
   //     pfadarray.append(startposition)
   
}
   override init(frame frameRect: NSRect) 
   {
      Swift.print("Pfeiltaste init")
      self.richtung = 1
      self.schrittweite = 0
      super.init(frame:frameRect)
   }

   /*
override  func mouseDragged(with theEvent: NSEvent) 
   {
      super.mouseDragged(with: theEvent)
      print("rPfeiltaste mousedragged")  
   }
*/
   
// https://stackoverflow.com/questions/34235903/press-and-hold-button-for-repeat-fire
override  func mouseDown(with theEvent: NSEvent) 
{
//   super.mouseDown(with: theEvent)
   let dev:String = (superview?.identifier)!.rawValue
   var devtag = 0
   switch dev
   {
      case "pcb":
         devtag = 1
      break
      case "joystick":
         devtag = 2
      break;
      default:
      break
   }
 //  print("rPfeiltaste mousedown tabview ident: \(dev) devtag: \(devtag)")  
   let location = theEvent.locationInWindow
   //    Swift.print(location)
   //    NSPoint lokalpunkt = [self convertPoint: [anEvent locationInWindow] fromView: nil];
   //let lokalpunkt = convert(theEvent.locationInWindow, from: nil)
   let klickcount = theEvent.clickCount
   //print("lokalpunkt: \(lokalpunkt) klickcount: \(klickcount)")

  let pfeiltag = self.tag
   let sw = self.schrittweite
   print("rPfeiltaste mousedown tag: \(pfeiltag) schrittweite: \(sw)") 
   var dx = 0
   var dy = 0
   //let schrittweite:Int = 6

   switch pfeiltag 
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
   
   var notificationDic = ["tag": pfeiltag, "schrittweite":schrittweite, "devtag":devtag]
   pfeiltimer = Timer.scheduledTimer(timeInterval: 0.3 , target: self, selector: "pfeiltastenstimeraktion", userInfo: notificationDic, repeats: true)     

   let nc = NotificationCenter.default
   nc.post(name:Notification.Name(rawValue:"maus_status"),
           object: nil,
           userInfo: notificationDic)        

}

override  func mouseUp(with theEvent: NSEvent) 
   {
      super.mouseUp(with: theEvent)
 //     print("rPfeiltaste mouseup")  
      pfeiltimer?.invalidate()
      // let pfeiltag = self.tag
   }
   
@objc   func pfeiltastenstimeraktion()
{
   
   let notificationDic = pfeiltimer?.userInfo
 //  print("pfeiltastenstimeraktion userinfo: \(notificationDic)")
   let nc = NotificationCenter.default
   nc.post(name:Notification.Name(rawValue:"maus_status"),
   object: nil,
   userInfo: notificationDic as? [AnyHashable : Any])        
   }

   func setSchrittweite(sw:Int)
   {
      //print("pfeiltaste setSchrittweite: sw: \(sw)")
      schrittweite = sw
   }
/*
   - (void)mouseUp:(NSEvent *)event
{
   NSLog(@"AVR mouseup");
   richtung=[self tag];
   NSLog(@"AVR mouseUp Pfeiltaste richtung: %d",richtung);
   
   [self setState:NSOffState];
   
   NSMutableDictionary* NotificationDic=[[[NSMutableDictionary alloc]initWithCapacity:0]autorelease];
   [NotificationDic setObject:[NSNumber numberWithInt:richtung] forKey:@"richtung"];
   
   int aktpwm=0;
   NSPoint location = [event locationInWindow];
   NSLog(@"Pfeiltaste mouseUp location: %2.2f %2.2f",location.x, location.y);
   [NotificationDic setObject:[NSNumber numberWithInt:0] forKey:@"push"];
   [NotificationDic setObject:[NSNumber numberWithFloat:location.x] forKey:@"locationx"];
   [NotificationDic setObject:[NSNumber numberWithFloat:location.y] forKey:@"locationy"];
   
   NSNotificationCenter* nc=[NSNotificationCenter defaultCenter];
   [nc postNotificationName:@"Pfeil" object:self userInfo:NotificationDic];
   
   
   }
   
   - (void)mouseDown:(NSEvent *)theEvent
{
   
   richtung=[self tag];
   
   //NSLog(@"AVR mouseDown: Pfeiltaste richtung: %d",richtung);
   [self setState:NSOnState];
   
   
   NSMutableDictionary* NotificationDic=[[[NSMutableDictionary alloc]initWithCapacity:0]autorelease];
   [NotificationDic setObject:[NSNumber numberWithInt:richtung] forKey:@"richtung"];
   [NotificationDic setObject:[NSNumber numberWithInt:1] forKey:@"push"];// Start, nur fuer AVR
   NSNotificationCenter* nc=[NSNotificationCenter defaultCenter];
   [nc postNotificationName:@"Pfeil" object:self userInfo:NotificationDic];
   [super mouseDown:theEvent];
   
   [self mouseUp:theEvent];
   
   }
   
   */
   /*
    - (void)mouseUp:(NSEvent *)theEvent
    {
    richtung=[self tag];
    NSLog(@"Pfeiltaste mouseUp richtung: %d",richtung);
    [self setState:NSOffState];
    
    NSMutableDictionary* NotificationDic=[[[NSMutableDictionary alloc]initWithCapacity:0]autorelease];
    [NotificationDic setObject:[NSNumber numberWithInt:richtung] forKey:@"richtung"];
    [NotificationDic setObject:[NSNumber numberWithInt:0] forKey:@"push"];
    NSNotificationCenter* nc=[NSNotificationCenter defaultCenter];
    [nc postNotificationName:@"Pfeil" object:self userInfo:NotificationDic];
    [super mouseDown:theEvent];
    
    }
    */
   /*
   - (void)setRichtung:(int)dieRichtung
{
   richtung=dieRichtung;
   }
   
   - (int)Tastestatus
      {
         return [Taste state];
      }
      
      
      
      - (int)Richtung
         {
            return richtung;
}
 */
}

//
struct position
{
   var x:UInt16 = 0
   var y:UInt16 = 0
   var z:UInt16 = 0
   
}



//MARK: rSchnittPfad
class rSchnittPfad 
{
   var pfadarray = [position]()
   var delta = 1 // Abstand der Schritte
   required init?() 
   {
      //super.init()
      //Swift.print("schnittPfad init")
      var startposition = position()
      startposition.x = 0
      startposition.y = 0
      startposition.z = 0
      //     pfadarray.append(startposition)
      
   }
   
   func setStartposition(x:UInt16, y:UInt16, z:UInt16)
   {
      let anz = pfadarray.count
      if (pfadarray.count > 0)
      {
         pfadarray[0].x = x
         pfadarray[0].y = y
         pfadarray[0].z = z
      }
      else
      {
         addPosition(newx: x, newy: y, newz: z)
      }
   }
   
   func addSVG_Pfadarray(newPfad:[[Double]])
   {
      let faktor:Double = 10.0
      for pos in newPfad
      {
         var tempposition = position()
         tempposition.x = (UInt16)(pos[1] * faktor) // x
         tempposition.x = (UInt16)(pos[2] * faktor) // y
         tempposition.z = 0; // z
         pfadarray.append(tempposition)
      }
   }
   
   func addPosition(newx:UInt16, newy:UInt16, newz:UInt16)
   {
      let newposition = position(x:newx,y:newy,z:newz)
      pfadarray.append(newposition)
   }
   
   func clearPfadarray()
   {
      pfadarray.removeAll()
   }
   
   func anzahlPunkte() -> Int
   {
      return Int(pfadarray.count)
   }
   
}
//MARK: TABVIEW
class rDeviceTabViewController: NSTabViewController 
{
   
   override func tabView(_ tabView: NSTabView, didSelect tabViewItem: NSTabViewItem?) 
   {
      let identifier:String = tabViewItem?.identifier as! String
      //  print("DeviceTab identifier: \(String(describing: identifier)) usbstatus: \(globalusbstatus)")
      // let sup = self.view.superview
      // print("DeviceTab superview: \(sup) ident: \(sup?.identifier)")
      //let supsup = self.view.superview?.superview
      //print("DeviceTab supsup: \(supsup) ident: \(supsup?.identifier)")
      //print("subviews: \(supsup?.subviews)")
      
      var userinformation:[String : Any]
      userinformation = ["message":"tabview",  "ident": identifier, ] as [String : Any]
      let nc = NotificationCenter.default
      nc.post(name:Notification.Name(rawValue:"tabview"),
              object: nil,
              userInfo: userinformation)
      
      userinformation = ["message":"usb"] as [String : Any]
      /*
       nc.post(name:Notification.Name(rawValue:"usb_status"),
       object: nil,
       userInfo: userinformation)
       */
   }
   
}

class rViewController: NSViewController, NSWindowDelegate,XMLParserDelegate,NSTableViewDelegate
{
   
   var notokimage :NSImage = NSImage(named:NSImage.Name(rawValue: "notok_image"))!
   var okimage :NSImage = NSImage(named:NSImage.Name(rawValue: "ok_image"))!

   var hintergrundfarbe = NSColor()
   var formatter = NumberFormatter()
   var selectedDevice:String = ""
   var schnittPfad = rSchnittPfad()
   var usbstatus: Int32 = 0
   
   var homeX:Int = 0
   var homeY:Int = 0
   var  CNCDatenArray = [[String:Int]]();
   
   var propfaktor = 283464.567 // 14173.23
   
   var pfeilschrittweite:Int = 4
  /*
   SVG zu mm
    4": 288p > 101.6mm
    SVG:
    288 > 101.6mm
    100 p > 35.28mm
   */
   
   let INTEGERFAKTOR:Double = 1000000 // Multiplikatorfuer DAten aus Textfeldern und svg: Vergroesserung der Integer fuer bessere Genauigkeit
   
   var cncstepperposition:Int = 0
   var cnchalt = 0
   var Koordinatentabelle = [[String:Any]]()
   
   var teensy = usb_teensy()
   
   var CNC = rCNC()
   
//   var readtimer: Timer?
   
    @IBOutlet weak var USB_OK: NSOutlineView!
    @IBOutlet weak var check_USB_Knopf: NSButton!
   @IBOutlet weak var CNC_HALT_Knopf: NSButton!
   @IBOutlet weak var TaskTab: NSTabView!

   @IBOutlet weak var PlatteScroller: NSScrollView!
   @IBOutlet weak var Plattefeld: rPlatteView!

   @IBOutlet weak var pop: NSPopUpButton!
   
    @IBOutlet weak var schritteweitepop: NSPopUpButton!
   
   @IBOutlet weak var USB_OK_Feld: NSImageView!
   
   @IBOutlet weak var Joystickfeld: rJoystickView!
  
   @IBOutlet weak var stepperpositionFeld: NSTextField!
   @IBOutlet weak var stepperschritteFeld: NSTextField!
   @IBOutlet weak var steppercontKnopf: NSButton!
   
   @IBOutlet weak var nextKnopf: NSStepper!
  
  
   
   override func viewDidLoad() 
   {
      super.viewDidLoad()
      _ = Hello()
      
      self.view.wantsLayer = true
      self.view.superview?.wantsLayer = true
      hintergrundfarbe  = NSColor.init(red: 0.25, 
                                       green: 0.95, 
                                       blue: 0.45, 
                                       alpha: 0.25)
      self.view.layer?.backgroundColor =  hintergrundfarbe.cgColor
      formatter.maximumFractionDigits = 1
      formatter.minimumFractionDigits = 2
      formatter.minimumIntegerDigits = 1

      view.window?.delegate = self // https://stackoverflow.com/questions/44685445/trying-to-know-when-a-window-closes-in-a-macos-document-based-application
      self.view.window?.acceptsMouseMovedEvents = true

//      NotificationCenter.default.addObserver(self, selector:#selector(usbstatusAktion(_:)),name:NSNotification.Name(rawValue: "usb_status"),object:nil)
      
  //    NotificationCenter.default.removeObserver(self, name:NSNotification.Name(rawValue: "usb_attach"),object:nil)
      NotificationCenter.default.addObserver(self, selector:#selector(usbattachAktion(_:)),name:NSNotification.Name(rawValue: "usb_attach"),object:nil)

      
//      NotificationCenter.default.addObserver(self, selector:#selector(joystickAktion(_:)),name:NSNotification.Name(rawValue: "joystick"),object:nil)
      NotificationCenter.default.addObserver(self, selector:#selector(tabviewAktion(_:)),name:NSNotification.Name(rawValue: "tabview"),object:nil)
 
      NotificationCenter.default.addObserver(self, selector:#selector(mausstatusAktion(_:)),name:NSNotification.Name(rawValue: "maus_status"),object:nil)
      
      // Do any additional setup after loading the view.
   
     // USB_OK_Feld.image = notokimage
   
   }
  // https://nabtron.com/quit-cocoa-app-window-close/
   override func viewDidAppear() 
   {
      super.viewDidAppear()
      print("viewDidAppear")
      self.view.window?.delegate = self as? NSWindowDelegate 
      
      //return
      let erfolg = teensy.USBOpen()
      if erfolg == 1
      {
         USB_OK_Feld.image = okimage
      }
      else
      {
         USB_OK_Feld.image = notokimage
      }
      
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
   
   @nonobjc  func windowShouldClose(_ sender: Any) 
   {
      print("CNC_Mill windowShouldClose")
      NSApplication.shared.terminate(self)
   }

   
   func windowWillClose(_ aNotification: Notification) {
      print("CNC_Mill windowWillClose")
      let nc = NotificationCenter.default
  //    nc.post(name:Notification.Name(rawValue:"beenden"),
  //            object: nil,
  //            userInfo: nil)
      beenden()
   }

 
   @objc func beendenAktion(_ notification:Notification) 
   {
      
      print("CNC_Mill beendenAktion")
      /*
       //https://learnappmaking.com/userdefaults-swift-setting-getting-data-how-to/
       
       print("beendenAktion Pot1_Stepper_L: \(Pot1_Stepper_L.integerValue) Pot2_Stepper_L: \(Pot2_Stepper_L.integerValue)")
       UserDefaults.standard.set(Pot1_Stepper_L.integerValue, forKey: "robot1min")
       UserDefaults.standard.set(Pot2_Stepper_L.integerValue, forKey: "robot2min")
       
       UserDefaults.standard.set(rotoffsetstepper.integerValue, forKey: "rotoffset")
       UserDefaults.standard.set(pot1offsetstepper.integerValue, forKey: "robot1offset")
       UserDefaults.standard.set(pot2offsetstepper.integerValue, forKey: "robot2offset")
       
       UserDefaults.standard.set(winkelfaktor1stepper.floatValue,forKey: "winkelfaktor1")
       UserDefaults.standard.set(winkelfaktor2stepper.floatValue,forKey: "winkelfaktor2")
       
       
       print("Robot beendenAktion")
       
       

      */
      NSApplication.shared.terminate(self)
   }
   
   func beenden()
   {
      print("CNC_Mill beenden")
      NSApplication.shared.terminate(self)
   }

    
   func openFile() -> URL? 
   { 
      let myFileDialog = NSOpenPanel() 
      myFileDialog.runModal() 
      return myFileDialog.url 
   }  
   
   
   

   /*
   @IBAction func reportReadSVG(_ sender: NSButton)
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
         for zeile in SVG_array
         {
            //print("i: \(i) zeile: \(zeile)")
            let trimmzeile = zeile.trimmingCharacters(in: .whitespaces)
            if trimmzeile.contains("circle") 
            {
               //print("i: \(i) trimmzeile: \(trimmzeile)")
               circle = 6
               circlenummer = i
               circleelementarray.removeAll()
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
                        let partfloat = (partB as NSString).doubleValue * 100
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
                  }
               }
            
               circle -= 1
             }

            
            
            
            
            
            
            i = i+1
         }
         print("circlearray")
         print(circlearray)
         
  //       let sorted = circlearray.sorted(by: {$0.0 < $1.0})
  //        print("circlearray")
  //       print(sorted)
         
         
      //   schnittPfad?.addSVG_Pfadarray(newPfad: circlearray)
      //   Plattefeld.setWeg(newWeg: circlearray)
         
      }
      catch 
      {
         print("readSVG error")
         /* error handling here */
         return
      }

      
    }
 */
   
   @objc func usbstatusAktion(_ notification:Notification) 
   {
      let info = notification.userInfo
     // print("PCB usbstatusAktion:\t \(info)")
      let status:Int = info!["usbstatus"] as! Int // 
      print("viewController usbstatusAktion:\t \(status)")
      
   }
   
   @objc func usbattachAktion(_ notification:Notification) 
   {
      let info = notification.userInfo
     // print("PCB usbattachAktion:\t \(info)")
      let status:Int = info!["attach"] as! Int // 
      print("viewController usbattachAktion:\t \(status)")
     
      
      if status == USBREMOVED
      {
         USB_OK_Feld.image = notokimage
      }
     else if status == USBATTACHED
      {
         USB_OK_Feld.image = okimage
      }
      
   }

    
   @objc func joystickAktion(_ notification:Notification) 
   {
      let info = notification.userInfo
      let punkt:CGPoint = info?["punkt"] as! CGPoint
      let wegindex:Int = info?["index"] as! Int // 
      let first:Int = info?["first"] as! Int
      //print("xxx joystickAktion:\t \(punkt)")
      //print("x: \(punkt.x) y: \(punkt.y) index: \(wegindex) first: \(first)")
   }
   
   @objc func tabviewAktion(_ notification:Notification) 
   {
      let info = notification.userInfo
      let ident:String = info?["ident"] as! String  // 
      //print("Basis tabviewAktion:\t \(ident)")
      selectedDevice = ident
   }

  
   @objc func newDataAktion(_ notification:Notification) 
   {
      let lastData = teensy.getlastDataRead()
      print("lastData:\t \(lastData[1])\t\(lastData[2])   ")
      var ii = 0
      while ii < 10
      {
         //print("ii: \(ii)  wert: \(lastData[ii])\t")
         ii = ii+1
      }
      
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
   
   
   func tester(_ timer: Timer)
   {
      let theStringToPrint = timer.userInfo as! String
      print(theStringToPrint)
   }
 
   @objc  func mausstatusAktion(_ notification:Notification)
   {
       //print("ViewController mausstatusAktion")
   }
   
   @IBAction func report_HALT(_ sender: NSButton)
   {
      print("report_HALT")
      /*
 [CNC_Preparetaste setEnabled:![sender state]];
 [CNC_Starttaste setEnabled:[sender state]];
 [CNC_Stoptaste setEnabled:![sender state]];
 [CNC_Sendtaste setEnabled:![sender state]];
 [CNC_Terminatetaste setEnabled:![sender state]];
 [DC_Taste setState:0];
 [self setStepperstrom:1];
 [self setBusy:0];
 [PositionFeld setIntValue:0];
 [PositionFeld setStringValue:@""];
 
 */
      var notdic = [String:Any]()
      notdic["haltstatus"] = CNC_HALT_Knopf.state
      notdic["push"] = 0
      
      if CNC_HALT_Knopf.state == .on
      {
         teensy.write_byteArray[24] = 0xE0 // code
         teensy.write_byteArray[26] = 0 // indexh
         teensy.write_byteArray[27] = 0 // indexl
 //        var timerdic:[String:Int] = ["haltstatus":1, "home":0]
 //        var timer : Timer? = nil
  //       timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(USB_read(timer:)), userInfo: timerdic, repeats: true)

         
      }
  
      
   }
   

   @IBAction func report_Slider0(_ sender: NSSlider)
   {
      teensy.write_byteArray[0] = SET_0 // Code 
      //print("report_Slider0 IntVal: \(sender.intValue)")
      
      let pos = sender.doubleValue
      
      let intpos = UInt16(pos * FAKTOR0)
      let Ustring = formatter.string(from: NSNumber(value: intpos))
      
      
      print("report_Slider0 pos: \(pos) intpos: \(intpos)  Ustring: \(Ustring ?? "0")")
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
         //print("report_Slider0 senderfolg: \(senderfolg)")
      }
   }

   @IBAction func report_goto_0(_ sender: NSButton)
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
   
   func goto_0(x:Double, y:Double, z:Double)
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
   
   @IBAction func report_Pot0_Stepper_L(_ sender: NSStepper) // untere Grenze
   {
      print("report_Pot0_Stepper_L IntVal: \(sender.integerValue)")
      
      let intpos = sender.integerValue 
      Pot0_Stepper_L_Feld.integerValue = intpos
      
      Pot0_Slider.minValue = sender.doubleValue 
      print("report_Pot0_Stepper_L Pot0_Slider.minValue: \(Pot0_Slider.minValue)")
      
   }
   
   @IBAction func report_Pot0_Stepper_H(_ sender: NSStepper)// Obere Grenze
   {
      print("report_Pot0_Stepper_H IntVal: \(sender.integerValue)")
      
      let intpos = sender.integerValue 
      Pot0_Stepper_H_Feld.integerValue = intpos
      
      Pot0_Slider.maxValue = sender.doubleValue 
      print("report_Pot0_Stepper_H Pot0_Slider.maxValue: \(Pot0_Slider.maxValue)")
      
   }
   
   
   @IBAction func report_set_Pot0(_ sender: NSTextField)
   {
      teensy.write_byteArray[0] = SET_0 // Code 
      
      // senden mit faktor 1000
      //let u = Pot0_Feld.doubleValue 
      let Pot0_wert = Pot0_Feld.doubleValue * 100
      let Pot0_intwert = UInt(Pot0_wert)
      
      let Pot0_HI = (Pot0_intwert & 0xFF00) >> 8
      let Pot0_LO = Pot0_intwert & 0x00FF
      
      print("report_set_Pot0 Pot0_wert: \(Pot0_wert) Pot0 HI: \(Pot0_HI) Pot0 LO: \(Pot0_LO) ")
      let intpos = sender.intValue 
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
   
   
   @IBAction func report_Slider2(_ sender: NSSlider)
   {
      teensy.write_byteArray[0] = SET_3 // Code 
      //print("report_Slider2 IntVal: \(sender.intValue)")
      let pos = sender.doubleValue
      
      let intpos = UInt16(pos * FAKTOR3)
      let Ustring = formatter.string(from: NSNumber(value: intpos))
      
      //print("report_Slider2 pos: \(pos) intpos: \(intpos)  Ustring: \(Ustring ?? "0")")
      // Pot0_Feld.stringValue  = Ustring!
      Pot2_Feld.integerValue  = Int(intpos)
      Pot2_Stepper_L.integerValue  = Int(sender.minValue) // Stepper min setzen
      Pot2_Stepper_L_Feld.integerValue = Int(sender.minValue)
      Pot2_Stepper_H.integerValue  = Int(sender.maxValue) // Stepper max setzen
      Pot2_Stepper_H_Feld.integerValue = Int(sender.maxValue)
      
      teensy.write_byteArray[DELAYY_A] = UInt8((intpos & 0xFF00) >> 8) // hb
      teensy.write_byteArray[DELAYY_B] = UInt8((intpos & 0x00FF) & 0xFF) // lb
      
      if (usbstatus > 0)
      {
         let senderfolg = teensy.send_USB()
         //print("report_Slider2 senderfolg: \(senderfolg)")
      }
   }
   @IBAction  func report_Pot2_Stepper_H(_ sender: NSStepper) // untere Grenze
   {
      print("report_Pot2_Stepper_H IntVal: \(sender.integerValue)")
   }
   @IBAction  func report_Pot2_Stepper_L(_ sender: NSStepper) // untere Grenze
   {
      print("report_Pot2_Stepper_L IntVal: \(sender.integerValue)")
      
   }

   
   @IBAction func report_clear_Ring(_ sender: NSButton)
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
   
   @IBAction func report_goto_x_Stepper(_ sender: NSStepper)
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
   
   @IBAction func report_goto_y_Stepper(_ sender: NSStepper)
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
   
   @IBAction func report_Slider1(_ sender: NSSlider)
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
   
   @IBAction func report_Pot1_Stepper_L(_ sender: NSStepper) // untere Grenze
   {
      print("report_Pot1_Stepper_L IntVal: \(sender.integerValue)")
      
      let intpos = sender.integerValue 
      Pot1_Stepper_L_Feld.integerValue = intpos
      
      Pot1_Slider.minValue = sender.doubleValue 
      print("report_Pot1_Stepper_L Pot1_Slider.minValue: \(Pot1_Slider.minValue)")
      
   }
   
   @IBAction func report_Pot1_Stepper_H(_ sender: NSStepper)// Obere Grenze
   {
      print("report_Pot1_Stepper_H IntVal: \(sender.integerValue)")
      
      let intpos = sender.integerValue 
      Pot1_Stepper_H_Feld.integerValue = intpos
      
      Pot1_Slider.maxValue = sender.doubleValue 
      print("report_Pot1_Stepper_H Pot1_Slider.maxValue: \(Pot1_Slider.maxValue)")
      
   }
   
   @IBAction func report_I_Stepper(_ sender: NSStepper)
   {
      //teensy.write_byteArray[0] = SET_0 // Code 
      print("report_I_Stepper IntVal: \(sender.intValue)")
      let I = Pot1_Feld.doubleValue
      let intpos = sender.intValue 
      
      let pos = sender.doubleValue
      let Istring = formatter.string(from: NSNumber(value: intpos))
      //     print("report_U_Stepper u: \(u) Istring: \(Istring ?? "0")")
      Pot1_Feld.stringValue  = Istring!
      
      self.Pot1_Stepper_H.doubleValue = sender.doubleValue
      
      teensy.write_byteArray[DELAYX_A] = UInt8((intpos & 0xFF00) >> 8) // hb
      teensy.write_byteArray[DELAYX_B] = UInt8((intpos & 0x00FF) & 0xFF) // lb
      
      if (usbstatus > 0)
      {
         let senderfolg = teensy.send_USB()
      }
   }
   
   @IBAction func report_StartSinus(_ sender: NSButton)
   {
      print("report_StartSinus ")
      let intpos0 = UInt16(Double(ACHSE0_START) * FAKTOR0)
      Pot0_Feld.integerValue = Int(UInt16(Double(ACHSE0_START) * FAKTOR0))
      
      teensy.write_byteArray[0] = SIN_START
      let intpos = UInt16(Double(ACHSE0_START) * FAKTOR0)
      let startwert = UInt16(Double(ACHSE0_START) * FAKTOR0)
      
      teensy.write_byteArray[SCHRITTEX_A] = UInt8((startwert & 0xFF00) >> 8) // hb
      teensy.write_byteArray[SCHRITTEX_B] = UInt8((startwert & 0x00FF) & 0xFF) // lb
      if (usbstatus > 0)
      {
         let senderfolg = teensy.send_USB()
         print("report_sinus senderfolg: \(senderfolg) startwert: \(startwert)")
      }
      
      
   }
   
   override var representedObject: Any? {
      didSet {
      // Update the view, if already loaded.
      }
   }
   @IBAction func check_USB(_ sender: NSButton)
   {
      let notokimage :NSImage = NSImage(named:NSImage.Name(rawValue: "notok_image"))!
      let okimage :NSImage = NSImage(named:NSImage.Name(rawValue: "ok_image"))!
      let erfolg = teensy.USBOpen()
      usbstatus = erfolg
      print("USBOpen erfolg: \(erfolg) usbstatus: \(usbstatus)")
      
      if (rawhid_status()==1)
      {
         USB_OK_Feld.image = okimage
         print("status 1")
         USB_OK.backgroundColor = NSColor.green
         print("USB-Device da")
  //       let manu = get_manu()
         //println(manu) // ok, Zahl
         //         var manustring = UnsafePointer<CUnsignedChar>(manu)
         //println(manustring) // ok, Zahl
         
    //     let manufactorername = String(cString: UnsafePointer(manu!))
 //        print("str: %s", manufactorername)
 //        manufactorer.stringValue = manufactorername
         
         //manufactorer.stringValue = "Manufactorer: " + teensy.manufactorer()!
      }
      else
         
      {
         print("status 0")
         if let taste = USB_OK
         {
            print("Taste USB_OK: USB ist nicht nil")
            USB_OK_Feld.image = notokimage
            USB_OK.backgroundColor = NSColor.red
            //USB_OK.backgroundColor = NSColor.redColor()
         }
         else
         {
            print("Taste USB_OK ist nil")
            USB_OK.backgroundColor = NSColor.red
         }
      }
      print("antwort: \(teensy.status())")
   }
   
   /*
   @objc func USB_read(timer: Timer!)
   {
      print("USB_read note: \(readtimer?.userInfo)")
      var buffer:[UInt8] = [UInt8]();
      var reportSize:Int = 32;  
      var result:Int32  = 0;
      if cncstepperposition == 0
      {
         print("readUSB Stepperposition = 0")
      }
      
      result = rawhid_recv(0, &buffer, 64, 50);
      let  dataRead:Data = Data(bytes:buffer);
      if (dataRead != lastDataRead)
      {
         print("neue Daten")
  //       var abschnittcode:UInt8 = buffer[0]; 
  //       print("abschnittcode: \(abschnittcode)")
         lastDataRead = dataRead
      }
      print(dataRead as NSData);  
      

   }
   */
   
   func dialogOKCancel(question: String, text: String) -> Bool 
   {
      // https://stackoverflow.com/questions/29433487/create-an-nsalert-with-swift
      let alert = NSAlert()
      alert.messageText = question
      alert.informativeText = text
      alert.alertStyle = .warning
      alert.addButton(withTitle: "OK")
      alert.addButton(withTitle: "Cancel")
      return alert.runModal() == .alertFirstButtonReturn
   }
/*
 let answer = dialogOKCancel(question: "Ok?", text: "Choose your answer.")
 */
   
   //MARK: Konstanten
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
   
   let SCHRITTEX_A = 0
   let SCHRITTEX_B = 1
   let SCHRITTEX_C = 2
   let SCHRITTEX_D = 3
   
   
   let DELAYX_A = 4
   let DELAYX_B = 5
   let DELAYX_C = 6
   let DELAYX_D = 7
   
   let SCHRITTEY_A = 8
   let SCHRITTEY_B = 9
   let SCHRITTEY_C = 10
   let SCHRITTEY_D = 11
   
   let DELAYY_A = 12
   let DELAYY_B = 13
   let DELAYY_C = 14
   let DELAYY_D = 15

   let schrittezA = 8
   let schrittezB = 9
   let schrittezC = 10
   let schrittezD = 11
   
   let delayzA = 12
   let delayzB = 13
   let delayzC = 14
   let delayzD = 15
   
   let code = 24
   let lage = 0
   
   
   
   
   
   //MARK:      Outlets 
   @IBOutlet weak var Device: NSTabView!
   @IBOutlet weak var manufactorer: NSTextField!
   @IBOutlet weak var Counter: NSTextField!
   
   @IBOutlet weak var Start_Knopf: NSButton!
   @IBOutlet weak var Stop_Knopf: NSButton!
   @IBOutlet weak var Send_Knopf: NSButton!
   @IBOutlet weak var Start_Read_Knopf: NSButton!
   
   @IBOutlet weak var Anzeige: NSTextField!
   
   //@IBOutlet weak var USB_OK: NSTextField!
   
   
   
   //@IBOutlet weak var start_read_USB_Knopf: NSButtonCell!
   
   @IBOutlet weak var codeFeld: NSTextField!
   
   @IBOutlet weak var dataFeld: NSTextField!
   
   @IBOutlet weak var schrittweiteFeld: NSTextField!
   
   
   
   @IBOutlet weak var Pot0_Feld: NSTextField!
   @IBOutlet weak var Pot0_Slider: NSSlider!
   @IBOutlet weak var Pot0_Stepper_H: NSStepper!
   @IBOutlet weak var Pot0_Stepper_L: NSStepper!
   @IBOutlet weak var Pot0_Stepper_L_Feld: NSTextField!
   @IBOutlet weak var Pot0_Stepper_H_Feld: NSTextField!
   @IBOutlet weak var Pot0_Inverse_Check: NSButton!
   
   @IBOutlet weak var joystick_x: NSTextField!
   @IBOutlet weak var joystick_y: NSTextField!
   
   @IBOutlet weak var goto_x: NSTextField!
   @IBOutlet weak var goto_x_Stepper: NSStepper!
   @IBOutlet weak var goto_y: NSTextField!
   @IBOutlet weak var goto_y_Stepper: NSStepper!
   
   @IBOutlet weak var Pot1_Feld_raw: NSTextField!
   @IBOutlet weak var Pot1_Feld: NSTextField!
   @IBOutlet weak var Pot1_Slider: NSSlider!
   @IBOutlet weak var Pot1_Stepper_H: NSStepper!
   @IBOutlet weak var Pot1_Stepper_L: NSStepper!
   @IBOutlet weak var Pot1_Stepper_L_Feld: NSTextField!
   @IBOutlet weak var Pot1_Stepper_H_Feld: NSTextField!
   @IBOutlet weak var Pot1_Inverse_Check: NSButton!
   
   @IBOutlet weak var Pot2_Feld_raw: NSTextField!
   @IBOutlet weak var Pot2_Feld: NSTextField!
   @IBOutlet weak var Pot2_Slider: NSSlider!
   @IBOutlet weak var Pot2_Stepper: NSStepper!
   @IBOutlet weak var Pot2_Stepper_H: NSStepper!
   @IBOutlet weak var Pot2_Stepper_L: NSStepper!
   @IBOutlet weak var Pot2_Stepper_L_Feld: NSTextField!
   @IBOutlet weak var Pot2_Stepper_H_Feld: NSTextField!
   @IBOutlet weak var Pot2_Inverse_Check: NSButton!
   
   @IBOutlet weak var Pot3_Feld_raw: NSTextField!
   @IBOutlet weak var Pot3_Feld: NSTextField!
   @IBOutlet weak var Pot3_Slider: NSSlider!
   @IBOutlet weak var Pot3_Stepper: NSStepper!
   @IBOutlet weak var Pot3_Stepper_H: NSStepper!
   @IBOutlet weak var Pot3_Stepper_L: NSStepper!
   @IBOutlet weak var Pot3_Stepper_L_Feld: NSTextField!
   @IBOutlet weak var Pot3_Stepper_H_Feld: NSTextField!
   @IBOutlet weak var Pot3_Inverse_Check: NSButton!
   
 //  @IBOutlet weak var Joystickfeld: rPlatteView!
   

}

