//
//  rCNC.swift
//  CNC_Mill
//
//  Created by Ruedi Heimlicher on 03.06.2020.
//  Copyright © 2020 Ruedi Heimlicher. All rights reserved.
//

import Foundation

class rCNC
{
   var DatenArray:[[String:Int]] = [[String:Int]]()
   var        speed:Int = 10
   var      steps:Int = 48
   var   red_pwm:Double = 0.4 // fuer Abschnitte mit red Heizleistung (Weg schon geschnitten
   
   
   
   func SteuerdatenVonDic(derDatenDic:[String:Any]) -> [String:Int]
   {
      /*
       Berechnet Angaben fuer den StepperController aus den Koordinaten von Startpunkt, Endpunkt, zoomfaktor.
       fuer EINEN linearen Abschnitt
       Rueckgabe:
       Dic mit Daten:
       schrittex, schrittey: Schritte in x und y-Richtung
       
       Datenbreite ist 15 bit. 
       Negative Zahlen werden invertiert und 0x8000 dazugezaehlt 
       
       delayx, delayy:   Zeit fuer einen Schritt in x/y-Richtung, Einheit 100us
       */
      
      var steuerdatendic:[String:Int] = [:]
      
  //    var  anzSchritte:Int = 0;
  //    var  anzaxplus:Int=0;
  //    var  anzaxminus:Int=0;
  //    var  anzayplus:Int=0;
  //    var  anzayminus:Int=0;
      
  //    var  anzbxplus:Int=0;
  //    var  anzbxminus:Int=0;
 //     var  anzbyplus:Int=0;
  //    var  anzbyminus:Int=0;
      
      var code:Int = 0
      
      if derDatenDic.count == 0
      {
         return steuerdatendic
      }
      
      if derDatenDic["code"] != nil
      {
         code = (derDatenDic["zoomfaktor"] as! Int)
      }
      var zoomfaktor:Double = (derDatenDic["zoomfaktor"] as! Double)
      
      var StartPunkt:NSPoint = NSPointFromString(derDatenDic["startpunkt"] as! String)
      
      
      
      
      
      return steuerdatendic
   }
   
}// rCNC
