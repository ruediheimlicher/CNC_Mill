//
//  rDrehknopf.swift
//  Robot_Interface
//
//  Created by Ruedi Heimlicher on 18.08.2019.
//  Copyright © 2019 Ruedi Heimlicher. All rights reserved.
//
import Cocoa
import Foundation

class rPlatteView: NSView
{
   var weg: NSBezierPath = NSBezierPath()
   var kreuz: NSBezierPath = NSBezierPath()
   var kreis: NSBezierPath = NSBezierPath()
   var achsen: NSBezierPath = NSBezierPath()
   var mittelpunkt:NSPoint = NSZeroPoint
   var winkel:CGFloat = 0
   var hyp:CGFloat = 0
   var hgfarbe:NSColor = NSColor()
   
   var rot:CGFloat=90
   var gruen:CGFloat=240
   var blau:CGFloat=50
   
   var markarray:[NSBezierPath] = [NSBezierPath]()
   
   var redfaktor:CGFloat = 200
   var transformfaktor:CGFloat = 0 // px to mm
   var wegindex=0;
   var faktor:CGFloat = 0
   
   var fahrtweg:CGFloat = 0
   
   var stepperposition:Int = 0
   
   var wegarray:[[Int]] = [[Int]]()
   
   var linienfarbe:NSColor = NSColor()
   var kreislinienfarbe:NSColor = NSColor()
   var kreisfillfarbe:NSColor = NSColor()
   
   var drawstatus = 0 // 0: setweg zeichnet den Weg  1: draw zeichnet den Weg nach setstepperposition
   
   required init?(coder  aDecoder : NSCoder) 
   {
      super.init(coder: aDecoder)
      Swift.print("JoystickView init")
      //   NSColor.blue.set() // choose color
      // let achsen = NSBezierPath() // container for line(s)
      let w:CGFloat = bounds.size.width
      let h:CGFloat = bounds.size.height
      let mittex:CGFloat = bounds.size.width / 2
      let mittey:CGFloat = bounds.size.height / 2
      mittelpunkt = NSMakePoint(mittex, mittey)
      hyp = bounds.size.height / 2
      //Swift.print("JoystickView init mittex: \(mittex) mittey: \(mittey) hyp: \(hyp)")
      achsen.move(to: NSMakePoint(0, mittey)) // start point
      achsen.line(to: NSMakePoint(w, mittey)) // destination
      achsen.move(to: NSMakePoint(mittex, 0)) // start point
      achsen.line(to: NSMakePoint(mittex, h)) // destination
      achsen.lineWidth = 1  // hair line
      //achsen.stroke()  // draw line(s) in color
      
      rot=36
      gruen=255
      blau=4
      
      linienfarbe = NSColor(red: CGFloat(rot/255), green: CGFloat(gruen/255), blue: CGFloat(blau/255), alpha: 1.0)
      //     linienfarbe = NSColor.green
      
      rot=27
      gruen=114
      blau=59
      kreislinienfarbe = NSColor(red: CGFloat(rot/255), green: CGFloat(gruen/255), blue: CGFloat(blau/255), alpha: 1.0)
      
      rot=70.0
      gruen=160
      blau=100
      kreisfillfarbe = NSColor(red: CGFloat(rot/255), green: CGFloat(gruen/255), blue: CGFloat(blau/255), alpha: 1.0)
      
      //    Swift.print("rot: \(rot/255)\n")
      
      if let joystickident = self.identifier
      {
         //  Swift.print("JoystickView ident: \(joystickident) raw: \(joystickident.rawValue)")
         
      }
      else
      {
         //Swift.print("JoystickView no ident")
      }
      
   }
   
   // https://stackoverflow.com/questions/21751105/mac-os-x-convert-between-nsview-coordinates-and-global-screen-coordinates
   
