//
//  Netz.swift
//  SwiftStarter
//
//  Created by Ruedi Heimlicher on 30.10.2014.
//  Copyright (c) 2014 Ruedi Heimlicher. All rights reserved.
//


import Cocoa
import Foundation
import AVFoundation
import Darwin

let BUFFER_SIZE:Int   = Int(BufferSize())

var new_Data:ObjCBool = false





open class usb_teensy: NSObject
{
   var hid_usbstatus: Int32 = 0
   
   var read_byteArray = [UInt8](repeating: 0x00, count: BUFFER_SIZE)
   var last_read_byteArray = [UInt8](repeating: 0x00, count: BUFFER_SIZE)
   var write_byteArray: Array<UInt8> = Array(repeating: 0x00, count: BUFFER_SIZE)
   // var testArray = [UInt8]()
   var testArray: Array<UInt8>  = [0xAB,0xDC,0x69,0x66,0x74,0x73,0x6f,0x64,0x61]
   
   var read_OK:ObjCBool = false
   
   var datatruecounter = 0
   var datafalsecounter = 0
   
   var readtimer: Timer?
   
   var manustring:String = ""
   var prodstring:String = ""
   
   var readarray = [UInt8](repeating: 0x00, count: BUFFER_SIZE)
   
   override init()
   {
      super.init()
   }
   
   
   open func USBOpen()->Int32
   {
      var r:Int32 = 0
      print("func usb_teensy.USBOpen hid_usbstatus: \(hid_usbstatus)")
      if (hid_usbstatus > 0)
      {
         print("func usb_teensy.USBOpen USB schon offen")
         let alert = NSAlert()
         alert.messageText = "USB Device"
         alert.informativeText = "USB ist schon offen"
         alert.alertStyle = .warning
         alert.addButton(withTitle: "OK")
        // alert.addButton(withTitle: "Cancel")
         let antwort =  alert.runModal() == .alertFirstButtonReturn
         return 1;
      }
      
      let    out = rawhid_open(1, 0x16C0, 0x0486, 0xFFAB, 0x0200)
     
      
      print("func usb_teensy.USBOpen out: \(out)")
      
      hid_usbstatus = out as Int32;
      
      if (out <= 0)
      {
         NSLog("USBOpen: no rawhid device found");
         //[AVR setUSB_Device_Status:0];
      }
      else
      {
         NSLog("USBOpen: found rawhid device hid_usbstatus: %d",hid_usbstatus)
         let manu   = get_manu()
         let manustr:String = String(cString: manu!)
         
         if (manustr == nil)
         {
            manustring = "-"
         }
         else
         {
            manustring = String(cString: UnsafePointer<CChar>(manustr))
         }
         
         
         
         
         let prod = get_prod();
         //fprintf(stderr,"prod: %s\n",prod);
         let prodstr:String = String(cString: prod!)
         if (prodstr == nil)
         {
            prodstring = "-"
         }
         else
         {
            prodstring = String(cString: UnsafePointer<CChar>(prod!))
         }
     //    var USBDatenDic = ["prod": prod, "manu":manu]
         
      }
      
      
      return out;
   } // end USBOpen
   
   open func manufactorer()->String?
   {
      return manustring
   }
   
   open func producer()->String?
   {
      return prodstring
   }
   
   open func readtimervalid()->Bool
   {
      if readtimer?.isValid  ?? false
      {
         return true
      }
      return false
   }
   
   open func status()->Int32
   {
      return get_hid_usbstatus()
   }
   
   open func dev_present()->Int32
   {
      return usb_present()
   }
   
   /*
    func appendCRLFAndConvertToUTF8_1(_ s: String) -> Data {
    let crlfString: NSString = s + "\r\n" as NSString
    let buffer = crlfString.utf8String
    let bufferLength = crlfString.lengthOfBytes(using: String.Encoding.utf8.rawValue)
    let data = Data(bytes: UnsafePointer<UInt8>(buffer!), count: bufferLength)
    return data;
    }
    */
   
