//
//  rTSP_NN.swift
//  CNC_Mill
//
//  Created by Ruedi Heimlicher on 09.08.2020.
//  Copyright © 2020 Ruedi Heimlicher. All rights reserved.
// http://www.u-helmich.de/inf/TSP/TSP-NN2.html

import Foundation

struct millpkt
{
   var nummer:Int = 0
   var mx:Double = 0
   var my:Double = 0
   var name:String = ""
   var next:Int = 0
   var inTour:Bool = false
  
}


class rTSP_NN:NSObject
{
   var plan = [millpkt]()
   var anzahl = 0
    var weg = [Int]()
   override init() {
      
   }
   func setkoordinaten(koord:[[Double]])
   {
      var zeilenindex = 0
      plan.removeAll()
      weg.removeAll()
      for zeile in koord
      {
         var newpunkt:millpkt = millpkt()
         newpunkt.inTour = false
         newpunkt.nummer = zeilenindex
         newpunkt.mx = zeile[1]
         newpunkt.my = zeile[2]
         newpunkt.nummer = zeilenindex
         newpunkt.name = String(zeilenindex)
         plan.append(newpunkt)
         zeilenindex += 1
      }
      anzahl = koord.count
      
   }
   func firstrun()
   {
      if plan.count > 0
      {
         var index:Int = 0
         for zeile in plan
         {
           
            if index < plan.count
            {
               //print("zeile: \(zeile)")
               plan[index].next = index + 1
               index += 1
            }
            
         }
         plan[anzahl - 1].next = 0
      }
      //print("firstrun plan: \(plan)")
   }// firstrun
   
   func entfernung(a:Int, b:Int)->Double
   {
      let dx = plan[a].mx - plan[b].mx
      let dy = plan[a].my - plan[b].my
      return (dx*dx + dy*dy).squareRoot()
   }
   func nextmillpunkt(aktuellerpunkt:Int)->(Int)
   {
      var mindist:Double = Double(Int.max)
      var distanz:Double = Double(Int.max)
      var start:Int = 0
      var nextpunktindex:Int = 0
//      print("\n\n+++ nextmillpunkt aktuellerpunkt: \(aktuellerpunkt)")
      while start < anzahl
      {
         // ersten punkt suchen, der noch  frei ist
         while start < anzahl && plan[start].inTour == true
         {
            start += 1
         }
         if start >= anzahl
         {
            break
         }
//         print("     neuer start: \(start)")
         let tempdist = entfernung(a:aktuellerpunkt, b: start)
//         print("tempdist: \(tempdist)")
         if start != aktuellerpunkt && tempdist < mindist
         {
//           print("               neue  mindist: \(mindist) tempdist: \(tempdist)")
            mindist = tempdist
            nextpunktindex = start
         }
         
//         print("nextpunktindex: \(nextpunktindex) mindist: \(mindist)")   
         start += 1
      }
      return nextpunktindex
   }// nextmillpunkt
   
   func nearestneighbour()
   {
      var s:Int = 0
      var i = 0
      weg.append(0)
      if anzahl == 0
      {
         return
      }
      for i in 0..<anzahl-1
      {
         plan[s].inTour = true
         let n = nextmillpunkt(aktuellerpunkt: s)
         plan[s].next = n
         s = n
         weg.append(s)
      }
      plan[s].inTour = true
      plan[s].next = 0
      
 //     print("nearestneighbour weg: \(weg)")
   }
   
}