   override func draw(_ dirtyRect: NSRect) 
   {
      // https://stackoverflow.com/questions/36596545/how-to-draw-a-dash-line-border-for-nsview
      super.draw(dirtyRect)
      
      
      // dash customization parameters
      let dashHeight: CGFloat = 1
      let dashColor: NSColor = .gray
      
      // setup the context
      let currentContext = NSGraphicsContext.current!.cgContext
 //     currentContext.setLineWidth(dashHeight)
      //currentContext.setLineDash(phase: 0, lengths: [dashLength])
 //     currentContext.setStrokeColor(dashColor.cgColor)
      
      // draw the dashed path
  //    currentContext.addRect(bounds.insetBy(dx: dashHeight, dy: dashHeight))
 //     currentContext.strokePath()
      
      kreis.lineWidth = 1.5
      // neu
      
      if (drawstatus == 1)
      {
         linienfarbe.set() // choose color
         weg.lineWidth = 1.5
         weg.stroke()  // draw line(s) in color
         
         var elcount:Int = 0
         var lastpunkt = NSMakePoint(0, 0)
         wegindex = 0
         
         for zeile in wegarray
         {
            elcount += 1
            //  let x = CGFloat(zeile[0])
            let lokalpunkt = NSMakePoint(CGFloat(zeile[1])/faktor/redfaktor * transformfaktor,CGFloat(zeile[2])/faktor/redfaktor * transformfaktor)
            //print(lokalpunkt)
            
            // Marke setzen
            let tempMarkRect:NSRect = NSMakeRect(lokalpunkt.x-4.1, lokalpunkt.y-4.1, 8.1, 8.1);
            // tempMark=[NSBezierPath bezierPathWithOvalInRect:tempMarkRect]
            // Nummer setzen
            //          var tempNumRect:NSRect = NSMakeRect(lokalpunkt.x-12.1, lokalpunkt.y+4.1, 24.1, 8.1);
            var localkreis:NSBezierPath =  NSBezierPath()
            localkreis.appendOval(in: tempMarkRect)
            //              var fillcolor:NSColor = NSColor.blue
            //              fillcolor.setFill()
            markarray.append(localkreis)
             
            kreis.move(to: lokalpunkt)
            //    kreis.appendOval(in: tempMarkRect)
            
            if wegindex <= stepperposition // Start, Marke fuellen
            {
               //    var localkreis: NSBezierPath = NSBezierPath()
               lastpunkt = lokalpunkt
               weg.move(to: lokalpunkt)
               /*
               var localkreis:NSBezierPath =  NSBezierPath()
               localkreis.appendOval(in: tempMarkRect)
               //              var fillcolor:NSColor = NSColor.blue
               //              fillcolor.setFill()
               markarray.append(localkreis)
 */
               kreisfillfarbe.set() // choose color
               localkreis.fill()
               kreislinienfarbe.set() // choose color
               localkreis.lineWidth = 1.0
               localkreis.stroke()
               linienfarbe.set() 
               //              kreis.append(localkreis)
               var tempNumPunkt:NSPoint = NSMakePoint(lokalpunkt.x + 3, lokalpunkt.y + 3)
               let atts = [NSAttributedStringKey.font:NSFont.init(name: "Helvetica", size: 10)]
               let numstring = String(wegindex)
               numstring.draw(
                  at: tempNumPunkt, 
                  withAttributes: atts as [NSAttributedStringKey : Any])
            }
            else
            {
               let dx = lokalpunkt.x - lastpunkt.x
               let dy = lokalpunkt.y - lastpunkt.y
               fahrtweg += hypotenuse(dx, dy)
               lastpunkt = lokalpunkt
               weg.line(to: lokalpunkt)
               //       kreis.fill()
               /*
               var localkreis:NSBezierPath =  NSBezierPath()
               localkreis.appendOval(in: tempMarkRect)
               markarray.append(localkreis)
 */
               //              var fillcolor:NSColor = NSColor.blue
               //              fillcolor.setFill()
               NSColor.yellow.set() // choose color
               localkreis.fill()
               kreislinienfarbe.set() // choose color
               localkreis.lineWidth = 1.0
               localkreis.stroke()
               NSColor.green.set() 
               //              kreis.append(localkreis)
               linienfarbe.set() 
               var tempNumPunkt:NSPoint = NSMakePoint(lokalpunkt.x + 3, lokalpunkt.y + 3)
               let atts = [NSAttributedStringKey.font:NSFont.init(name: "Helvetica", size: 10)]
               let numstring = String(wegindex)
               numstring.draw(
                  at: tempNumPunkt, 
                  withAttributes: atts as [NSAttributedStringKey : Any])
               
               
            }
            //CNC_Stepper:
            /*
             NSRect tempMarkARect=NSMakeRect(lokalpunkt.x-4.1, lokalpunkt.y-4.1, 8.1, 8.1);
             tempMarkA=[NSBezierPath bezierPathWithOvalInRect:tempMarkARect];
             [[NSColor grayColor]set];
             [tempMarkA stroke];
             */
            //      weg.move(to: lokalpunkt)
            wegindex += 1
         }
         //     print("setWeg fahrtweg: \(fahrtweg) element count: \(elcount)")
         
         
         
      }
      else
      {
         linienfarbe.set() // choose color
         weg.lineWidth = 1.5
         weg.stroke()  // draw line(s) in color
         
         kreislinienfarbe.set() // choose color
         
         kreis.stroke()
         NSColor.green.set() 
         
      }
      
      // end neu
      NSColor.blue.set() // choose color
      achsen.stroke() 
      NSColor.red.set() // choose color
      kreuz.stroke()
      //   kreis.lineWidth = 1.5
      //    kreis.fill()
      //    kreis.stroke()
      
   }
   