   /*
    open func start_read_USB()-> NSDictionary
    {
    
    read_OK = true
    let timerDic:NSMutableDictionary  = ["count": 0]
    
    
    let result = rawhid_recv(0, &read_byteArray, 32, 50);
    
    print("*start_read_USB result: \(result)")
    print("lnread_byteArray nach: *\(read_byteArray)*")
    
    var somethingToPass = "It worked in teensy_send_USB"
    
    var timer : Timer? = nil
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(usb_teensy.cont_read_USB(_:)), userInfo: timerDic, repeats: true)
    
    return timerDic as NSDictionary
    }
    */
   
   open func getlastDataRead()->Data
   {
      return lastDataRead
   }
   
   open func start_read_USB(_ cont: Bool)-> Int
   {
      read_OK = ObjCBool(cont) // read fortsetzen?
      var home = 0
      var timerDic:NSMutableDictionary  = ["count": 0,"home":0]
      var result = 1
      /*
      var readarray = [UInt8](repeating: 0x00, count: BUFFER_SIZE)
      let result = rawhid_recv(0, &readarray, Int32(BUFFER_SIZE), 50);
      read_byteArray = readarray
      
      print("\n*                    start_read_USB result: \(result) cont: \(cont)")
      var codehex = String(format:"%02X", read_byteArray[0])
      
      print("+++ usb.swift  start_read_USB codehex: \(codehex)")
       if read_byteArray[0] == 0
       {
         print("start_read_byteArray start: NIX")
         return 0
      }
      print("start_read_byteArray start: *\n\(read_byteArray)*")
     
      let nc = NotificationCenter.default
      nc.post(name:Notification.Name(rawValue:"newdata"),
              object: nil,
              userInfo: ["message":"neue Daten", "data":read_byteArray,"home": 0])
      
      // var somethingToPass = "It worked in teensy_send_USB"
       */
      let xcont = cont;
      
      if (xcont == true)
      {
         if readtimer?.isValid == true
         {
            readtimer?.invalidate()
         }
         readtimer = Timer.scheduledTimer(timeInterval: 0.04, target: self, selector: #selector(usb_teensy.cont_read_USB(_:)), userInfo: timerDic, repeats: true)
      }
      
      return Int(result) //
   }
   
   /*   
    open func cont_read_USB(_ timer: Timer)
    {
    if (read_OK).boolValue
    {
    var tempbyteArray = [UInt8](repeating: 0x00, count: BUFFER_SIZE)
    var result = rawhid_recv(0, &last_read_byteArray, 32, 50)
    //println("tempbyteArray in Timer: *\(tempbyteArray)*")
    // var timerdic: [String: Int]
    
    
    // http://dev.iachieved.it/iachievedit/notifications-and-userinfo-with-swift-3-0/
    let nc = NotificationCenter.default
    nc.post(name:Notification.Name(rawValue:"newdata"),
    object: nil,
    userInfo: ["message":"neue Daten", "data":read_byteArray])
    
    if  let dic = timer.userInfo as? NSMutableDictionary
    {
    if var count:Int = timer.userInfo?["count"] as? Int
    {
    count = count + 1
    dic["count"] = count
    //dic["nr"] = count+2
    //println(dic)
    }
    }
    
    let timerdic:Dictionary<String,Int?> = timer.userInfo as! Dictionary<String,Int?>
    //let messageString = userInfo["message"]
    var tempcount = timerdic["count"]!
    
    //timer.userInfo["count"] = tempcount + 1
    
    
    
    
    
    //timerdic["count"] = 2
    
    // var count:Int = timerdic["count"]
    
    //timer.userInfo["count"] = count+1
    if !(last_read_byteArray == read_byteArray)
    {
    read_byteArray = last_read_byteArray
    
    print("+++ new read_byteArray in Timer:", terminator: "")
    for  i in 0...4
    {
    print(" \(read_byteArray[i])", terminator: "")
    }
    print("")
    
    }
    //println("*read_USB in Timer result: \(result)")
    
    //let theStringToPrint = timer.userInfo as String
    //println(theStringToPrint)
    }
    else
    {
    timer.invalidate()
    }
    }
    */
   
   @objc open func cont_read_USB(_ timer: Timer)
   {
      // entspricht readUSB in USB_Stepper
      
      //print("*cont_read_USB read_OK: \(read_OK)")
      if (read_OK).boolValue
      {
         //var tempbyteArray = [UInt8](count: 32, repeatedValue: 0x00)
         //read_byteArray[0]  = 0
        // var readarray = [UInt8](repeating: 0x00, count: BUFFER_SIZE)
         
         let result = rawhid_recv(0, &readarray, Int32(BUFFER_SIZE), 100)
         if (result == 0)
         {
            return;
         }
         // read_byteArray puffern
         read_byteArray = readarray
          
 /*        
         if  var dic = timer.userInfo as? NSMutableDictionary
         {
            if var count:Int = dic["count"] as? Int 
            {
               //             print("*cont_read_USB usb-count von timer: \(count)")
               count = count + 1
               dic["count"] = count
               
            }
         }
 */        
         let timerdic:Dictionary<String,Int?> = timer.userInfo as! Dictionary<String,Int?>
         //let messageString = userInfo["message"]
         //var tempcount = timerdic["count"]!
         
         
         if !(last_read_byteArray == read_byteArray)
         {
            last_read_byteArray = read_byteArray
            //lastDataRead = Data(bytes:read_byteArray)
            
           // let usbData = Data(bytes:read_byteArray)
            new_Data = true
            datatruecounter += 1
            //var codehex = String(format:"%02X", read_byteArray[0])
            
            //var taskcode = read_byteArray[0]
            //print("\n+++                               cont_read_USB in Timer codehex: \(codehex)")
            
            /*
             if taskcode == 0xD0
             {
             if timer.isValid == true
             {
             print("+++ cont_read_USB Timer invalidate")
             timer.invalidate()
             }
             }
             */           
            /*
             for  i in 0...16
             {
             print(" \(read_byteArray[i])")
             }
             print("\n")
             */   
            var home:Int = 0 // HALT-Anweisung
            if timer.isValid == true
            {
               if (timerdic["count"] != nil)
               {
                  home = timerdic["count"] as! Int 
               }
            }
            
            
            // http://dev.iachieved.it/iachievedit/notifications-and-userinfo-with-swift-3-0/
            let nc = NotificationCenter.default           
            nc.post(name:Notification.Name(rawValue:"newdata"),
                    object: nil,
                    userInfo: ["message":"neue Daten", "data":read_byteArray])
         }
         else
         {
            //new_Data = false
            datafalsecounter += 1
            //print("--- \(read_byteArray[0])\t\(datafalsecounter)")
         }
      }
      else
      {
         print("*cont_read_USB timer.invalidate")
         timer.invalidate()
      }
   }
   
   open func report_stop_read_USB(_ inTimer: Timer)
   {
      
      read_OK = false
   }
   
   open func clear_writearray()
   {
      for zeilenindex in stride(from: 0, to: write_byteArray.count, by: 1)
      {
         write_byteArray[zeilenindex] = 0
      }
   }
   
   open func send_USB()->Int32
   {
      // http://www.swiftsoda.com/swift-coding/get-bytes-from-nsdata/
      // Test Array to generate some Test Data
       
      let senderfolg = rawhid_send(0,&write_byteArray, Int32(BUFFER_SIZE), 50)
      
      if hid_usbstatus == 0
      {
         //print("hid_usbstatus 0: \(hid_usbstatus)")
      }
      else
      {
         //print("hid_usbstatus not 0: \(hid_usbstatus)")
         
      }
      
      return senderfolg
      
   }
   
   
   
   open func rep_read_USB(_ inTimer: Timer)
   {
      var result:Int32  = 0;
      var reportSize:Int = 64;   
      var buffer = [UInt8]();
      result = rawhid_recv(0, &buffer, 64, 50);
      
      var dataRead:Data = Data(bytes:buffer)
      if (dataRead != lastDataRead)
      {
         print("neue Daten")
      }
      print(dataRead as NSData);   
      
      
   }
   
}


open class Hello
{
   open func setU()
   {
      print("Hi Netzteil")
   }
}

