//
//  defines.swift
//  Robot_Interface
//
//  Created by Ruedi Heimlicher on 28.07.2019.
//  Copyright © 2019 Ruedi Heimlicher. All rights reserved.
//

import Foundation

// CNC PCB
let PFEILSCHRITT:UInt8  =   4

let LINE:UInt8  =           0
let MANRIGHT:UInt8  =       1
let MANUP:UInt8  =          2
let MANLEFT:UInt8  =       3
let MANDOWN:UInt8  =        4

let STEPEND_A:UInt8  =            0x00        // Motor A hat Ende der Steps erreicht
let STEPEND_B:UInt8  =            0x10
let STEPEND_C :UInt8  =           0x20
let STEPEND_D:UInt8  =            0x30



let FIRST_BIT:UInt8  =         0 // in 'position' von reportStopKnopf: Abschnitt ist first
let LAST_BIT:UInt8  =          1 // in 'position' von reportStopKnopf: Abschnitt ist last


let GOTO_0:UInt8  =  0xA7
let SET_RING:UInt8  =  0xA3
let CLEAR_RING:UInt8  =  0xA4
let END_RING: UInt8 = 0xA5

let SET_WEG:UInt8  =  0xA6
let CLEAR_WEG:UInt8  =  0xA7
let END_WEG:UInt8  =  0xA8

let DREHKNOPF:UInt8 = 0xAA

let ACHSE0_START:UInt16 = 0x7FF // Startwert low
let ACHSE0_MAX:UInt16 = 0xFFF // Startwert high
let FAKTOR0:Double = 1.6


let ACHSE1_START:UInt16 = 600 // Startwert low
let ACHSE1_MAX:UInt16 = 2100 // Startwert high
let FAKTOR1:Double = 1.6


let ACHSE2_START:UInt16 = 300 // Startwert low
let ACHSE2_MAX:UInt16 = 1800 // Startwert high
let FAKTOR2:Double = 1.6


let ACHSE3_START:UInt16 = 0x7FF // Startwert low
let ACHSE3_MAX:UInt16 = 0xFFF // Startwert high
let FAKTOR3:Double = 1.6

let DREHKNOPF_START:UInt16 = 0x7FF
let DREHKNOPF_FAKTOR:Double = 18.1 // Anpassen auf Mitte bei 3272


// Trigo
//let ACHSE1_MAX:Double = 1800
//let ACHSE1_START:Double = 600
//let ACHSE2_START:Double = 1800
//let ACHSE2_MAX:Double = 300