   override func mouseDown(with theEvent: NSEvent) 
   {
      
      super.mouseDown(with: theEvent)
      //let ident  = self.identifier as! String
      let ident  = self.identifier
      
      //Swift.print("left mouse ident: \(ident)")
      var identstring = ""
      if let rawident:String = ident?.rawValue
      {
         identstring = rawident
      }
      else
      {
         identstring = "13"
         
      }
      
      let location = theEvent.locationInWindow
      //    Swift.print(location)
      //    NSPoint lokalpunkt = [self convertPoint: [anEvent locationInWindow] fromView: nil];
      let lokalpunkt = convert(theEvent.locationInWindow, from: nil)
      //    Swift.print(lokalpunkt)
      
      
      // setup the context
      // setup the context
      let dashHeight: CGFloat = 1
      let dashColor: NSColor = .green
      
      
      //    NSColor.blue.set() // choose color
      // https://stackoverflow.com/questions/47738822/simple-drawing-with-mouse-on-cocoa-swift
      //clearWeg()
      var userinformation:[String : Any]
      if kreuz.isEmpty
      {
         kreuz.move(to: lokalpunkt)
         // kreuz zeichnen
         kreuz.line(to: NSMakePoint(lokalpunkt.x, lokalpunkt.y+5))
         kreuz.line(to: lokalpunkt)
         kreuz.line(to: NSMakePoint(lokalpunkt.x+5, lokalpunkt.y))
         kreuz.line(to: lokalpunkt)
         kreuz.line(to: NSMakePoint(lokalpunkt.x, lokalpunkt.y-5))
         kreuz.line(to: lokalpunkt)
         kreuz.line(to: NSMakePoint(lokalpunkt.x-5, lokalpunkt.y))
         kreuz.line(to: lokalpunkt)
         
         // zurueck zu localpunkt
         weg.move(to: lokalpunkt)
         
         userinformation = ["message":"mousedown", "punkt": lokalpunkt, "index": weg.elementCount, "first": 1, "ident" :identstring] as [String : Any]
         //userinformation["ident"] = self.identifier
      }
      else
      {
         weg.line(to: lokalpunkt)
         
         userinformation = ["message":"mousedown", "punkt": lokalpunkt, "index": weg.elementCount, "first": 0, "ident" :identstring] as [String : Any]
         //userinformation["ident"] = self.identifier
      }
      
      let nc = NotificationCenter.default
      nc.post(name:Notification.Name(rawValue:"joystick"),
              object: nil,
              userInfo: userinformation)
      needsDisplay = true   
   }
   
   override func rightMouseDown(with theEvent: NSEvent) 
   {
      self.clearWeg()
      Swift.print("right mouse")
      let location = theEvent.locationInWindow
      Swift.print(location)
      needsDisplay = true
   }
   
   
   override func mouseDragged(with theEvent: NSEvent) 
   {
      Swift.print("mouseDragged")
      let location = theEvent.locationInWindow
      //Swift.print(location)
      var lokalpunkt = convert(theEvent.locationInWindow, from: nil)
      var userinformation:[String : Any]
      Swift.print(lokalpunkt)
      if (lokalpunkt.x >= self.bounds.size.width)
      {
         lokalpunkt.x = self.bounds.size.width
      }
      if (lokalpunkt.x <= 0)
      {
         lokalpunkt.x = 0
      }
      
      if (lokalpunkt.y > self.bounds.size.height)
      {
         lokalpunkt.y = self.bounds.size.height
      }
      if (lokalpunkt.y <= 0)
      {
         lokalpunkt.y = 0
      }     
      
      weg.line(to: lokalpunkt)
      
      
      
      needsDisplay = true
      userinformation = ["message":"mousedown", "punkt": lokalpunkt, "index": weg.elementCount, "first": -1] as [String : Any]
      userinformation["ident"] = self.identifier
      
      let nc = NotificationCenter.default
      nc.post(name:Notification.Name(rawValue:"joystick"),
              object: nil,
              userInfo: userinformation)
      
      
   }
   
   func hypotenuse(_ a: CGFloat, _ b: CGFloat) -> CGFloat 
   {
      return (a * a + b * b).squareRoot()
   }
   
   func setStepperposition(pos:Int)
   {
      stepperposition = pos
      drawstatus =  1
      //   print("\t ******   PlatteView setStepperposition pos: \(pos)")
      needsDisplay = true
   }
   
   
   func setWeg(newWeg:[[Int]], scalefaktor:Int , transform:Double)-> Int
   {
      weg.removeAllPoints()
      kreuz.removeAllPoints()
      kreis.removeAllPoints()
      for mark in markarray
      {
         mark.removeAllPoints()
      }
      markarray.removeAll()
      drawstatus = 0
      fahrtweg = 0
      redfaktor = 200.0
      transformfaktor = CGFloat(transform) // px to mm
      var wegindex=0;
      faktor = CGFloat(scalefaktor)
      var  tempMark:NSBezierPath
      var lastpunkt = NSMakePoint(0, 0)
      var elcount = 0
      
      wegarray = newWeg
      
      for zeile in newWeg
      {
         elcount += 1
         //  let x = CGFloat(zeile[0])
         let lokalpunkt = NSMakePoint(CGFloat(zeile[1])/faktor/redfaktor * transformfaktor,CGFloat(zeile[2])/faktor/redfaktor * transformfaktor)
         //print(lokalpunkt)
         if wegindex == 0
         {
            lastpunkt = lokalpunkt
            weg.move(to: lokalpunkt)
            
         }
         else
         {
            let dx = lokalpunkt.x - lastpunkt.x
            let dy = lokalpunkt.y - lastpunkt.y
            fahrtweg += hypotenuse(dx, dy)
            lastpunkt = lokalpunkt
            weg.line(to: lokalpunkt)
         }
         //CNC_Stepper:
         /*
          NSRect tempMarkARect=NSMakeRect(lokalpunkt.x-4.1, lokalpunkt.y-4.1, 8.1, 8.1);
          tempMarkA=[NSBezierPath bezierPathWithOvalInRect:tempMarkARect];
          [[NSColor grayColor]set];
          [tempMarkA stroke];
          */
         var tempMarkRect:NSRect = NSMakeRect(lokalpunkt.x-4.1, lokalpunkt.y-4.1, 8.1, 8.1);
         // tempMark=[NSBezierPath bezierPathWithOvalInRect:tempMarkRect]
         kreis.move(to: lokalpunkt)
         kreis.appendOval(in: tempMarkRect)
         //      weg.move(to: lokalpunkt)
         /*
          var tempNumPunkt:NSPoint = NSMakePoint(lokalpunkt.x + 3, lokalpunkt.y + 3)
          let atts = [NSAttributedStringKey.font:NSFont.init(name: "Helvetica", size: 10)]
          let numstring = String(wegindex)
          //       print(numstring)
          numstring.draw(
          at: tempNumPunkt, 
          withAttributes: atts as [NSAttributedStringKey : Any])
          */
         wegindex += 1
      }
      //print("setWeg fahrtweg: \(fahrtweg) element count: \(elcount)")
      
      needsDisplay = true
      return Int(fahrtweg)
   }
   
   
   
   func clearWeg()
   {
      Swift.print( "clearWeg" )
      weg.removeAllPoints()
      kreuz.removeAllPoints()
      kreis.removeAllPoints()
  
      let clearColor: NSColor = .clear
      for mark in markarray
      {
 //        clearColor.set()
 //        mark.stroke()
         mark.removeAllPoints()
      }
      markarray.removeAll()
      needsDisplay = true
      
   }
   /*
    override func rotate(byDegrees angle: CGFloat) 
    {
    var transform = NSAffineTransform()
    transform.rotate(byDegrees: angle)
    weg.transform(using: transform as AffineTransform)
    }
    */
   override func keyDown(with theEvent: NSEvent)
   {
      Swift.print( "Key Pressed" )
   }
   
} // rPlatteView

